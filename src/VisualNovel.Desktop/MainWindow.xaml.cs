using System.Windows;
using Microsoft.AspNetCore.Components.WebView;
using Microsoft.Web.WebView2.Core;

namespace VisualNovel.Desktop;

public partial class MainWindow : Window
{
    // Bootstrap injected before page scripts. It defines window.visualNovelHost, which
    // interaction.js prefers over the DOM Fullscreen API, and relays toggle requests to
    // the WPF host so fullscreen covers the whole OS window (title bar + taskbar), not
    // just the WebView's content area.
    private const string HostBootstrap = @"
(function () {
    if (window.visualNovelHost) return;
    window.visualNovelHost = {
        _fs: false,
        isFullscreen: function () { return window.visualNovelHost._fs; },
        setFullscreen: function (v) { window.chrome.webview.postMessage(v ? 'fullscreen:on' : 'fullscreen:off'); }
    };
    window.chrome.webview.addEventListener('message', function (e) {
        var d = e.data;
        if (d === 'fullscreen-state:on' || d === 'fullscreen-state:off') {
            window.visualNovelHost._fs = (d === 'fullscreen-state:on');
            document.dispatchEvent(new Event('fullscreenchange'));
        }
    });
})();";

    private CoreWebView2? _core;
    private bool _isFullscreen;
    private WindowState _savedState = WindowState.Normal;
    private WindowStyle _savedStyle = WindowStyle.SingleBorderWindow;
    private ResizeMode _savedResize = ResizeMode.CanResize;

    public MainWindow()
    {
        InitializeComponent();
        Blazor.Services = ((App)Application.Current).Services;
        Blazor.BlazorWebViewInitialized += OnBlazorWebViewInitialized;
    }

    private void OnBlazorWebViewInitialized(object? sender, BlazorWebViewInitializedEventArgs e)
    {
        _core = e.WebView.CoreWebView2;
        _ = _core.AddScriptToExecuteOnDocumentCreatedAsync(HostBootstrap);
        _core.WebMessageReceived += OnWebMessageReceived;
        // The pause-menu Exit button calls window.close(); honor it by closing the app.
        _core.WindowCloseRequested += (_, _) => Dispatcher.Invoke(Close);
    }

    private void OnWebMessageReceived(object? sender, CoreWebView2WebMessageReceivedEventArgs e)
    {
        string message;
        try { message = e.TryGetWebMessageAsString(); }
        catch { return; }

        switch (message)
        {
            case "fullscreen:on": SetFullscreen(true); break;
            case "fullscreen:off": SetFullscreen(false); break;
        }
    }

    private void SetFullscreen(bool on)
    {
        if (on == _isFullscreen) return;

        if (on)
        {
            _savedState = WindowState;
            _savedStyle = WindowStyle;
            _savedResize = ResizeMode;

            WindowStyle = WindowStyle.None;
            ResizeMode = ResizeMode.NoResize;
            // Toggle through Normal so a borderless Maximized recalculates to cover the taskbar.
            WindowState = WindowState.Normal;
            WindowState = WindowState.Maximized;
            _isFullscreen = true;
        }
        else
        {
            WindowStyle = _savedStyle;
            ResizeMode = _savedResize;
            WindowState = _savedState;
            _isFullscreen = false;
        }

        _core?.PostWebMessageAsString(_isFullscreen ? "fullscreen-state:on" : "fullscreen-state:off");
    }
}

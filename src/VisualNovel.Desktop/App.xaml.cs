using System.IO;
using System.Windows;
using Microsoft.Extensions.DependencyInjection;
using VisualNovel.Shared.Services;

namespace VisualNovel.Desktop;

public partial class App : Application
{
    public IServiceProvider Services { get; }

    public App()
    {
        var services = new ServiceCollection();
        services.AddWpfBlazorWebView();
#if DEBUG
        services.AddBlazorWebViewDeveloperTools();
#endif

        services.AddSingleton<StoryService>();
        services.AddSingleton<SettingsService>();
        services.AddSingleton<SaveService>();
        services.AddSingleton<MusicService>();

        Services = services.BuildServiceProvider();

        // StoryService.LoadFromJson is pure (no JS interop), so the compiled Ink story
        // can be parsed here at startup. The localStorage-backed settings/save services
        // load later from inside Main.razor once the WebView (and its JS runtime) exists.
        var story = Services.GetRequiredService<StoryService>();
        story.LoadFromJson(ReadStoryJson());
    }

    private static string ReadStoryJson()
    {
        var path = Path.Combine(AppContext.BaseDirectory, "story.json");
        return File.ReadAllText(path);
    }
}

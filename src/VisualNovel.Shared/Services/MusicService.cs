using Microsoft.JSInterop;

namespace VisualNovel.Shared.Services;

// Thin JS-interop wrapper for the ambient music engine in wwwroot/js/audio.js.
// All calls are best-effort; failures are swallowed so audio is never load-bearing.
public sealed class MusicService
{
    private readonly IJSRuntime _js;

    public MusicService(IJSRuntime js) => _js = js;

    public async Task StartAsync()
    {
        try { await _js.InvokeVoidAsync("ambient.start"); } catch { }
    }

    public async Task SetSceneMoodAsync(int scene)
    {
        try { await _js.InvokeVoidAsync("ambient.setSceneMood", scene); } catch { }
    }

    public async Task SetMasterVolumeAsync(double v)
    {
        try { await _js.InvokeVoidAsync("ambient.setMasterVolume", v); } catch { }
    }

    public async Task SetMusicVolumeAsync(double v)
    {
        try { await _js.InvokeVoidAsync("ambient.setMusicVolume", v); } catch { }
    }

    public async Task StopAsync()
    {
        try { await _js.InvokeVoidAsync("ambient.stop"); } catch { }
    }
}

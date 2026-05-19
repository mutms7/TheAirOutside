using System.Text.Json;
using Microsoft.JSInterop;

namespace VisualNovel.Shared.Services;

public sealed class GameSettings
{
    public bool AutoAdvance { get; set; } = false;
    public double AutoAdvanceDelay { get; set; } = 3.5;
    public double TextFadeMs { get; set; } = 150;
    public double MasterVolume { get; set; } = 0.8;
    public double MusicVolume { get; set; } = 0.7;
    public double SfxVolume { get; set; } = 0.8;
    public string Theme { get; set; } = "light";
    public bool ReduceMotion { get; set; } = false;
    public double TextSize { get; set; } = 1.0;
}

public sealed class SettingsService
{
    private const string StorageKey = "the-air-outside.settings";
    private readonly IJSRuntime _js;

    public GameSettings Current { get; private set; } = new();
    public event Action? Changed;

    public SettingsService(IJSRuntime js)
    {
        _js = js;
    }

    public async Task LoadAsync()
    {
        try
        {
            var json = await _js.InvokeAsync<string?>("localStorage.getItem", StorageKey);
            if (!string.IsNullOrEmpty(json))
            {
                var loaded = JsonSerializer.Deserialize<GameSettings>(json);
                if (loaded is not null) Current = loaded;
            }
        }
        catch
        {
            Current = new GameSettings();
        }
        Changed?.Invoke();
    }

    public async Task SaveAsync()
    {
        var json = JsonSerializer.Serialize(Current);
        await _js.InvokeVoidAsync("localStorage.setItem", StorageKey, json);
        Changed?.Invoke();
    }

    public async Task UpdateAsync(Action<GameSettings> mutate)
    {
        mutate(Current);
        await SaveAsync();
    }
}

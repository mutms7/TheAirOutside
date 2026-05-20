using System.Text.Json;
using Microsoft.JSInterop;

namespace VisualNovel.Shared.Services;

public sealed class SaveProgress
{
    public int[] VisitedScenes { get; set; } = Array.Empty<int>();
    public int LastScene { get; set; }
    public DateTime LastUpdated { get; set; }
    public bool PrologueDone { get; set; }
    public string ProtagonistName { get; set; } = "Wren";
}

public sealed class SaveService
{
    private const string StorageKey = "the-air-outside.progress";
    private readonly IJSRuntime _js;

    public SaveProgress Current { get; private set; } = new();
    public bool HasSave => Current.VisitedScenes.Length > 0;
    public event Action? Changed;

    public SaveService(IJSRuntime js) { _js = js; }

    public async Task LoadAsync()
    {
        try
        {
            var json = await _js.InvokeAsync<string?>("localStorage.getItem", StorageKey);
            if (!string.IsNullOrEmpty(json))
            {
                var loaded = JsonSerializer.Deserialize<SaveProgress>(json);
                if (loaded is not null) Current = loaded;
            }
        }
        catch
        {
            Current = new SaveProgress();
        }
        Changed?.Invoke();
    }

    public async Task SaveAsync(IEnumerable<int> visited, int lastScene, bool prologueDone = false, string protagonistName = "Wren")
    {
        Current.VisitedScenes = visited.ToArray();
        Current.LastScene = lastScene;
        Current.LastUpdated = DateTime.UtcNow;
        Current.PrologueDone = prologueDone;
        Current.ProtagonistName = protagonistName;
        var json = JsonSerializer.Serialize(Current);
        try
        {
            await _js.InvokeVoidAsync("localStorage.setItem", StorageKey, json);
        }
        catch { /* localStorage full or unavailable, skip silently */ }
        Changed?.Invoke();
    }

    public async Task ClearAsync()
    {
        Current = new SaveProgress();
        try
        {
            await _js.InvokeVoidAsync("localStorage.removeItem", StorageKey);
        }
        catch { }
        Changed?.Invoke();
    }
}

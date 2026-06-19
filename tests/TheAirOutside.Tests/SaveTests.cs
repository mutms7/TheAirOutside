using System.Text.Json;
using VisualNovel.Shared.Services;
using Xunit;

namespace TheAirOutside.Tests;

public class SaveTests
{
    // FR-SAVE-001: storage key constant
    [Fact]
    public void SaveService_ProgressKey_IsExpectedValue()
    {
        var field = typeof(SaveService)
            .GetField("StorageKey", System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Static);
        Assert.NotNull(field);
        Assert.Equal("the-air-outside.progress", field!.GetValue(null));
    }

    // FR-SAVE-002: settings key constant
    [Fact]
    public void SettingsService_SettingsKey_IsExpectedValue()
    {
        var field = typeof(SettingsService)
            .GetField("StorageKey", System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Static);
        Assert.NotNull(field);
        Assert.Equal("the-air-outside.settings", field!.GetValue(null));
    }

    // FR-SAVE-003: SaveProgress schema has exactly 5 fields and ProtagonistName defaults to "Wren"
    [Fact]
    public void SaveProgress_HasExactly5Properties()
    {
        var props = typeof(SaveProgress).GetProperties();
        Assert.Equal(5, props.Length);
    }

    [Fact]
    public void SaveProgress_ProtagonistName_DefaultsToWren()
    {
        Assert.Equal("Wren", new SaveProgress().ProtagonistName);
    }

    [Fact]
    public void SaveProgress_VisitedScenes_DefaultsToEmpty()
    {
        Assert.Empty(new SaveProgress().VisitedScenes);
    }

    // FR-SAVE-003: round-trip JSON serialization preserves all fields
    [Fact]
    public void SaveProgress_JsonRoundTrip_PreservesAllFields()
    {
        var original = new SaveProgress
        {
            VisitedScenes = new[] { 1, 2, 3 },
            LastScene = 3,
            LastUpdated = new DateTime(2026, 1, 1, 0, 0, 0, DateTimeKind.Utc),
            PrologueDone = true,
            ProtagonistName = "Alex"
        };

        var json = JsonSerializer.Serialize(original);
        var restored = JsonSerializer.Deserialize<SaveProgress>(json)!;

        Assert.Equal(original.VisitedScenes, restored.VisitedScenes);
        Assert.Equal(original.LastScene, restored.LastScene);
        Assert.Equal(original.PrologueDone, restored.PrologueDone);
        Assert.Equal(original.ProtagonistName, restored.ProtagonistName);
    }
}

using System.Text.Json;
using VisualNovel.Shared.Services;
using Xunit;

namespace TheAirOutside.Tests;

public class SceneRegistryTests
{
    // FR-NARR-001: exactly 15 scenes, IDs 1-15
    [Fact]
    public void SceneRegistry_HasExactly15Scenes()
    {
        Assert.Equal(15, SceneRegistry.Scenes.Count);
    }

    [Fact]
    public void SceneRegistry_SceneIds_Are1Through15()
    {
        var ids = SceneRegistry.Scenes.Select(s => s.Id).OrderBy(x => x).ToList();
        Assert.Equal(Enumerable.Range(1, 15).ToList(), ids);
    }

    [Fact]
    public void SceneRegistry_AllScenes_HaveNonEmptyKnotAndTitle()
    {
        Assert.All(SceneRegistry.Scenes, s =>
        {
            Assert.False(string.IsNullOrWhiteSpace(s.Knot));
            Assert.False(string.IsNullOrWhiteSpace(s.Title));
        });
    }

    // FR-NARR-002: exactly 4 gates with correct option counts
    [Fact]
    public void GateOptions_HasExactly4Gates()
    {
        Assert.Equal(4, GateOptions.ByGate.Count);
        Assert.True(GateOptions.ByGate.ContainsKey("gate1"));
        Assert.True(GateOptions.ByGate.ContainsKey("gate2"));
        Assert.True(GateOptions.ByGate.ContainsKey("gate3"));
        Assert.True(GateOptions.ByGate.ContainsKey("gate4"));
    }

    [Fact]
    public void GateOptions_Gate1_Has3Choices()
    {
        Assert.Equal(3, GateOptions.ByGate["gate1"].Count);
    }

    [Fact]
    public void GateOptions_Gate2_Has2Choices()
    {
        Assert.Equal(2, GateOptions.ByGate["gate2"].Count);
    }

    [Fact]
    public void GateOptions_Gate3_Has3Choices()
    {
        Assert.Equal(3, GateOptions.ByGate["gate3"].Count);
    }

    [Fact]
    public void GateOptions_Gate4_Has3Choices()
    {
        Assert.Equal(3, GateOptions.ByGate["gate4"].Count);
    }

    [Fact]
    public void SceneRegistry_Gate1_IsScene4()
    {
        var scene = SceneRegistry.Scenes.Single(s => s.Gate == "gate1");
        Assert.Equal(4, scene.Id);
    }

    [Fact]
    public void SceneRegistry_Gate2_IsScene5()
    {
        var scene = SceneRegistry.Scenes.Single(s => s.Gate == "gate2");
        Assert.Equal(5, scene.Id);
    }

    [Fact]
    public void SceneRegistry_Gate3_IsScene12()
    {
        var scene = SceneRegistry.Scenes.Single(s => s.Gate == "gate3");
        Assert.Equal(12, scene.Id);
    }

    [Fact]
    public void SceneRegistry_Gate4_IsScene14()
    {
        var scene = SceneRegistry.Scenes.Single(s => s.Gate == "gate4");
        Assert.Equal(14, scene.Id);
    }
}

public class StoryJsonTests
{
    private static readonly string StoryJsonPath =
        Path.Combine(AppContext.BaseDirectory, "..", "..", "..", "..", "..",
            "src", "VisualNovel.Shared", "wwwroot", "story.json");

    // FR-BUILD-002: story.json parses and has inkVersion
    [Fact]
    public void StoryJson_IsValidJson_WithInkVersionField()
    {
        Assert.True(File.Exists(StoryJsonPath), $"story.json not found at {StoryJsonPath}. Run InkBuild first.");
        var json = File.ReadAllText(StoryJsonPath);
        var doc = JsonDocument.Parse(json);
        Assert.True(doc.RootElement.TryGetProperty("inkVersion", out var v));
        Assert.True(v.GetInt32() > 0);
    }

    // FR-NARR-004: pause: climax-window appears exactly once per gate3 branch (3 branches = 3 tags)
    // One per branch (iris/stay/tae); each playthrough path encounters it exactly once.
    [Fact]
    public void InkFiles_ClimaxWindowTag_AppearsOncePerBranch()
    {
        var inkDir = Path.Combine(AppContext.BaseDirectory, "..", "..", "..", "..", "..", "ink");
        Assert.True(Directory.Exists(inkDir), $"ink/ dir not found at {inkDir}");
        var files = Directory.GetFiles(inkDir, "*.ink", SearchOption.AllDirectories);
        // Count only non-comment lines (exclude // lines)
        var count = files.Sum(f =>
            File.ReadAllLines(f)
                .Where(l => !l.TrimStart().StartsWith("//"))
                .Count(l => l.Contains("pause: climax-window")));
        Assert.Equal(3, count); // one per gate3 branch: iris / stay / tae
    }

    // NFR-NARR-001: no em-dashes in player-visible prose (comments excluded)
    [Fact]
    public void InkFiles_ContainNoEmDashesInProse()
    {
        var inkDir = Path.Combine(AppContext.BaseDirectory, "..", "..", "..", "..", "..", "ink");
        var files = Directory.GetFiles(inkDir, "*.ink", SearchOption.AllDirectories);
        foreach (var file in files)
        {
            var proseLines = File.ReadAllLines(file)
                .Where(l => !l.TrimStart().StartsWith("//"));
            foreach (var line in proseLines)
                Assert.False(line.Contains('—'),
                    $"Em-dash in prose line in {Path.GetFileName(file)}: {line.Trim()}");
        }
    }

    // NFR-NARR-003: pacing: slow appears in exactly the 7 expected scene files
    [Theory]
    [InlineData("01-cold-open.ink")]
    [InlineData("03-dexterity.ink")]
    [InlineData("05-hallway.ink")]
    [InlineData("07-crushed.ink")]
    [InlineData("11-night-hallway.ink")]
    [InlineData("13-step-outside.ink")]
    [InlineData("15-coda.ink")]
    public void SlowPacing_Scenes_ContainPacingSlowTag(string fileName)
    {
        var inkDir = Path.Combine(AppContext.BaseDirectory, "..", "..", "..", "..", "..", "ink", "scenes");
        var path = Path.Combine(inkDir, fileName);
        Assert.True(File.Exists(path), $"Scene file not found: {path}");
        Assert.Contains("pacing: slow", File.ReadAllText(path));
    }

    // NFR-BUILD-001: no audio files in wwwroot
    [Fact]
    public void Wwwroot_ContainsNoAudioFiles()
    {
        var wwwroot = Path.Combine(AppContext.BaseDirectory, "..", "..", "..", "..", "..",
            "src", "VisualNovel.Shared", "wwwroot");
        if (!Directory.Exists(wwwroot)) return;
        string[] audioExtensions = { ".mp3", ".ogg", ".wav", ".flac", ".m4a", ".aac", ".opus" };
        var found = Directory.GetFiles(wwwroot, "*", SearchOption.AllDirectories)
            .Where(f => audioExtensions.Contains(Path.GetExtension(f).ToLowerInvariant()))
            .ToList();
        Assert.Empty(found);
    }

    private static int CountOccurrences(string text, string pattern)
    {
        int count = 0, index = 0;
        while ((index = text.IndexOf(pattern, index, StringComparison.Ordinal)) >= 0)
        {
            count++; index += pattern.Length;
        }
        return count;
    }
}

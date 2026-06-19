using Ink;
using VisualNovel.Shared.Services;
using Xunit;

namespace TheAirOutside.Tests;

// Tests require a compiled story. This helper compiles a minimal Ink script inline
// using the same Qyl27.Ink.Compiler the production InkBuild project uses.
public static class InkHelper
{
    public static string CompileMinimal(string inkSource)
    {
        var compiler = new Compiler(inkSource);
        var story = compiler.Compile();
        return story.ToJson();
    }
}

public class StoryServiceTests
{
    private static StoryService LoadStory(string inkSource)
    {
        var json = InkHelper.CompileMinimal(inkSource);
        var svc = new StoryService();
        svc.LoadFromJson(json);
        return svc;
    }

    // FR-STORY-001: CurrentText is trimmed on advance
    [Fact]
    public void Advance_TrimsWhitespace_FromCurrentText()
    {
        var svc = LoadStory("Hello world\n-> DONE");
        svc.Start();
        Assert.Equal("Hello world", svc.CurrentText);
    }

    // FR-STORY-002: choices are populated and Choose drives them
    [Fact]
    public void Choose_SelectsCorrectBranch()
    {
        var svc = LoadStory("-> q\n=== q\n* [A] got-a -> DONE\n* [B] got-b -> DONE");
        svc.Start();
        Assert.Equal(2, svc.CurrentChoices.Count);
        svc.Choose(0);
        Assert.Equal("got-a", svc.CurrentText);
    }

    // FR-STORY-003: GoBack returns false at index 0
    [Fact]
    public void GoBack_AtStart_ReturnsFalse()
    {
        var svc = LoadStory("Line one\n-> DONE");
        svc.Start();
        var result = svc.GoBack();
        Assert.False(result);
    }

    // FR-STORY-003: GoBack after advance restores previous text
    [Fact]
    public void GoBack_AfterAdvance_RestoresPreviousText()
    {
        var svc = LoadStory("Line one\nLine two\n-> DONE");
        svc.Start();
        var first = svc.CurrentText;
        svc.Advance();
        svc.GoBack();
        Assert.Equal(first, svc.CurrentText);
    }

    // FR-STORY-004: replay advances through snapshot cache
    [Fact]
    public void Advance_WhenInHistory_ReplaysCachedState()
    {
        var svc = LoadStory("Line one\nLine two\n-> DONE");
        svc.Start();
        svc.Advance();
        var secondText = svc.CurrentText;
        svc.GoBack();
        svc.Advance();
        Assert.Equal(secondText, svc.CurrentText);
    }

    // FR-STORY-006: empty name defaults to "Wren"
    [Fact]
    public void SetProtagonistName_EmptyInput_DefaultsToWren()
    {
        var svc = LoadStory("VAR protagonist_name = \"\"\nHello\n-> DONE");
        svc.SetProtagonistName("");
        Assert.Equal("Wren", svc.GetVar("protagonist_name"));
    }

    // FR-STORY-006: whitespace-only name defaults to "Wren"
    [Fact]
    public void SetProtagonistName_WhitespaceInput_DefaultsToWren()
    {
        var svc = LoadStory("VAR protagonist_name = \"\"\nHello\n-> DONE");
        svc.SetProtagonistName("   ");
        Assert.Equal("Wren", svc.GetVar("protagonist_name"));
    }

    // FR-STORY-006: non-empty name is preserved
    [Fact]
    public void SetProtagonistName_NonEmpty_Preserved()
    {
        var svc = LoadStory("VAR protagonist_name = \"\"\nHello\n-> DONE");
        svc.SetProtagonistName("  Alex  ");
        Assert.Equal("Alex", svc.GetVar("protagonist_name"));
    }

    // FR-STORY-007: scene tag sets Scene and adds to VisitedScenes
    [Fact]
    public void Advance_SceneTag_SetsSceneAndVisited()
    {
        var svc = LoadStory("# scene: 3\nLine\n-> DONE");
        svc.Start();
        Assert.Equal(3, svc.Scene);
        Assert.Contains(3, svc.VisitedScenes);
    }

    // FR-STORY-008: climax-window tag sets IsClimaxPause
    [Fact]
    public void Advance_ClimaxWindowTag_SetsIsClimaxPause()
    {
        var svc = LoadStory("# pause: climax-window\nLook up if you'd like.\n-> DONE");
        svc.Start();
        Assert.True(svc.IsClimaxPause);
    }

    // FR-STORY-009: ending tag sets EndingTitle
    [Fact]
    public void Advance_EndingTag_SetsEndingTitle()
    {
        var svc = LoadStory("# ending: Together, Outside\nFin.\n-> DONE");
        svc.Start();
        Assert.Equal("Together, Outside", svc.EndingTitle);
    }

    // FR-STORY-010: IsEnded is false before content is consumed, true once exhausted
    [Fact]
    public void IsEnded_BeforeStart_IsFalse()
    {
        var svc = new StoryService();
        svc.LoadFromJson(InkHelper.CompileMinimal("Line\n-> DONE"));
        Assert.False(svc.IsEnded);
    }

    [Fact]
    public void IsEnded_AfterAllContentConsumed_IsTrue()
    {
        var svc = LoadStory("Line\n-> DONE");
        svc.Start();
        while (svc.CanAdvance) svc.Advance();
        Assert.True(svc.IsEnded);
    }

    // NFR-STORY-001: snapshot record has 13 fields (verified structurally via reflection)
    [Fact]
    public void StorySnapshot_HasExactly13Fields()
    {
        var snapshotType = typeof(StoryService).GetNestedTypes(
            System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Public)
            .FirstOrDefault(t => t.Name.Contains("StorySnapshot"));
        Assert.NotNull(snapshotType);
        var props = snapshotType!.GetProperties();
        Assert.Equal(13, props.Length);
    }
}

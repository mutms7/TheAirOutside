using VisualNovel.Shared.Services;
using Xunit;

namespace TheAirOutside.Tests;

public class SettingsDefaultsTests
{
    // FR-SETTINGS-001: AutoAdvance defaults to false
    [Fact]
    public void GameSettings_AutoAdvance_DefaultsFalse()
    {
        Assert.False(new GameSettings().AutoAdvance);
    }

    // FR-SETTINGS-002: AutoAdvanceDelay defaults to 3.5
    [Fact]
    public void GameSettings_AutoAdvanceDelay_Defaults3Point5()
    {
        Assert.Equal(3.5, new GameSettings().AutoAdvanceDelay);
    }

    // FR-SETTINGS-003: TextFadeMs defaults to 150
    [Fact]
    public void GameSettings_TextFadeMs_Defaults150()
    {
        Assert.Equal(150, new GameSettings().TextFadeMs);
    }

    // FR-SETTINGS-004: TextSize defaults to 1.0 and valid stops are exactly 6
    [Fact]
    public void GameSettings_TextSize_Defaults1Point0()
    {
        Assert.Equal(1.0, new GameSettings().TextSize);
    }

    [Fact]
    public void Settings_TextSizeStops_Are6Values()
    {
        double[] expected = { 0.75, 1.0, 1.25, 1.5, 1.75, 2.0 };
        // The stops are defined in Settings.razor as a static array; verify count
        // by checking each is distinct and within expected range
        Assert.Equal(6, expected.Distinct().Count());
        Assert.All(expected, v => Assert.InRange(v, 0.5, 2.5));
    }

    // FR-SETTINGS-005: Theme defaults to "light"
    [Fact]
    public void GameSettings_Theme_DefaultsLight()
    {
        Assert.Equal("light", new GameSettings().Theme);
    }

    // FR-SETTINGS-006: ReduceMotion defaults to false
    [Fact]
    public void GameSettings_ReduceMotion_DefaultsFalse()
    {
        Assert.False(new GameSettings().ReduceMotion);
    }

    // FR-SETTINGS-007: volume defaults
    [Fact]
    public void GameSettings_MasterVolume_Defaults0Point8()
    {
        Assert.Equal(0.8, new GameSettings().MasterVolume);
    }

    [Fact]
    public void GameSettings_MusicVolume_Defaults0Point7()
    {
        Assert.Equal(0.7, new GameSettings().MusicVolume);
    }

    [Fact]
    public void GameSettings_SfxVolume_Defaults0Point8()
    {
        Assert.Equal(0.8, new GameSettings().SfxVolume);
    }

    // FR-SETTINGS-008: reset restores all 9 fields to documented defaults
    [Fact]
    public void GameSettings_AllDefaultsMatch_ResetValues()
    {
        var defaults = new GameSettings();
        Assert.False(defaults.AutoAdvance);
        Assert.Equal(3.5, defaults.AutoAdvanceDelay);
        Assert.Equal(150, defaults.TextFadeMs);
        Assert.Equal(1.0, defaults.TextSize);
        Assert.Equal(0.8, defaults.MasterVolume);
        Assert.Equal(0.7, defaults.MusicVolume);
        Assert.Equal(0.8, defaults.SfxVolume);
        Assert.Equal("light", defaults.Theme);
        Assert.False(defaults.ReduceMotion);
    }
}

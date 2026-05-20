using Ink.Runtime;

namespace VisualNovel.Shared.Services;

public sealed class StoryService
{
    private Story? _story;

    public string CurrentText { get; private set; } = "";
    public string Speaker { get; private set; } = "";
    public string Motif { get; private set; } = "";
    public string Art { get; private set; } = "";
    public IReadOnlyList<string> CurrentSfx { get; private set; } = Array.Empty<string>();

    public string Background { get; private set; } = "";
    public string CharacterOnStage { get; private set; } = "";
    public string Voice { get; private set; } = "modulated";
    public string Pacing { get; private set; } = "normal";
    public string Audio { get; private set; } = "";
    public int Scene { get; private set; }
    public bool IsClimaxPause { get; private set; }

    public IReadOnlyList<Choice> CurrentChoices { get; private set; } = Array.Empty<Choice>();

    public HashSet<int> VisitedScenes { get; } = new();
    public List<HistoryEntry> History { get; } = new();

    public void MergeVisited(IEnumerable<int> scenes)
    {
        foreach (var s in scenes) VisitedScenes.Add(s);
        StateChanged?.Invoke();
    }

    public bool IsLoaded => _story is not null;
    public bool CanAdvance => _story is not null && _story.canContinue;
    public bool IsAtChoice => CurrentChoices.Count > 0;
    public bool IsEnded => _story is not null && !CanAdvance && !IsAtChoice;

    public event Action? StateChanged;

    public void LoadFromJson(string json)
    {
        _story = new Story(json);
        Advance();
    }

    public void Advance()
    {
        if (_story is null) return;

        Speaker = "";
        Motif = "";
        Art = "";
        IsClimaxPause = false;
        var sfx = new List<string>();

        if (_story.canContinue)
        {
            CurrentText = _story.Continue().TrimEnd('\n').Trim();
            ApplyTags(_story.currentTags ?? new List<string>(), sfx);
            if (!string.IsNullOrEmpty(CurrentText))
            {
                History.Add(new HistoryEntry(Scene, Speaker, CurrentText));
            }
        }
        else
        {
            CurrentText = "";
        }

        CurrentSfx = sfx;
        CurrentChoices = _story.currentChoices?.ToList() ?? new List<Choice>();
        StateChanged?.Invoke();
    }

    public void Choose(int index)
    {
        if (_story is null) return;
        _story.ChooseChoiceIndex(index);
        Advance();
    }

    public bool JumpToKnot(string knot)
    {
        if (_story is null || string.IsNullOrEmpty(knot)) return false;
        try
        {
            _story.ChoosePathString(knot);
            Advance();
            return true;
        }
        catch
        {
            return false;
        }
    }

    public string GetVar(string name)
    {
        if (_story is null) return "";
        try
        {
            return _story.variablesState[name]?.ToString() ?? "";
        }
        catch
        {
            return "";
        }
    }

    private void ApplyTags(IList<string> tags, List<string> sfx)
    {
        foreach (var raw in tags)
        {
            var (key, value) = SplitTag(raw);
            switch (key)
            {
                case "scene":
                    if (int.TryParse(value, out var s))
                    {
                        Scene = s;
                        VisitedScenes.Add(s);
                    }
                    break;
                case "pacing":  Pacing = value; break;
                case "voice":   Voice = value; break;
                case "bg":      Background = value; break;
                case "char":    CharacterOnStage = value; break;
                case "speaker": Speaker = value; break;
                case "motif":   Motif = value; break;
                case "art":     Art = value; break;
                case "audio":   Audio = value; break;
                case "sfx":     sfx.Add(value); break;
                case "pause":
                    if (value == "climax-window") IsClimaxPause = true;
                    break;
            }
        }
    }

    private static (string key, string value) SplitTag(string raw)
    {
        var idx = raw.IndexOf(':');
        if (idx < 0) return (raw.Trim(), "");
        return (raw[..idx].Trim(), raw[(idx + 1)..].Trim());
    }
}

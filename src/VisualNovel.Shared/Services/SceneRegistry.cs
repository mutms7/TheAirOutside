namespace VisualNovel.Shared.Services;

public record SceneInfo(int Id, string Knot, string Title, string? Gate = null, int? CallbackFrom = null);

public static class SceneRegistry
{
    public static readonly IReadOnlyList<SceneInfo> Scenes = new SceneInfo[]
    {
        new(1,  "cold_open",        "Ants"),
        new(2,  "homeroom",         "Stickers"),
        new(3,  "dexterity_pe",     "Smooth"),
        new(4,  "cafeteria",        "The Lesser Suits",  Gate: "gate1"),
        new(5,  "hallway_iris",     "The Window",        Gate: "gate2"),
        new(6,  "evening_charging", "Charging"),
        new(7,  "crushed",          "Crushed"),
        new(8,  "classroom_ozaki",  "Be More Honest",    CallbackFrom: 4),
        new(9,  "malfunction",      "Air"),
        new(10, "taes_drawer",      "The Drawer"),
        new(11, "night_hallway",    "Humming"),
        new(12, "the_door",         "The Door",          Gate: "gate3"),
        new(13, "step_outside",     "Outside"),
        new(14, "next_day",         "Bare",              Gate: "gate4"),
        new(15, "coda",             "Watching"),
    };

    public static SceneInfo? ByNumber(int n) =>
        Scenes.FirstOrDefault(s => s.Id == n);

    public static SceneInfo? ByKnot(string knot) =>
        Scenes.FirstOrDefault(s => s.Knot == knot);
}

public sealed record HistoryEntry(int Scene, string Speaker, string Text);

public static class GateOptions
{
    public static readonly Dictionary<string, IReadOnlyList<GateChoice>> ByGate = new()
    {
        ["gate1"] = new GateChoice[] {
            new("silent",  "stay silent"),
            new("speak",   "say something quietly"),
            new("deflect", "change the subject"),
        },
        ["gate2"] = new GateChoice[] {
            new("approach", "approach Iris"),
            new("avoid",    "do not approach"),
        },
        ["gate3"] = new GateChoice[] {
            new("iris", "seek Iris"),
            new("stay", "stay alone"),
            new("tae",  "message Tae"),
        },
        ["gate4"] = new GateChoice[] {
            new("stay_out",     "stay out of the suit"),
            new("suit_no_deco", "suit, no decoration"),
            new("re_enter",     "re-enter the suit"),
        },
    };
}

public sealed record GateChoice(string Value, string Label);

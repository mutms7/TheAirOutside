#!/usr/bin/env perl
# Convert third-person Wren narration to first-person.
# Track speaker context so dialogue addressing Wren uses {protagonist_name}.
# Also remove em-dashes and fix capitalization.

use strict;
use warnings;

my @PREPOSITIONS = qw(
    behind beside near beyond past around against between with without
    about above across after before at beneath by during except for from
    in inside into of off on onto out outside over through throughout to
    toward under until upon up with within
);

# Verbs that commonly take Wren as a direct object.
# "watches Wren" -> "watches me"
my @OBJECT_VERBS = qw(
    watches watching watched
    sees seeing saw
    finds finding found
    asks asking asked
    tells telling told
    shows showing showed
    gives giving gave
    sends sending sent
    leaves leaving left
    follows following followed
    calls calling called
    pings pinging pinged
    glances glancing glanced
    considers considering considered
    meets meeting met
    greets greeting greeted
    notices noticing noticed
    addresses addressing addressed
);

# Verbs whose base form ends in -ss (must not have final s stripped).
my @SS_VERBS = qw(
    pass kiss miss press dress cross discuss mess hiss
    bless dismiss fuss progress confess address
);

my %ES_VERBS = (
    'watches' => 'watch', 'reaches' => 'reach', 'catches' => 'catch',
    'pushes'  => 'push',  'crosses' => 'cross', 'passes'  => 'pass',
    'finishes' => 'finish', 'rushes' => 'rush', 'misses' => 'miss',
    'presses' => 'press', 'hisses' => 'hiss',  'wishes' => 'wish',
    'kisses'  => 'kiss',  'closes' => 'close', 'composes' => 'compose',
    'choses'  => 'chose', 'chooses' => 'choose', 'dresses' => 'dress',
);

my %IES_VERBS = (
    'tries'   => 'try',   'cries'   => 'cry',   'carries' => 'carry',
    'flies'   => 'fly',   'applies' => 'apply', 'dries'   => 'dry',
    'replies' => 'reply', 'denies'  => 'deny',
);

my %DONT_STRIP = map { $_ => 1 } qw(
    his this hers theirs yours ours us its yes was is has does
    aliens basis crisis analysis bus census consensus focus minus
);

my %ES_REVERSE = (
    'watches' => 'watch', 'reaches' => 'reach', 'catches' => 'catch',
    'pushes'  => 'push',  'crosses' => 'cross', 'passes'  => 'pass',
    'finishes' => 'finish', 'rushes' => 'rush', 'misses' => 'miss',
    'presses' => 'press', 'hisses' => 'hiss',  'wishes' => 'wish',
    'kisses'  => 'kiss',  'closes' => 'close', 'composes' => 'compose',
    'chooses' => 'choose', 'dresses' => 'dress',
);

my %IES_REVERSE = (
    'tries'   => 'try',   'cries'   => 'cry',   'carries' => 'carry',
    'flies'   => 'fly',   'applies' => 'apply', 'dries'   => 'dry',
    'replies' => 'reply', 'denies'  => 'deny',
);

sub _compound_strip {
    my ($word) = @_;
    # Don't strip non-verb words
    return $word if $DONT_STRIP{lc $word};
    # -ies verbs: tries -> try
    return $IES_REVERSE{$word} if exists $IES_REVERSE{$word};
    # -es verbs: watches -> watch
    return $ES_REVERSE{$word} if exists $ES_REVERSE{$word};
    # Don't strip if word ends in -ss (base form, not third-person)
    return $word if $word =~ /ss$/;
    # Otherwise drop the final s
    my $stem = $word;
    $stem =~ s/s$//;
    return $stem;
}

my $next_speaker = '';

while (my $line = <>) {
    # Comments pass through unchanged
    if ($line =~ /^\s*\/\//) { print $line; next; }

    # Track # speaker: tag
    if ($line =~ /^\s*#\s*speaker:\s*(\w+)/) {
        $next_speaker = lc $1;
        print $line; next;
    }

    # Other tag lines, choice/divert/var markers, blank lines pass through
    if ($line =~ /^\s*#/ || $line =~ /^\s*\+/ || $line =~ /^\s*->/ ||
        $line =~ /^\s*~/ || $line =~ /^\s*=/ || $line =~ /^\s*VAR\s/ ||
        $line =~ /^\s*INCLUDE\s/ || $line =~ /^\s*$/) {
        print $line; next;
    }

    # === EM-DASH REMOVAL ===
    $line =~ s/—\s*$/.../;
    $line =~ s/ — /. /g;
    $line =~ s/—//g;

    # === WREN CONVERSION ===
    if ($next_speaker && $next_speaker ne 'wren' && $next_speaker ne 'narration') {
        # Dialogue from another character or HUD: address by name
        $line =~ s/\bWren\b/{protagonist_name}/g;
        $line =~ s/\bWREN\b/{protagonist_name}/g;
    } else {
        # Narration (or Wren's own dialogue)
        # Possessive first
        $line =~ s/\bWren's\b/my/g;

        # Object position after prepositions: Wren -> me
        for my $prep (@PREPOSITIONS) {
            $line =~ s/\b\Q$prep\E Wren\b/$prep me/g;
            my $pcap = ucfirst $prep;
            $line =~ s/\b\Q$pcap\E Wren\b/$pcap me/g;
        }

        # Object position after verbs that take Wren: Wren -> me
        for my $v (@OBJECT_VERBS) {
            $line =~ s/\b\Q$v\E\s+Wren\b/$v me/g;
        }

        # Subject position remaining: Wren -> I
        $line =~ s/\bWren\b/I/g;

        # Verb conjugation: irregulars first
        $line =~ s/\bI is\b/I am/g;
        $line =~ s/\bI has\b/I have/g;
        $line =~ s/\bI does\b/I do/g;
        $line =~ s/\bI goes\b/I go/g;

        # Protect "I was" (past tense first-person stays the same)
        $line =~ s/\bI was\b/__IWASTOKEN__/g;

        # Protect verbs after "I " whose base form ends in -ss or has irregular -es/-ies
        for my $w (@SS_VERBS) {
            $line =~ s/\bI \Q$w\E\b/I __STEM_${w}__/g;
        }
        for my $v (sort keys %ES_VERBS) {
            my $stem = $ES_VERBS{$v};
            $line =~ s/\bI \Q$v\E\b/I __STEM_${stem}__/g;
        }
        for my $v (sort keys %IES_VERBS) {
            my $stem = $IES_VERBS{$v};
            $line =~ s/\bI \Q$v\E\b/I __STEM_${stem}__/g;
        }

        # Generic -s drop after "I " for the primary verb
        $line =~ s/\bI ([a-z]+)s\b/I $1/g;

        # Compound verbs: per-sentence, when subject is "I", drop -s from verbs
        # after comma / and / then. Handles "I cross the room, raises X, and steps Y."
        # Uses _compound_strip which blocks known non-verb words (his/this/-ss endings)
        # and handles -es/-ies stems (watches -> watch, tries -> try).
        my @parts = split /([.!?]\s*)/, $line;
        for (my $i = 0; $i <= $#parts; $i += 2) {
            next unless $parts[$i] =~ /\bI\b/;
            $parts[$i] =~ s/(?<=, )([a-z]+s)\b/_compound_strip($1)/eg;
            $parts[$i] =~ s/(?<= and )([a-z]+s)\b/_compound_strip($1)/eg;
            $parts[$i] =~ s/(?<= then )([a-z]+s)\b/_compound_strip($1)/eg;
        }
        $line = join '', @parts;

        # Restore protected words (placeholder contains just the stem)
        $line =~ s/\b__IWASTOKEN__\b/I was/g;
        $line =~ s/__STEM_(\w+?)__/$1/g;

        # Pronouns: "their" referring to Wren -> "my" (mostly correct)
        $line =~ s/\btheir\b/my/g;
        # "they're" -> "I'm" in narration context
        $line =~ s/\bthey're\b/I'm/g;
    }

    # === CAPITALIZATION FIXES (after em-dash substitution + line start) ===
    # Capitalize after ". " (period + space)
    $line =~ s/(\. )([a-z])/$1 . uc($2)/eg;
    # Capitalize first non-whitespace character of the line
    $line =~ s/^(\s*)([a-z])/$1 . uc($2)/e;

    $next_speaker = '';
    print $line;
}

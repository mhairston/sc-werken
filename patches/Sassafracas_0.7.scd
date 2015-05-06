// Sassafracas (TuneMachine II)
// v0.7 - 20150413 - M. Hairston

/*
// TODO
// Define a player (via a prototype pattern)
// collection of instruments to choose from (for each note or each part?)
// durations, degrees, legato, octaves, amplitudes,
// outside notes, pattern length, accuracy (lag)
// include an amplitude factor.
// A player is composed of an amalgam of prototype patterns (partials)
// (building blocks of a synthetic style).
// They all follow a master scale.
// Include an "arranger" player who affects the mix and texture
// (redefine the Pdef with altered values).

Generate a library of "blocks"
-- a block is basically a bar of music, for one instrument.
-- Individual blocks are very simple patterns.
-- Combined and manipulated in different ways, they produce complex patterns.

Ideas for API:
*/
// Create a new player
~joe = FPlayer.new("bass");

// Create an entire ensemble of players,
// plus a "repertoire" of patterns, some shared, some unique.
~ens = FBand.new(["bass","drums","texturalist","wind player"]);

// variety is a simple global setting that will affect all chance operations.
// 0 = lots of repetition, 1.0 = unique, non-repeating patterns
~ens.variety(0.4);
~ens.play; // start the music

// Patterns: Can be repeated, reversed, shifted, shuffled, etc.

// Amplitude:
~ampp = [
  [1.0,0.3,0.7,0.2], // emph. 1 & 3
  [1.0,0.1,0.2,0.1], // quieter 3
  [1.0,1.0,0.1,0.1], // two on, two off
  [1.0,0.7,0.4,0.1], // ramp
  [1.0,0,0,1.0]      // emph at ends
];
// Degrees:
  // different sets for diff instr? (e.g., bass with lots of root+five?)
~degp = [
  [0,0,0,0],
  [0,3,0,3],
  [3,2,1,0],
  [5,2,3,0],
  [7,3,4,0],
  [2,0,5,4]
];
// Durations:
  // different sets for diff instr?
~durp = [
  [0.25,0.25,0.25,0.25],
  [0.5,0.25,0.5,0.25],
  [0.5,0.5],
  [0.5,0.125,0.125,0.125,0.125]
];

(
~dseq = Array.newClear(2);
~dseq = {
  ({~degp.choose + rrand(-3,5)}!4).flatten;
};

g = Group();
~rvb = Synth.tail(g,\gverb,[\roomsize,20]);
~rvb.run(1).set(\revtime,6.0,\drylevel,0.7,\taillevel,0.06);
~dst = Synth.tail(g,\fuzz);
~dst.run(0).set(\intensity,0.4);
~mod = Synth.tail(g,\phaser);
~mod.run(1).set(\freq,1/8);
~lpf = Synth.tail(g,\LPF);
~lpf.run(1).set(\cutoff,8000);
~hpf = Synth.tail(g,\HPF);
~hpf.run(1).set(\cutoff,20);

~sc = Scale.bhairav;
~root = rrand(-5,6);
~mtr = 5;
Pdef(\am).play(quant:2);

Pdef(\am,
  Ppar({|i|
    Pbind(
      \instrument, \pinggnip,
      \waveform, 0.75,
      \scale, ~sc,
      \root, ~root,
      \mtranspose, ~mtr,
      \octave,3+i,
      \degree, Pseq(({~dseq.value}!2).flatten,inf),
      \amp, Pseq(~ampp.choose++~ampp.choose,inf)*4,
      \dur, Pseq(~durp.choose++~durp.choose,inf),
      \returnAmp, 0.15,
      \legato, 3,
      \att,0.02,
      \attack,0.02
    )
  }!3)
);

)


Pdef(\am).stop;


Quarks.gui

Proto

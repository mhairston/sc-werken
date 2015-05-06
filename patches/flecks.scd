


{
  var a,root,voices,density,freq,partial,audio,cutoff,amod,amodFreq,detune,detuneFreqMod,signal,env;
  root = 220;
  voices = 3;
  density = 0.7;
  signal = Mix.fill(voices,{
    partial = LFNoise0.kr(1/3).range(1,8);
    cutoff = exprand(1500,6000);
    freq = partial * root;
    detuneFreqMod = SinOsc.kr(1/5).range(1/8,4);
    detune = LFNoise0.kr(detuneFreqMod).range(0.99,1.01);
    audio = Saw.ar([freq,freq * detune],mul:0.4);
    amodFreq = LFNoise0.kr(1/8).exprange(6,55);
    amod = SinOsc.kr( amodFreq ).range(0,1);
    env = LFNoise0.kr(8);
    env = max(0,env - (1-density)) * (1 / density);
    audio = audio * env * amod;
    audio = LPF.ar(audio,cutoff);
  });


  a = Pan2.ar(signal, pos:0) * 0.5;
  a = GVerb.ar(a, roomsize:20, revtime:2, damping:0.4, drylevel:0.7, taillevel:0.08, spread:20);

}.play;


// Buckets:
{
  Mix.ar(PinkNoise.ar(0.8) * Decay2.ar(Impulse.ar({rrand(2,8)}!3),0.001,0.1));
}.play;

// Done as a class, could look like:
// {Buckets.beat(2,10)}!3; -- rhythmic, with Impulse
// {Buckets.bang(2,10)}!3; -- arhythmic, with Dust
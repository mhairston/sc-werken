

(


  SynthDef("pitchFollow2",{
    var in, amp, freq, hasFreq, out;
    in = Mix.new(AudioIn.ar(1));
    amp = Amplitude.kr(in, 0.05, 0.05);
    # freq, hasFreq = Pitch.kr(in, ampThreshold: 0.02, median: 7);
    out = CombC.ar(LPF.ar(in, 1000), 0.1, (2 * freq).reciprocal, -6).distort * 0.05;
    6.do({
      out = AllpassN.ar(out, 0.040, [0.040.rand,0.040.rand], 2)
    });
    ReplaceOut.ar(0,out);
  }).play(s);
)

(
  z = Synth.play({
    var in, amp, freq, hasFreq, out, oct;
    in = Mix.ar(AudioIn.ar([1,2]));
    //in=HPF.ar(in,200,2);
    in=in*5;
    amp = Amplitude.kr(in, 1, 0.05);
    amp=Lag.kr(amp,3.0);
    oct=MouseY.kr(1,12,0.1);
    oct=oct.round(1);
    # freq, hasFreq = Pitch.kr(in, ampThreshold: 0.02, median: 7)*oct;
    freq = Lag.kr(freq.cpsmidi.round(1).midicps, 0.2);
    //out = Mix.ar(VarSaw.ar(freq * [0.5,1,2], 0, LFNoise1.kr(0.3,0.1,0.1), amp));
    out = Mix.ar(Pulse.ar(freq * [0.5,1], 0.5, amp));

    //out=RLPF.ar(out,1000+(amp*10000),0.2);

    out=CombN.ar(out,0.5,0.34,8,1,out);
    out=CombN.ar(out,8.0,4.0,64,1,out);

    6.do({
      out = AllpassN.ar(out, 0.040, [0.040.rand,0.040.rand], 8)
    });

    out;
  })
)

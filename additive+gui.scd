s.boot;

(

//Setting the various Bus controls;
~freq=Bus.control(s);
~fm=Bus.control(s);
~ring=Bus.control(s);

~partials=16; //Number of partials;

~partials.do{|n|
~vol=~vol.add(Bus.control(s));
};

//Define the main Synth;

SynthDef(\harm,{arg out=0;
var vol=[];
var sig;
~freq.set(60);
sig=Array.fill(~partials,{|n| SinOsc.ar(Lag.kr(~freq.kr,0.1)*(n+1)+(SinOsc.kr(~freq.kr,0,1).range(0,1000)*(~fm.kr)),0,1)});
~partials.do{|n|
vol=vol.add(Lag.kr(~vol[n].kr,0.05));
};
Out.ar(out,(sig*vol).sum*(1+(SinOsc.ar(10,0,10)*Lag.kr(~ring.kr,0.1)))*0.1!2);
}).add;

//Build the Graphical interface;
w = Window(bounds:Rect(400,400,420,250)); //Creates the main window
w.front;
w.onClose_({x.free});

//Add the multislider;
n=~partials+1;
m = MultiSliderView(w,Rect(10,10,n*23+0,100));
m.thumbSize_(23);
m.isFilled_(true);
m.value=Array.fill(n, {|v| 0});
m.action = { arg q;
~partials.do{|n|
~vol[n].set(q.value[n]);
};
q.value.postln;
};
//Add sliders to control frequency, fm modulation, and ring modulation;

g=EZSlider(w,Rect(10,150,390,20),"Freq",ControlSpec(20,2000,\lin,0.01,60),{|ez| ~freq.set(ez.value);ez.value.postln});
g.setColors(Color.grey,Color.white);
g=EZSlider(w,Rect(10,180,390,20),"Fm",ControlSpec(0,1,\lin,0.01,0),{|ez| ~fm.set(ez.value);ez.value.postln});
g.setColors(Color.grey,Color.white);
g=EZSlider(w,Rect(10,210,390,20),"Ring",ControlSpec(0,0.1,\lin,0.001,0),{|ez| ~ring.set(ez.value);ez.value.postln});
g.setColors(Color.grey,Color.white);

//Create the synth
x=Synth(\harm);
)

s.quit;

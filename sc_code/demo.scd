// Code from http://digitalmusics.dartmouth.edu/~cc12/sc_code/assig2.2
// Written by Larry Polansky and Dan Rockmore of Dartmouth College

/************************************************************************************************/
/*																		*/
/*  					Additive synthesis assignment example 						*/
/*																		*/
/************************************************************************************************/
GUI window coordinates are absolute and subwindows such as sliders are relative 
to main GUI Window

(	
//Variable Decleration
var w, numberOfCol;
var leftEnd, topEnd, rightEnd, bottomEnd, xOffset, yOffset;
var minKnobFreq, maxKnobFreq, minKnobAmp, maxKnobAmp, minKnobPhase, maxKnobPhase;
var link1,link2, controls, controlColumnOdd;
var ran, left, top, right, bottom;
var scopeDuration;

//Setup variables and parameters
numberOfCol 		= 16;
xOffset 			= 574;    	yOffset 		= -20;
minKnobFreq 		= 20;		maxKnobFreq 	= 2000*2;
minKnobAmp 		= 0;		maxKnobAmp 	= 0.03+(1/numberOfCol); // offset is for global mpy of signals
minKnobPhase 		= 0; 		maxKnobPhase 	= 359.9;
scopeDuration 		= 0.05;

// these are absolute values on screen(monitor)
leftEnd   = 40 + xOffset - 180  + 80;	
topEnd    = 80 + yOffset; 
rightEnd  = 350 + xOffset  + 80;	
bottomEnd = numberOfCol*36.5 + yOffset;

// Make sliders and String views
w = GUIWindow.new("Multi Sliders", Rect.new(leftEnd, topEnd, rightEnd, bottomEnd));

// making macros
link1 			= { arg in, out; w.views.at(in).action = { w.views.at(out).value = w.views.at(in).value }};
link2				= { arg in, out; link1.value(out, in); link1.value(in,out)};
controlColumnOdd 	= { arg row, columnStart, theWindow; theWindow.views.at((row*2)+1+((columnStart-1)*16)) };

controls = { arg j, minVal, maxVal, color, type0; 
	numberOfCol.do({ arg i; // i will increment by 1 n times				
				
				left = 20 + (240*(j/3));     top = 28 * i + 8 +20;
				right = 240*((j+1)/3);       bottom = 28 * i + 24+ 20;
		
				if(type0 < 1, 
				{								
					ran = minKnobFreq+(maxKnobFreq-100).rand;	
					NumericalView.new(w, Rect.new( left, top, right-20, bottom), nil, ran, minVal, maxVal, 0.01)
							   .backColor_(color).labelColor_(color);							  								  			
					SliderView.new(w, Rect.new( 50 +left, top, right + 0 + (1*right), bottom), nil, ran, minVal, maxVal, 0.01)
						     .knobColor_(color); 	
					link2.value(i*2,(i*2)+1);	// link nums and sliders		
				},
				{	
					ran = 0;
					NumericalView.new(w, Rect.new( left -15, top, right-20 -15 +20, bottom), nil, ran, minVal, maxVal, 0.0001)
							   .backColor_(color).labelColor_(color);
					SliderView.new(w, Rect.new( 50 +left+ 185 -(left +20) + 20, top, right + 50 + left + 10 , bottom), nil, ran ,minVal, maxVal, 0.0001)
						     .knobColor_(color); 
					link2.value(((i*2)+32),((i*2)+1+32));	// link nums and sliders	   
				}
				);				
			}); 
		};

controls.value(0, minKnobFreq, maxKnobFreq, rgb(37,53,176), 0);			// freq
controls.value(2, minKnobAmp, maxKnobAmp, rgb(176,22,43), 1);			// amp

// string view setup and global controls
StringView.new( w, Rect.newBy( 109, 6, 60, 19 ), "Frequency")
		.labelColor_(rgb(50,44,176));
StringView.new( w, Rect.newBy( 319, 6, 60, 19 ), "Amplitude")
		.labelColor_(rgb(176,17,20));
StringView.new( w, Rect.newBy( 230, 474, 140, 18 ), "'Additive Synthesis'");
StringView.new( w, Rect.newBy( 19, 474, 140, 18 ), "Scope Duration in sec: ")
		.labelColor_(rgb(19,112,36));
StringView.new( w, Rect.newBy( 158, 474, 39, 21 ), scopeDuration)
		.labelColor_(rgb(37,107,44));

// make controls and mix each signal together 
Synth.scope({
	Mix.ar(
			Array.fill(numberOfCol, 
				{ arg i; 
					SinOsc.ar( ControlIn.kr( (controlColumnOdd.value(i, 1, w) ) ), 		// odd, columns starting from 16 freq
							0,											// phase
							ControlIn.kr( (controlColumnOdd.value(i, 3, w) ))		// odd columns starting from 32 amp							
							) 
				}
			) 
		)
		}, 	scopeDuration, "Additive Synthesis", Rect.newBy(leftEnd-415-80, topEnd, 480, bottomEnd + 100) );
w.close;
)



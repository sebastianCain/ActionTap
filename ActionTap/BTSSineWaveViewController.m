//
//  BTSSineWaveViewController.m
//  CoreAnimationFunHouse
//
//  Created by Brian Coyner on 10/15/11.
//  Copyright (c) 2011 Brian Coyner. All rights reserved.
//

#import "BTSSineWaveViewController.h"
#import "BTSSineWaveLayer.h"

@interface BTSSineWaveViewController () {
	IBOutlet UISlider *amplitudeSlider;
	IBOutlet UISlider *frequencySlider;
	IBOutlet UISlider *phaseSlider;
}

@end

@implementation BTSSineWaveViewController

#pragma mark - Object Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // The sine wave layer uses the following equation to draw the sine wave:
    // y = A * sin(ωt + phase)
    //  where A = amplitude
    //        ω = angular frequency -> (2PI * "width of pie layer" * 8.0); draw up to 8 sine waves in the layer 
    //
    // The "frequency slider" contains the possible angular frequency values so that the layer does not have to 
    // calculate the angular frequency while drawing. 

    BTSSineWaveLayer *layer = [self sineWaveLayer];
    [layer setContentsScale:[[UIScreen mainScreen] scale]];
    CGRect layerBounds = [layer bounds];

    [
	 amplitudeSlider setMinimumValue:0.0];
    [amplitudeSlider setMaximumValue:layerBounds.size.height / 2.0 - 5.0];
	[amplitudeSlider setValue:[amplitudeSlider maximumValue] / 2.0];

    [frequencySlider setMinimumValue:0.0];
    [frequencySlider setMaximumValue:(float)((2 * M_PI / layerBounds.size.width) * 10.0)];
    [frequencySlider setValue:[frequencySlider maximumValue] / 2.0];

    [phaseSlider setMinimumValue:(float)-100];
    [phaseSlider setMaximumValue:(float)100];
    [phaseSlider setValue:0.0];

    [layer setAmplitude:[amplitudeSlider value]];
    [layer setFrequency:[frequencySlider value]];
    [layer setPhase:[phaseSlider value]];

    [layer setNeedsDisplay];
}

#pragma mark - User Interaction Methods

- (IBAction)updateAmplitude:(id)sender
{
    BTSSineWaveLayer *layer = [self sineWaveLayer];
    float amplitude = [(UISlider *)sender value];
    [layer setAmplitude:(CGFloat)amplitude];
    [layer setNeedsDisplay];
}

- (IBAction)updateFrequency:(id)sender
{
    BTSSineWaveLayer *layer = [self sineWaveLayer];
    float frequency = [(UISlider *)sender value];
    [layer setFrequency:(CGFloat)frequency];
    [layer setNeedsDisplay];
}

- (IBAction)updatePhase:(id)sender
{
    BTSSineWaveLayer *layer = [self sineWaveLayer];
    float phase = [(UISlider *)sender value];
    [layer setPhase:(CGFloat)phase];
    [layer setNeedsDisplay];
}

- (BTSSineWaveLayer *)sineWaveLayer
{
    return (BTSSineWaveLayer *)[[[self view] viewWithTag:100] layer];
}

@end

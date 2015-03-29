//
//  BTSSineWaveLayer.m
//  CoreAnimationFunHouse
//
//  Created by Brian Coyner on 10/15/11.
//  Copyright (c) 2011 Brian Coyner. All rights reserved.
//

#import "BTSSineWaveLayer.h"
#import "AudioRecorder.h"

static NSString *const kBTSSineWaveLayerAmplitude = @"amplitude";
static NSString *const kBTSSineWaveLayerFrequency = @"frequency";
static NSString *const kBTSSineWaveLayerPhase = @"phase";

@interface BTSSineWaveLayer () {
    CADisplayLink *_displayLink;
    NSMutableArray *_currentAnimations;
}
@end

@implementation BTSSineWaveLayer

// NOTE: This code shows a technique for capturing screen refreshes using CADisplayLink.
//       You can actually remove the CADisplayLink and simply override the 'needsDisplayForKey:'
//       method to return the dynamic property key names. This example, though, I show how to capture
//       a "screen refresh". This technique is useful if you need more logic than simply "re-drawing".
//       See my 'Core Animation Pie Chart' example on GitHub.
//
// NOTE: Sometimes the 'needsDisplayForKey:' can produce undesired 'flickering' effects. I have yet to 
//       see any undesired 'flickering' effects using the CADisplayLink approach.

// CALayer calls 'actionForKey:' for any custom dynamic property.

@dynamic phase;
@dynamic frequency;
@dynamic amplitude;

+ (NSSet *)keyPathsForDynamicProperties
{
    static NSSet *keys = nil;
    if (keys == nil) {
        keys = [[NSSet alloc] initWithObjects:kBTSSineWaveLayerAmplitude, kBTSSineWaveLayerFrequency, kBTSSineWaveLayerPhase, nil];
    }
    return keys;
}

#pragma mark - Object Life Cycle

- (id)init
{
    self = [super init];
    if (self) {
        _currentAnimations = [[NSMutableArray alloc] initWithCapacity:3];
    }
    return self;
}

#pragma mark - CALayer Delegate

- (void)drawInContext:(CGContextRef)context;
{
    [super drawInContext:context];

    CGRect bounds = [self bounds];

    CGContextTranslateCTM(context, 0.0, CGRectGetHeight(bounds) / 2.0);

    //BTSDrawCoordinateAxes(context);

    CGContextSetStrokeColorWithColor(context, [[UIColor whiteColor] CGColor]);
    CGContextSetLineWidth(context, 2.0);

	CGContextSetRGBFillColor(context, 40/255.0, 40/255.0, 40/255.0, 1.0);
	CGContextFillRect(context, (CGRect){-100,-200, 1000,1000});
	
    // The layer redraws the content using the current animation's interpolated values. The interpolated
    // values are retrieved from the layer's "presentationLayer".
    id presentationLayer = [self presentationLayer];

    CGFloat amplitude = [[(NSValue *)presentationLayer valueForKey:kBTSSineWaveLayerAmplitude] floatValue];
    CGFloat frequency = [[(NSValue *)presentationLayer valueForKey:kBTSSineWaveLayerFrequency] floatValue];
    CGFloat phase = [[(NSValue *)presentationLayer valueForKey:kBTSSineWaveLayerPhase] floatValue];

    unsigned int stepCount = (unsigned int)CGRectGetWidth(bounds);
    for (int t = 0; t <= stepCount; t++) {
        CGFloat y = (CGFloat)(amplitude * sin(t * frequency + phase));

        if (t == 0) {
            CGContextMoveToPoint(context, 0.0, y);
        } else {
            CGContextAddLineToPoint(context, t, y);
        }
    }

    CGContextStrokePath(context);
}

- (id<CAAction>)actionForKey:(NSString *)event
{
    // Called when layer's property changes.

    if ([[BTSSineWaveLayer keyPathsForDynamicProperties] member:event]) {

        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:event];
        NSValue *valueForKey = [[self presentationLayer] valueForKey:event];

        [animation setFromValue:valueForKey];
        [animation setDelegate:self];
        [animation setDuration:1.0];

        return animation;

    } else {
        return [super actionForKey:event];
    }
}

#pragma mark - Animation Delegate Callbacks

- (void)animationDidStart:(CAAnimation *)animation
{
    if ([animation isKindOfClass:[CAPropertyAnimation class]]) {
        NSSet *internalKeys = [BTSSineWaveLayer keyPathsForDynamicProperties];
        if ([internalKeys member:[(CAPropertyAnimation *)animation keyPath]]) {

            [_currentAnimations addObject:animation];
            if (_displayLink == nil) {
                _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(animationTimerFired:)];
                [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
            }
        }
    }
}

- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)flag
{
    [_currentAnimations removeObject:animation];
    if ([_currentAnimations count] == 0) {
        [_displayLink invalidate];
        _displayLink = nil;

        // hmmm... the use of CADisplayLink seems to miss the final set of interpolated values... let's force a final paint.
        // note... this was not necessary when using an explicit NSTimer (need to investigate more).
        [self setNeedsDisplay];
    }
}

#pragma mark - Timer Callback

- (void)animationTimerFired:(CADisplayLink *)displayLink
{
	self.phase -= .1;
    [self setNeedsDisplay];
	//self.amplitude = [audiorecorder getVolume];
}

@end

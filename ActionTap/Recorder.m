//
//  Recorder.m
//  ActionTap
//
//  Created by Avery Lamp on 3/28/15.
//  Copyright (c) 2015 Sebastian Cain. All rights reserved.
//

#import "Recorder.h"
#import "DataAccess.h"
#import "Pattern+Pattern_Functions.h"
@interface Recorder ()
@property NSMutableArray *tempPattern;
@property NSMutableArray *tempPattern2;//of NSNumbers hoding float values
@property float LOW_VOLUME_THRESHOLD;
@property float HIGH_VOLUME_THRESHOLD;
@property float LOW_MAGNITUDE_THRESHOLD;
@property float HIGH_MAGNITUDE_THRESHOLD;
@property(readwrite) bool isRecording;
@property BOOL isbackground;
@property(readwrite) bool backgroundIsRecording;
@property int freezeDisplayLink;
@end

@implementation Recorder



-(instancetype)init
{
    self = [super init];
    if(self ){
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(onDisplayLink)];
        self.displayLink.frameInterval = 1;
        [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        [self.displayLink setPaused:YES];
        //self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
        //self.tapGesture.numberOfTapsRequired = 2;
        //[self.view addGestureRecognizer:self.tapGesture];
        
        self.LOW_VOLUME_THRESHOLD = -22;
        self.HIGH_VOLUME_THRESHOLD = 0;
        self.LOW_MAGNITUDE_THRESHOLD = 97;
        self.HIGH_MAGNITUDE_THRESHOLD = 104;
        self.audioRecorder = [[AudioRecorder alloc] init];
        self.motionListener = [[MotionListener alloc] init];
        self.isRecording = NO;
        self.backgroundIsRecording = NO;
        self.freezeDisplayLink = 0;
        
        
        self.currentIndex +=100;
        self.displayLink2 = [CADisplayLink displayLinkWithTarget:self selector:@selector(onDisplayLink2)];
        self.displayLink2.frameInterval = 1;
        [self.displayLink2 addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        [self.displayLink2 setPaused:YES];
        self.motionListener2 = [[MotionListener alloc] init];
    }
    
    return self;
}



//- (void)handleTapGesture:(UITapGestureRecognizer *)sender {
//    if (sender.state == UIGestureRecognizerStateRecognized) {
//        self.tapGesture.numberOfTapsRequired = 1;
//        [self startReadingInput];
//    }
//}

-(void)onDisplayLink
{
    //float volume = [self.audioRecorder getVolume];
    if (self.freezeDisplayLink > 0){
        self.freezeDisplayLink -= 1;
        
    }

    float magnitude = [self.motionListener getMagnitude];
                    //NSLog(@"%f", magnitude);
    if ([self.tempPattern count] < 300)
    {
        if (magnitude < self.LOW_MAGNITUDE_THRESHOLD || magnitude > self.HIGH_MAGNITUDE_THRESHOLD)
        {
            if(self.freezeDisplayLink == 0)
            {
                [self.tempPattern addObject:[NSNumber numberWithInt:1]];
                self.freezeDisplayLink = 10;
            }else{
                [self.tempPattern addObject:[NSNumber numberWithInt:0]];
            }
        } else
        {
            [self.tempPattern addObject:[NSNumber numberWithInt:0]];

        }
    } else
    {
        [self.displayLink setPaused:YES];
        for(int i = 0; i < 300; i++){
            int x = [(NSNumber *)[self.tempPattern objectAtIndex:i] intValue];
            if (x == 0){
                NSLog(@"%i", x);
            }else{
                NSLog(@"💙");
            }
        }
        //Save To core data
        self.currentPattern.allTaps =[NSKeyedArchiver archivedDataWithRootObject:self.tempPattern];
        
        
        
        
        //Trigger function in delegate
        [self.delegate recordingFinishedForPatternIsBackground:self.isbackground];
    }
}

-(void)onDisplayLink2
{
    //NSLog(@"RECORDING IN BACKGROUND");
    //float volume = [self.audioRecorder getVolume];
    if (self.freezeDisplayLink > 0){
        self.freezeDisplayLink -= 1;
        return;
    }
    
    float magnitude = [self.motionListener getMagnitude];
   // NSLog(@"%f", magnitude);
    self.currentIndex ++;
    if ((magnitude < self.LOW_MAGNITUDE_THRESHOLD || magnitude > self.HIGH_MAGNITUDE_THRESHOLD) &&self.isbackground)
    {
        NSLog(@"%f", magnitude);
        if (self.currentIndex -self.lastDetectIndex<60) {
            self.backgroundStarted = YES;
            NSLog(@"DOUBLE TAP RECOGNIZED\nDOUBLE TAP RECOGNIZED\nDOUBLE TAP RECOGNIZED\nDOUBLE TAP RECOGNIZED\nDOUBLE TAP RECOGNIZED\n)");
            return;
        }else{
            self.freezeDisplayLink = 15;
            self.lastDetectIndex = self.currentIndex;
        }
        
        
    }
    
    
    
    
    if ([self.tempPattern2 count] < 300 && self.backgroundStarted)
    {
        if (magnitude < self.LOW_MAGNITUDE_THRESHOLD || magnitude > self.HIGH_MAGNITUDE_THRESHOLD)
        {
            if(self.freezeDisplayLink == 0)
            {
                [self.tempPattern2 addObject:[NSNumber numberWithInt:1]];
                self.freezeDisplayLink = 10;
            }else{
                [self.tempPattern2 addObject:[NSNumber numberWithInt:0]];
            }
        } else
        {
            [self.tempPattern2 addObject:[NSNumber numberWithInt:0]];
            
        }
    } else if(self.backgroundStarted)
    {
        [self.displayLink setPaused:YES];
        for(int i = 0; i < 300; i++){
            int x = [(NSNumber *)[self.tempPattern2 objectAtIndex:i] intValue];
            if (x == 0){
                NSLog(@"%i", x);
            }else{
                NSLog(@"💙");
            }
        }
        self.backgroundStarted = NO;
        //Save To core data
        self.backgroundPattern.allTaps =[NSKeyedArchiver archivedDataWithRootObject:self.tempPattern2];
        
        
        
        
        //Trigger function in delegate
        [self.delegate recordingFinishedForPatternIsBackground:self.isbackground];
    }
}
-(void)startNewPatternWithPattern:(Pattern*)pattern isBackground:(BOOL)background
{
    
    self.isbackground = background;
    if (!background) {
        self.isRecording = YES;
        self.backgroundIsRecording = NO;
        self.currentPattern = pattern;
        self.tempPattern = [[NSMutableArray alloc] init];
        [self.displayLink setPaused:NO];
        [self.displayLink2 setPaused:YES];
    }else{
        self.backgroundPattern  = pattern;
        self.backgroundIsRecording = YES;
        self.tempPattern2 = [[NSMutableArray alloc]init];
        [self.displayLink2 setPaused:NO];
        [self.displayLink setPaused:YES];
    }

}

-(void)stopRecording
{
    self.isRecording = NO;
    self.backgroundIsRecording= NO;
    [self.displayLink2 setPaused:YES];
    [self.displayLink setPaused:YES];
    [self.motionListener.motionManager stopAccelerometerUpdates];
}

-(double)compareArray:(NSMutableArray *)patternArray withArray:(NSMutableArray *)inputArray
{
    
    
    return 0.0;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

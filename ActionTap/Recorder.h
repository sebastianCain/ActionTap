//
//  Recorder.h
//  ActionTap
//
//  Created by Avery Lamp on 3/28/15.
//  Copyright (c) 2015 Sebastian Cain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AudioRecorder.h"
#import "MotionListener.h"
#import "Pattern+Pattern_Functions.h"
@protocol RecorderDelegate <NSObject>

-(void)recordingFinishedForPattern;

@end

@interface Recorder : NSObject
@property CADisplayLink *displayLink;
@property UITapGestureRecognizer *tapGesture;
@property AudioRecorder *audioRecorder;
@property MotionListener *motionListener;
@property(readonly) bool isRecording;
-(void)stopRecording;
@property  Pattern *currentPattern;
@property (weak)id <RecorderDelegate> delegate;

-(void)startNewPatternWithPattern:(Pattern*)pattern;


@end

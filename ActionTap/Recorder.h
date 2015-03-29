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

-(void)recordingFinishedForPatternIsBackground:(BOOL)background;

@end

@interface Recorder : NSObject
@property CADisplayLink *displayLink;
@property UITapGestureRecognizer *tapGesture;
@property AudioRecorder *audioRecorder;
@property MotionListener *motionListener;
@property bool isRecording;
-(void)stopRecording;
@property  Pattern *currentPattern;
@property  Pattern *backgroundPattern;
@property (weak)id <RecorderDelegate> delegate;


@property CADisplayLink *displayLink2;
@property MotionListener *motionListener2;
@property BOOL backgroundStarted;
@property int currentIndex;
@property int lastDetectIndex;


@property BOOL isbackground;
@property(readwrite) BOOL backgroundIsRecording;

-(void)startNewPatternWithPattern:(Pattern*)pattern isBackground:(BOOL)background;


@end

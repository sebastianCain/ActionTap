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
@protocol RecorderDelegate <NSObject>

-(void)recordingFinishedForPatternWithName:(NSString*)name;

@end

@interface Recorder : NSObject
@property CADisplayLink *displayLink;
@property UITapGestureRecognizer *tapGesture;
@property AudioRecorder *audioRecorder;
@property MotionListener *motionListener;

@property (weak)id <RecorderDelegate> delegate;

-(void)startNewPatternWithName:(NSString*)name withURL:(NSURL*)url;


@end

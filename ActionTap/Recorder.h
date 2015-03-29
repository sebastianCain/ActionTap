//
//  Recorder.h
//  ActionTap
//
//  Created by Avery Lamp on 3/28/15.
//  Copyright (c) 2015 Sebastian Cain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AudioRecorder.h"

@interface Recorder : UIViewController
@property CADisplayLink *displayLink;
@property UITapGestureRecognizer *tapGesture;
@property AudioRecorder *audioRecorder;

@property float LOW_VOLUME_THRESHOLD;
@property float HIGH_VOLUME_THRESHOLD;
-(void)startNewPatternWithName:(NSString*)name withURL:(NSURL*)url;


@end

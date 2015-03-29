//
//  Recorder.h
//  ActionTap
//
//  Created by Avery Lamp on 3/28/15.
//  Copyright (c) 2015 Sebastian Cain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Recorder : UIViewController
@property CADisplayLink *displayLink;
@property UITapGestureRecognizer *tapGesture;
-(void)startNewPatternWithName:(NSString*)name withURL:(NSURL*)url;


@end

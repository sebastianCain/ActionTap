//
//  MotionListener.h
//  ActionTap
//
//  Created by Ryan Sullivan on 3/28/15.
//  Copyright (c) 2015 Sebastian Cain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>
@interface MotionListener : NSObject <UIAccelerometerDelegate>
@property (nonatomic, retain) CMMotionManager *motionManager;
-(float)getMagnitude;
@end

//
//  MotionListener.m
//  ActionTap
//
//  Created by Ryan Sullivan on 3/28/15.
//  Copyright (c) 2015 Sebastian Cain. All rights reserved.
//

#import "MotionListener.h"
@implementation MotionListener

-(instancetype)init
{
    self = [super init];
    if(self)
    {
        self.motionManager = [[CMMotionManager alloc] init];
        [self.motionManager startAccelerometerUpdates];
        [self.motionManager setAccelerometerUpdateInterval:1/60.0];
        [self.motionManager startAccelerometerUpdatesToQueue:[[NSOperationQueue alloc] init] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error)
        {
            
        }];
    }
    return self;
}
-(float)getMagnitude{
    CMAccelerometerData *returnedData = self.motionManager.accelerometerData;
    float magnitude = 100*(ABS(returnedData.acceleration.z));
    return magnitude;
}
@end

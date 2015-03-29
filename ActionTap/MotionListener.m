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
        [self.motionManager setAccelerometerUpdateInterval:0.1];
        [self.motionManager startAccelerometerUpdatesToQueue:[[NSOperationQueue alloc] init] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error)
        {
            
            CMAccelerometerData *returnedData = _motionManager.accelerometerData;
            
            int x = returnedData.acceleration.x;
            int y = returnedData.acceleration.y;
            int z = returnedData.acceleration.z;
            NSLog(@"X: %i, Y: %i, Z: %i", x, y, z);
        }];
    }
    return self;
}
-(float)getMagnitude{
    CMAccelerometerData *returnedData = self.motionManager.accelerometerData;
    return returnedData.acceleration.x + returnedData.acceleration.y + returnedData.acceleration.z;
}
@end

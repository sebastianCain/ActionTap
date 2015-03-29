//
//  ActionViewController.h
//  ActionTap
//
//  Created by Sebastian Cain on 3/28/15.
//  Copyright (c) 2015 Sebastian Cain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActionViewController : UIViewController

@property UIButton *startButton;
@property BOOL recording;
@property int numberOfTaps;
@property double startTime
@end

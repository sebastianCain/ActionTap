//
//  MainViewController.h
//  ActionTap
//
//  Created by Sebastian Cain on 3/28/15.
//  Copyright (c) 2015 Sebastian Cain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController <UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property UIView *page1;
@property UIView *page2;
@property UIView *page3;

@property UIScrollView *scrollView;
@property UIPageControl *pageControl;

@property NSMutableDictionary *allPatterns;

@property UITableView* tableView;

@property UIButton *startButton;
@property UIButton *confirmButton;
@property BOOL recording;
@property int numberOfTaps;
@property double startTime;
@property double lastTapTime;
@property  NSMutableArray *tapData;

@property   NSArray *allPatternsForTV;

@property BOOL scrollLock;

@end

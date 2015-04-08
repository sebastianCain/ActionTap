//
//  MainViewController.h
//  ActionTap
//
//  Created by Sebastian Cain on 3/28/15.
//  Copyright (c) 2015 Sebastian Cain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pattern+Pattern_Functions.h"

@interface MainViewController : UIViewController <UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property UIView *page1;
@property UIView *page2;
@property UIView *page3;

@property UIScrollView *scrollView;
@property UIPageControl *pageControl;

@property NSMutableDictionary *allPatterns;

@property UITableView* tableView;

@property UIButton *startButton;
@property UIButton *actionsButton;
@property BOOL recording;
@property BOOL listening;
@property int numberOfTaps;
@property double startTime;
@property double lastTapTime;
@property  NSMutableArray *tapData;

@property   NSMutableArray *allPatternsForTV;

@property BOOL scrollLock;
@property (nonatomic)BOOL editingPattern;

@property BOOL patternPicked;
@property NSString *pickedPatternName;
@property Pattern* pickedPattern;
@property Pattern* backgroudPattern;
@property Pattern * closestPattern;
@property NSString *closestPatternName;
@property int lastMin;

@property UITextField   *textField;
@property UIButton *confirmButton;
@property UIButton *cancelButton;

@property NSString *scheme;
@property NSString *schemeValue;

@property NSString *url;

@property BOOL shouldJumpToPage3;

@property UIView *bgView;
@property UILabel *bgRecording;

@end

//
//  CreateViewController.h
//  ActionTap
//
//  Created by Joshua Liu on 3/29/15.
//  Copyright (c) 2015 Sebastian Cain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pattern+Pattern_Functions.h"
#import "MainViewController.h"
@interface CreateViewController : UIViewController

@property UITableView *tableView;
@property NSInteger *selectedRowIndex;
@property (nonatomic, strong) NSArray *schemes;
@property UILabel *action;
@property NSString *scheme;
@property NSString *schemeValue;
@property NSString *originalLabelText;
@property UITextField *textfield;
@property UIButton *confirmButton;
@property UIButton *resignButton;
@property int arrayindex;

@property UIToolbar *numberToolbar;


@property BOOL patternPicked;
@property NSString *pickedPatternName;
@property Pattern* pickedPattern;

@end

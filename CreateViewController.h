//
//  CreateViewController.h
//  ActionTap
//
//  Created by Joshua Liu on 3/29/15.
//  Copyright (c) 2015 Sebastian Cain. All rights reserved.
//

#import <UIKit/UIKit.h>

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



@end

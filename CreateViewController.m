//
//  CreateViewController.m
//  ActionTap
//
//  Created by Joshua Liu on 3/29/15.
//  Copyright (c) 2015 Sebastian Cain. All rights reserved.
//

#import "CreateViewController.h"

@interface CreateViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@end

@implementation CreateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
	numberToolbar.barStyle = UIBarStyleBlackTranslucent;
	UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelNumberPad)];
	[cancelButton setTintColor:[UIColor colorWithRed:46/255.0 green:204/255.0 blue:113/255.0 alpha:1.0]];
	UIBarButtonItem *donebutton = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)];
	[donebutton setTintColor:[UIColor colorWithRed:46/255.0 green:204/255.0 blue:113/255.0 alpha:1.0]];
	numberToolbar.items = [NSArray arrayWithObjects:
						   cancelButton,
						   [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
						   donebutton,
						   nil];
	[numberToolbar sizeToFit];
	self.numberToolbar = numberToolbar;
	
    UIButton *resignButton = [[UIButton alloc]initWithFrame:self.view.frame];
    resignButton.userInteractionEnabled = NO;
    self.resignButton = resignButton;
    [self.resignButton addTarget:self action:@selector(resignKeyboard) forControlEvents:UIControlEventTouchUpInside ];
    [self.view addSubview:self.resignButton];
    
    
    
    UILabel *actionLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2, self.view.frame.size.width/2 - 500, 100, 100)];
    actionLabel.center = CGPointMake(CGRectGetMidX(self.view.frame)-100, self.view.frame.size.width/4);
    actionLabel.text = @"Action:";
    [self.view addSubview:actionLabel];
    
    self.action = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2, self.view.frame.size.width/2 - 500, 270, 100)];
    self.action.center = CGPointMake(CGRectGetMidX(self.view.frame)+50, self.view.frame.size.width/4);
    self.action.text = @"";
    [self.view addSubview:self.action];
    
    
    self.schemes = [[NSArray alloc] initWithObjects:@"Workflow",@"Music",@"Phone",@"SMS", nil];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(20, 200, self.view.frame.size.width-40, self.view.frame.size.height - 420)];
    [tableView setDataSource:self];
    [tableView setDelegate:self];
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
    UIButton *confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height*3/4, 150, 80)];
    confirmButton.backgroundColor = [UIColor blueColor];
    confirmButton.titleLabel.text = @"Confirm";
    [confirmButton addTarget:self action:@selector(showMainMenu) forControlEvents:UIControlEventTouchUpInside];
    self.confirmButton = confirmButton;
    [self.view addSubview:confirmButton];
}

-(void)showMainMenu {
    [self performSegueWithIdentifier:@"showMainMenu" sender:self];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.resignButton.userInteractionEnabled =YES;
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    self.textfield = [[UITextField alloc] initWithFrame:CGRectMake(100, 10, 250, 80)];
    [self.textfield addTarget:self
                  action:@selector(textFieldDidChange:)
        forControlEvents:UIControlEventEditingChanged];
    self.textfield.backgroundColor = [UIColor blackColor];
    self.textfield.delegate = self;
	if (indexPath.row == 3 || indexPath.row == 4) {
		self.textfield.inputAccessoryView = self.numberToolbar;
		
	}
	
    [cell addSubview:self.textfield];
    
    if (indexPath.row == 0) {
        self.action.text = @"Run workflow: ";
    } else if (indexPath.row == 1) {
        self.action.text = @"Play/Pause Music";
        [self.textfield removeFromSuperview];
    } else if (indexPath.row == 2) {
        self.action.text = @"Call: ";
    } else if (indexPath.row == 3) {
        self.action.text = @"Send text to: ";
    }
    
    self.originalLabelText = self.action.text;
    
    self.selectedRowIndex = indexPath.row;
    self.arrayindex = indexPath.row;
    [tableView beginUpdates];
    [tableView endUpdates];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.textfield removeFromSuperview];
}

-(void)textFieldDidChange :(UITextField *)theTextField{
    self.schemeValue = theTextField.text;
    self.action.text = [self.originalLabelText stringByAppendingString:self.schemeValue];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //check if the index actually exists
    if(indexPath.row == self.selectedRowIndex) {
        return 100;
    }
    return 44;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    
    
    cell.textLabel.text = self.schemes[indexPath.row];
    
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.schemes count];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)resignKeyboard{
    [self.textfield resignFirstResponder];
    self.resignButton.userInteractionEnabled = NO;
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    MainViewController *mainVC = (MainViewController*)segue.destinationViewController;
    mainVC.pickedPattern = self.pickedPattern;
    mainVC.pickedPatternName = self.pickedPatternName;
    mainVC.patternPicked = YES;
    NSString *url;
    if (self.arrayindex == 0) {
        url = [@"workflow://import-workflow?url=" stringByAppendingString:self.schemeValue];
    } else if (self.arrayindex == 1) {
        url = @"music:";
    } else if (self.arrayindex == 2) {
        url = [@"tel:" stringByAppendingString:self.schemeValue];
    } else if (self.arrayindex == 3) {
        url = [@"sms:" stringByAppendingString:self.schemeValue];
    }
    mainVC.pickedPattern.url = url;
    
    mainVC.shouldJumpToPage3 = YES;
    
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end

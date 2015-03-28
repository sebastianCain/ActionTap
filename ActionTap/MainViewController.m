//
//  MainViewController.m
//  ActionTap
//
//  Created by Sebastian Cain on 3/28/15.
//  Copyright (c) 2015 Sebastian Cain. All rights reserved.
//

#import "MainViewController.h"
#import "MyActionsViewController.h"
#import "ActionViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self.view setBackgroundColor:[UIColor blackColor]];
	UIImageView *bgimage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"willsmith.png"]];
	[bgimage setFrame:CGRectMake(0, self.view.frame.size.height-self.view.frame.size.width, self.view.frame.size.width, self.view.frame.size.width)];
	[bgimage setContentMode:UIViewContentModeScaleAspectFill];
	
	
	[self.view addSubview:bgimage];
	
	NSLog(@"%@", bgimage);
	
    // Do any additional setup after loading the view.
	UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-40, 100)];
	[title setText:@"jarvis II"];
	[title setTextColor:[UIColor whiteColor]];
	[title setFont:[UIFont fontWithName:@"AvenirNext-UltraLight" size:72]];
	[title setTextAlignment:NSTextAlignmentCenter];
	[title setCenter:CGPointMake(self.view.frame.size.width/2, 100)];
	[self.view addSubview:title];
	
	UIButton *newAction = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
	[newAction.layer setCornerRadius:50];
	[newAction.layer setBorderWidth:1];
	[newAction.layer setBorderColor:[UIColor purpleColor].CGColor];
	[newAction.layer setMasksToBounds:YES];
	[newAction.titleLabel setNumberOfLines:2];
	[newAction setTitle:@"new\naction" forState:UIControlStateNormal];
	[newAction setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[newAction.titleLabel setFont:[UIFont fontWithName:@"AvenirNext-UltraLight" size:20]];
	[newAction.titleLabel setTextAlignment:NSTextAlignmentCenter];
	[newAction setCenter:CGPointMake(self.view.frame.size.width/2-120, 500)];
	[newAction addTarget:self action:@selector(newAction) forControlEvents:UIControlEventTouchUpInside];
	//[self.view addSubview:newAction];
	
	UIButton *myActions = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
	[myActions.layer setCornerRadius:50];
	[myActions.layer setBorderWidth:1];
	[myActions.layer setBorderColor:[UIColor purpleColor].CGColor];
	[myActions.layer setMasksToBounds:YES];
	[myActions.titleLabel setNumberOfLines:2];
	[myActions setTitle:@"my\nactions" forState:UIControlStateNormal];
	[myActions setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[myActions.titleLabel setFont:[UIFont fontWithName:@"AvenirNext-UltraLight" size:20]];
	[myActions.titleLabel setTextAlignment:NSTextAlignmentCenter];
	[myActions setCenter:CGPointMake(self.view.frame.size.width/2, 500)];
	[myActions addTarget:self action:@selector(myActions) forControlEvents:UIControlEventTouchUpInside];
	//[self.view addSubview:myActions];
	
	UIButton *settings = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
	[settings.layer setCornerRadius:50];
	[settings.layer setBorderWidth:1];
	[settings.layer setBorderColor:[UIColor purpleColor].CGColor];
	[settings.layer setMasksToBounds:YES];
	[settings.titleLabel setNumberOfLines:2];
	[settings setTitle:@"settings" forState:UIControlStateNormal];
	[settings setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[settings.titleLabel setFont:[UIFont fontWithName:@"AvenirNext-UltraLight" size:20]];
	[settings.titleLabel setTextAlignment:NSTextAlignmentCenter];
	[settings setCenter:CGPointMake(self.view.frame.size.width/2+120, 500)];
	[settings addTarget:self action:@selector(settings) forControlEvents:UIControlEventTouchUpInside];
	//[self.view addSubview:settings];
}

-(void)newAction {
	[self performSegueWithIdentifier:@"maintoaction" sender:@"new"];
}

-(void)myActions {
	[self performSegueWithIdentifier:@"maintoactions" sender:nil];
}

-(void)settings {
	[self performSegueWithIdentifier:@"maintosettings" sender:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

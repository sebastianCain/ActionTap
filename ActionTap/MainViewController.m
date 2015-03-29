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
#import "QuartzCore/QuartzCore.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self.view setBackgroundColor:[UIColor colorWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0]];
	UIImageView *bgimage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"willsmith.png"]];
	[bgimage setFrame:CGRectMake(0, self.view.frame.size.height/2-self.view.frame.size.width/2-30, self.view.frame.size.width, self.view.frame.size.width)];
	[bgimage setContentMode:UIViewContentModeScaleAspectFill];
	
	CAGradientLayer *l = [CAGradientLayer layer];
	l.frame = bgimage.bounds;
	l.colors = [NSArray arrayWithObjects:(id)[UIColor whiteColor].CGColor, (id)[UIColor clearColor].CGColor, nil];
	l.startPoint = CGPointMake(0.5f, 0.5f);
	l.endPoint = CGPointMake(0.5f, 1.0f);
	bgimage.layer.mask = l;
	
	[self.view addSubview:bgimage];
	
	NSLog(@"%@", bgimage);
	
    // Do any additional setup after loading the view.
	UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-40, 100)];
	[title setText:@"jarvis"];
	[title setTextColor:[UIColor whiteColor]];
	[title setFont:[UIFont fontWithName:@"AvenirNext-UltraLight" size:72]];
	[title setTextAlignment:NSTextAlignmentCenter];
	[title setCenter:CGPointMake(self.view.frame.size.width/2, 75)];
	[self.view addSubview:title];
	
	int swaggyp = (self.view.frame.size.width-80)/3;
	
	UIButton *newAction = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, swaggyp, swaggyp)];
	[newAction.layer setCornerRadius:swaggyp/2];
	[newAction.layer setBorderWidth:2];
	[newAction.layer setBorderColor:[UIColor whiteColor].CGColor];
	[newAction.layer setMasksToBounds:YES];
	[newAction.titleLabel setNumberOfLines:2];
	[newAction setTitle:@"new\naction" forState:UIControlStateNormal];
	[newAction setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[newAction.titleLabel setFont:[UIFont fontWithName:@"AvenirNext-Regular" size:17]];
	[newAction.titleLabel setTextAlignment:NSTextAlignmentCenter];
	[newAction setCenter:CGPointMake(self.view.frame.size.width/2-swaggyp-20, self.view.frame.size.height-70)];
	[newAction addTarget:self action:@selector(newAction) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:newAction];
	
	UIButton *myActions = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, swaggyp, swaggyp)];
	[myActions.layer setCornerRadius:swaggyp/2];
	[myActions.layer setBorderWidth:2];
	[myActions.layer setBorderColor:[UIColor whiteColor].CGColor];
	[myActions.layer setMasksToBounds:YES];
	[myActions.titleLabel setNumberOfLines:2];
	[myActions setTitle:@"my\nactions" forState:UIControlStateNormal];
	[myActions setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[myActions.titleLabel setFont:[UIFont fontWithName:@"AvenirNext-Regular" size:17]];
	[myActions.titleLabel setTextAlignment:NSTextAlignmentCenter];
	[myActions setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height-70)];
	[myActions addTarget:self action:@selector(myActions) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:myActions];
	
	UIButton *settings = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, swaggyp, swaggyp)];
	[settings.layer setCornerRadius:swaggyp/2];
	[settings.layer setBorderWidth:2];
	[settings.layer setBorderColor:[UIColor whiteColor].CGColor];
	[settings.layer setMasksToBounds:YES];
	[settings.titleLabel setNumberOfLines:2];
	[settings setTitle:@"settings" forState:UIControlStateNormal];
	[settings setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[settings.titleLabel setFont:[UIFont fontWithName:@"AvenirNext-Regular" size:17]];
	[settings.titleLabel setTextAlignment:NSTextAlignmentCenter];
	[settings setCenter:CGPointMake(self.view.frame.size.width/2+swaggyp+20, self.view.frame.size.height-70)];
	[settings addTarget:self action:@selector(settings) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:settings];
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

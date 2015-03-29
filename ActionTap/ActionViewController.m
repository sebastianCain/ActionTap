
//
//  ActionViewController.m
//  ActionTap
//
//  Created by Sebastian Cain on 3/28/15.
//  Copyright (c) 2015 Sebastian Cain. All rights reserved.
//

#import "ActionViewController.h"

@interface ActionViewController ()

@end

@implementation ActionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 60)];
    title.text = @"Action";
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont boldSystemFontOfSize:40];
    [self.view addSubview:title];
    
    
    UIButton *startButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 - 80, self.view.frame.size.height*2/3, 80, 80)];
    startButton.backgroundColor = [UIColor greenColor];
    [startButton addTarget:self action:@selector(startRecording) forControlEvents:UIControlEventTouchUpInside];
    self.startButton = startButton;
    [self.view addSubview:startButton];
    
    
    
    
    // Do any additional setup after loading the view.
}

-(void)startRecording{
    self.recording = YES;
    self.numberOfTaps = 0;
    [UIView animateWithDuration:0.5 animations:^{
        self.startButton.alpha = 0.0f;
    }];
    self.startTime = CACurrentMediaTime();
    
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if (self.recording) {
        self.numberOfTaps +=1;
        
        
    }
    
    
    
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

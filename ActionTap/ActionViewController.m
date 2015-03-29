
//
//  ActionViewController.m
//  ActionTap
//
//  Created by Sebastian Cain on 3/28/15.
//  Copyright (c) 2015 Sebastian Cain. All rights reserved.
//

#import "ActionViewController.h"

@interface ActionViewController ()
@property UIView *currentBar;
@property NSMutableArray *allBars;
@end

@implementation ActionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 60)];
    title.text = @"Action";
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont boldSystemFontOfSize:40];
    [self.view addSubview:title];
    
    
    UIButton *startButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 - 40, self.view.frame.size.height*2/3, 80, 80)];
    startButton.backgroundColor = [UIColor greenColor];
    [startButton addTarget:self action:@selector(startRecording) forControlEvents:UIControlEventTouchUpInside];
    self.startButton = startButton;
    [self.view addSubview:startButton];
    
    UIButton *replayButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 - 80, self.view.frame.size.height*3/4, 80, 80)];
    replayButton.backgroundColor = [UIColor greenColor];
    [replayButton addTarget:self action:@selector(replay) forControlEvents:UIControlEventTouchUpInside];
    self.replayButton = replayButton;
    //[self.view addSubview:replayButton];
    
    self.currentBar = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height/2-50, 4, 100)];
    self.currentBar.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.currentBar];
    
    
    
    // Do any additional setup after loading the view.
}

-(void)startRecording{
    self.recording = YES;
    self.numberOfTaps = 0;
    [UIView animateWithDuration:0.5 animations:^{
        self.startButton.alpha = 0.0f;
    }];
    self.tapData = [[NSMutableArray alloc]init];
    self.startTime = CACurrentMediaTime();
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(runLoop)];
    displayLink.frameInterval = 1;
    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
    self.currentBar.frame =CGRectMake(0, self.view.frame.size.height/2-50, 4, 100);
    for (UIView *v in self.allBars) {
        [v removeFromSuperview];
    }
    self.allBars = [[NSMutableArray alloc]init];
    
    
    
    
    
}

-(void)replay
{
    
}

-(void)runLoop{
    if (self.recording) {
        if (self.lastTapTime >self.startTime) {
            
            self.currentBar.center = CGPointMake(((CACurrentMediaTime() - self.startTime)/5)*self.view.frame.size.width, self.view.frame.size.height/2);
        }
        
        if (CACurrentMediaTime() - self.startTime >5 ) {
            self.recording = NO;
            [UIView animateWithDuration:1.0 animations:^{
                self.startButton.alpha = 1.0;
            }];
            return;
        }
    }
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if (self.recording) {
        if (CACurrentMediaTime() - self.startTime >5 ) {
            self.recording = NO;
            [UIView animateWithDuration:1.0 animations:^{
                self.startButton.alpha = 1.0;
            }];
            return;
        }
    
        if ([self.tapData count] == 0) {
            self.startTime = CACurrentMediaTime();
            self.lastTapTime = CACurrentMediaTime();
            [self.tapData addObject:[NSNumber numberWithDouble:0.0]];
        }else{
            UIView *bar = [[UIView alloc]initWithFrame:CGRectMake(((CACurrentMediaTime() - self.startTime)/5)*self.view.frame.size.width, self.view.frame.size.height/2-50, 4, 100)];
            bar.backgroundColor = [UIColor greenColor];
            [self.view addSubview:bar];
            [self.allBars addObject:bar];
            NSLog(@"tapCount - %d",self.numberOfTaps);
            NSLog(@"Seconds from last tap - %f", CACurrentMediaTime()-self.lastTapTime);
            [self.tapData addObject:[NSNumber numberWithDouble:(CACurrentMediaTime()-self.lastTapTime)]];
            self.lastTapTime = CACurrentMediaTime();
        }
        
        
        
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

//
//  Recorder.m
//  ActionTap
//
//  Created by Avery Lamp on 3/28/15.
//  Copyright (c) 2015 Sebastian Cain. All rights reserved.
//

#import "Recorder.h"

@interface Recorder ()

@end

@implementation Recorder

- (void)viewDidLoad {
    [super viewDidLoad];
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(onDisplayLink)];
    self.displayLink.frameInterval = 6;
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    [self.displayLink setPaused:NO];
    self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    self.tapGesture.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:self.tapGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleTapGesture:(UITapGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateRecognized) {
        self.tapGesture.numberOfTapsRequired = 1;
        [self startReadingInput];
    }
}


-(void)onDisplayLink{
    
}

-(NSArray*)startNewPatternWithName:(NSString*)name withURL:(NSURL*)url{
    //record beats every 1/10th second, starting with a hit, into array of 50 elements
    //create permutations in a 2d array
    
    
    return nil;
}
-(void)startReadingInput{
    
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

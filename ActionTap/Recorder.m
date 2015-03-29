//
//  Recorder.m
//  ActionTap
//
//  Created by Avery Lamp on 3/28/15.
//  Copyright (c) 2015 Sebastian Cain. All rights reserved.
//

#import "Recorder.h"
#import "DataAccess.h"
#import "Pattern+Pattern_Functions.h"
@interface Recorder ()
@property NSString *name;
@property NSMutableArray *tempPattern; //of NSNumbers hoding float values
@end

@implementation Recorder

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(onDisplayLink)];
    self.displayLink.frameInterval = 6;
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    [self.displayLink setPaused:NO];
    //self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    //self.tapGesture.numberOfTapsRequired = 2;
    //[self.view addGestureRecognizer:self.tapGesture];
    
    self.LOW_VOLUME_THRESHOLD = 60;
    self.HIGH_VOLUME_THRESHOLD = 180;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)handleTapGesture:(UITapGestureRecognizer *)sender {
//    if (sender.state == UIGestureRecognizerStateRecognized) {
//        self.tapGesture.numberOfTapsRequired = 1;
//        [self startReadingInput];
//    }
//}

-(void)onDisplayLink
{
    float volume = [self.audioRecorder getVolume];
    if ([self.tempPattern count] < 50)
    {
        if (volume > self.LOW_VOLUME_THRESHOLD && volume < self.HIGH_VOLUME_THRESHOLD)
        {
            [self.tempPattern addObject:[NSNumber numberWithInt:1]];
        } else {
            [self.tempPattern addObject:[NSNumber numberWithInt:0]];
        }
    } else {
        //Save To core data
        NSManagedObjectContext *context = [DataAccess context];
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Pattern"];
        NSArray *ar = [context executeFetchRequest:request error:nil];
        BOOL objectFound = NO;
        Pattern *pattern;
        for (Pattern *p in ar) {
            if ([p.name isEqualToString:self.name]) {
                objectFound = YES;
                pattern = p;
            }
        }
        
        if (!objectFound) {
            pattern = [NSEntityDescription insertNewObjectForEntityForName:@"Pattern" inManagedObjectContext:context];
            pattern.name = self.name;
        }
        
        [[DataAccess sharedInstance]saveContext];
        
        
        
        //Trigger function in delegate
        [self.delegate recordingFinishedForPatternWithName:self.name];
    }
}

-(NSArray*)CreateNewPatternWithName:(NSString*)name withURL:(NSURL*)url
{
    if([self.displayLink isPaused] == YES)
    {
        self.name = name;
        [self.displayLink setPaused:NO];
    }
    return nil;

}

-(void)startReadingInput
{
    
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

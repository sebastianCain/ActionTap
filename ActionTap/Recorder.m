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
@property float LOW_VOLUME_THRESHOLD;
@property float HIGH_VOLUME_THRESHOLD;
@property float LOW_MAGNITUDE_THRESHOLD;
@property float HIGH_MAGNITUDE_THRESHOLD;
@property(readwrite) bool isRecording;
@end

@implementation Recorder



-(instancetype)init
{
    self = [super init];
    if(self ){
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(onDisplayLink)];
        self.displayLink.frameInterval = 1;
        [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        [self.displayLink setPaused:NO];
        //self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
        //self.tapGesture.numberOfTapsRequired = 2;
        //[self.view addGestureRecognizer:self.tapGesture];
        
        self.LOW_VOLUME_THRESHOLD = -22;
        self.HIGH_VOLUME_THRESHOLD = 0;
        self.LOW_MAGNITUDE_THRESHOLD = 98;
        self.HIGH_MAGNITUDE_THRESHOLD = 102;
        self.audioRecorder = [[AudioRecorder alloc] init];
        self.motionListener = [[MotionListener alloc] init];
        self.isRecording = NO;
    }
    
    return self;
}



//- (void)handleTapGesture:(UITapGestureRecognizer *)sender {
//    if (sender.state == UIGestureRecognizerStateRecognized) {
//        self.tapGesture.numberOfTapsRequired = 1;
//        [self startReadingInput];
//    }
//}

-(void)onDisplayLink
{
    //float volume = [self.audioRecorder getVolume];
    float magnitude = [self.motionListener getMagnitude];
                    NSLog(@"%f", magnitude);
    if ([self.tempPattern count] < 300)
    {
        if (magnitude < self.LOW_MAGNITUDE_THRESHOLD || magnitude > self.HIGH_MAGNITUDE_THRESHOLD)
        {

            [self.tempPattern addObject:[NSNumber numberWithInt:1]];
        } else {
            [self.tempPattern addObject:[NSNumber numberWithInt:0]];
        }
    } else {
        [self.displayLink setPaused:YES];
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
-(void)startNewPatternWithName:(NSString *)name withURL:(NSURL *)url
{
        self.isRecording = YES;
        self.tempPattern = [[NSMutableArray alloc] init];
        self.name = name;
        [self.displayLink setPaused:NO];
}

-(void)startReadingInput
{
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    
}

-(void)stopRecording
{
    self.isRecording = NO;
    self.name = @"";
    [self.displayLink setPaused:YES];
}

-(double)compareArray:(NSMutableArray *)patternArray withArray:(NSMutableArray *)inputArray
{
    
    
    return 0.0;
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

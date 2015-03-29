//
//  AudioRecorder.m
//  ActionTap
//
//  Created by Ryan Sullivan on 3/28/15.
//  Copyright (c) 2015 Sebastian Cain. All rights reserved.
//

#import "AudioRecorder.h"

@implementation AudioRecorder

- (instancetype) init {
    return [self initWithSongName: @"Default"];
}


- (instancetype) initWithSongName: (NSString *)songName {
    self = [super init];
    if (self){
        NSArray *dirPaths;
        NSString *docsDir;
        
        dirPaths = NSSearchPathForDirectoriesInDomains(
                                                       NSDocumentDirectory, NSUserDomainMask, YES);
        docsDir = dirPaths[0];
        
        NSString *soundFilePath = [docsDir
                                   stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@", songName,@".caf"]];
        
        NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
        
        NSDictionary *recordSettings = [NSDictionary
                                        dictionaryWithObjectsAndKeys:
                                        [NSNumber numberWithInt:AVAudioQualityMin],
                                        AVEncoderAudioQualityKey,
                                        [NSNumber numberWithInt:16],
                                        AVEncoderBitRateKey,
                                        [NSNumber numberWithInt:1],
                                        AVNumberOfChannelsKey,
                                        [NSNumber numberWithFloat:44100.0],
                                        AVSampleRateKey,
                                        nil];
        
        NSError *error = nil;
        
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord
                            error:nil];
        
        _audioRecorder = [[AVAudioRecorder alloc]
                          initWithURL:soundFileURL
                          settings:recordSettings
                          error:&error];
        
        if (error)
        {
            NSLog(@"error: %@", [error localizedDescription]);
        } else {
            [_audioRecorder prepareToRecord];
            _audioRecorder.meteringEnabled = YES;
        }
    }
    return self;
}

- (void)recordAudio{
    if (!_audioRecorder.recording)
    {
        self.recording = [_audioRecorder record];
    }
}

- (void)stopAudio {
    
    if (_audioRecorder.recording)
    {
        [_audioRecorder stop];
        self.recording = NO;
    }
}

-(void)pauseUnpause
{
    if (_audioRecorder.recording) {
        [_audioRecorder pause];
        self.recording = NO;
    }else{
        self.recording = [_audioRecorder record];
    }
}

-(NSURL*)getSongURL{
    return _audioRecorder.url;
}


-(float)getVolume{
    [_audioRecorder updateMeters];
    return [_audioRecorder averagePowerForChannel:0];
}

//Returns the amount of time that has passed in seconds, with millisecond precision
//NSTimeInterval is a typealiased double
-(NSTimeInterval)getTimeSinceStart{
    return [_audioRecorder currentTime];
}
@end

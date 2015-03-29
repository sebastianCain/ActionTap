//
//  AudioRecorder.h
//  ActionTap
//
//  Created by Ryan Sullivan on 3/28/15.
//  Copyright (c) 2015 Sebastian Cain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface AudioRecorder : NSObject <AVAudioRecorderDelegate, AVAudioPlayerDelegate>
@property (strong, nonatomic) AVAudioRecorder *audioRecorder;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
@property BOOL recording;
- (instancetype) initWithSongName: (NSString *)songName;
- (void)recordAudio;
- (void)stopAudio;
-(void)pauseUnpause;
-(NSURL*)getSongURL;
-(float)getVolume;
-(NSTimeInterval)getTimeSinceStart;
@end

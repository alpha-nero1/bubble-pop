//
//  Sound.m
//  BubblePop
//
//  Created by Alessandro Alberga on 25/4/17.
//  Copyright © 2017 ___Alberga Apps___. All rights reserved.
//

#import "Sound.h"

@implementation Sound {
    NSString *bubbleSoundFilePath;
    NSURL *bubbleSoundFileURL;
    NSString *buttonSoundFilePath;
    NSURL *buttonSoundFileURL;
    NSString *countSoundFilePath;
    NSURL *countSoundFileURL;
    AVAudioPlayer *bubblePlayer;
    AVAudioPlayer *buttonPlayer;
    AVAudioPlayer *countPlayer;
}

/**
 *  Initialise the sound variables.
 */
- (instancetype)init
{
    self = [super init];
    if (self) {
        bubbleSoundFilePath = [NSString stringWithFormat:@"%@/bubblePop.wav",[[NSBundle mainBundle] resourcePath]];
        bubbleSoundFileURL = [NSURL fileURLWithPath:bubbleSoundFilePath];
        bubblePlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:bubbleSoundFileURL error:nil];
        buttonSoundFilePath = [NSString stringWithFormat:@"%@/buttonClick.wav",[[NSBundle mainBundle] resourcePath]];
        buttonSoundFileURL = [NSURL fileURLWithPath:buttonSoundFilePath];
        buttonPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:buttonSoundFileURL error:nil];
        countSoundFilePath = [NSString stringWithFormat:@"%@/countDown.wav",[[NSBundle mainBundle] resourcePath]];
        countSoundFileURL = [NSURL fileURLWithPath:countSoundFilePath];
        countPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:countSoundFileURL error:nil];
    }
    return self;
}

- (void)playPopSound {
    [bubblePlayer play];
}

- (void)playButtonSound {
    [buttonPlayer play];
}

- (void)playCountDown {
    [countPlayer play];
}

@end

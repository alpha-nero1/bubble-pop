//
//  Sound.h
//  BubblePop
//
//  Created by Alessandro Alberga on 25/4/17.
//  Copyright © 2017 ___Alberga Apps___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface Sound : NSObject

- (void)playPopSound;
- (void)playButtonSound;
- (void)playCountDown;

@end

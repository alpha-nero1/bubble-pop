//
//  Player.h
//  BubblePop
//
//  Created by Alessandro Alberga on 16/4/17.
//  Copyright © 2017 ___Alberga Apps___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject<NSCoding>

- (id)initWithName:(NSString *)newName : (int)newHighScore;
- (void)updateCharacter: (int) score;

@property (nonatomic, retain) NSString *name;
@property (nonatomic) int highScore;

@end

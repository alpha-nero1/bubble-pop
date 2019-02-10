//
//  MainMenu.h
//  BubblePop
//
//  Created by Alessandro Alberga on 15/4/17.
//  Copyright © 2017 ___Alberga Apps___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "Helpers.h"
#import "ScoreBoard.h"
#import "Bubble.h"
#import "GameScene.h"

@interface MainMenu : NSObject

-(id)initWithName:(CGFloat)swidth :(CGFloat)sheight;
-(SKSpriteNode *) createMenu;
-(SKSpriteNode *) createSettingsMenu;
-(SKSpriteNode *) createGameOverMenu : (NSString *) currentPlayerName;
-(SKSpriteNode *) createHelpMenu;

@property CGFloat width;
@property CGFloat height;

@end

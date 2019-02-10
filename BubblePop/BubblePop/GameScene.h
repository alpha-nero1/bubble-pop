//
//  GameScene.h
//  BubblePop
//
//  Created by Alessandro Alberga on 15/4/17.
//  Copyright © 2017 ___Alberga Apps___. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <UIKit/UIKit.h>
#import "MainMenu.h"
#import "Player.h"
#import "ScoreBoard.h"
#import "Bubble.h"
#import "Sound.h"

@interface GameScene : SKScene<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *nameField;
@property (nonatomic, strong) UISlider *secondsSlider;
@property (nonatomic, strong) UISlider *maxBubblesSlider;
@property (nonatomic, strong) Player *currentPlayer;
@property (nonatomic, strong) NSString *playerNameEntered;

@property CGFloat width;
@property CGFloat height;

@end

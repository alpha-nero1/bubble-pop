//
//  MainMenu.m
//  BubblePop
//
//  Created by Alessandro Alberga on 15/4/17.
//  Copyright © 2017 ___Alberga Apps___. All rights reserved.
//

#import "MainMenu.h"

@implementation MainMenu

UIColor *buttonColor;
@synthesize width;
@synthesize height;

-(id)initWithName:(CGFloat)swidth :(CGFloat)sheight {
    self = [super init];
    if (self) {
        self.width = swidth;
        self.height = sheight;
        buttonColor = [UIColor colorWithRed: 0.1 green: 0.4 blue: 0.8 alpha:1.0];
        
    }
    return self;
}

//MARK: - Create Methods.

/**
 *  This function creates the main menu and returns it.
 */
-(SKSpriteNode *) createMenu {
    CGSize menuS = CGSizeMake(width, height);
    SKSpriteNode *menu = [SKSpriteNode spriteNodeWithColor: [UIColor clearColor] size:  menuS];
    SKLabelNode *bubbleLabel = [[SKLabelNode alloc] init];
    SKLabelNode *popLabel = [[SKLabelNode alloc] init];
    SKSpriteNode *startGameButton = [SKSpriteNode spriteNodeWithColor: buttonColor size: CGSizeMake((width / 3.75),(height / 17.786))];
    SKSpriteNode *settingsGameButton = [SKSpriteNode spriteNodeWithColor: buttonColor size: CGSizeMake((width / 3.75),(height / 17.786))];
    SKSpriteNode *helpGameButton = [SKSpriteNode spriteNodeWithColor: buttonColor size: CGSizeMake((width / 3.75),(height / 17.786))];
    SKLabelNode *startLabel = [[SKLabelNode alloc] init];
    SKLabelNode *settingsLabel = [[SKLabelNode alloc] init];
    SKLabelNode *helpLabel = [[SKLabelNode alloc] init];
    
    startLabel = [Helpers configureLabelNode: startLabel : (width / 21.42) : CGPointMake(0, -(height / 133.4)) : @"Start"];
    settingsLabel = [Helpers configureLabelNode: settingsLabel : (width / 21.42) : CGPointMake(0, -(height / 133.4)) : @"Settings"];
    helpLabel = [Helpers configureLabelNode: helpLabel : (width / 21.42) : CGPointMake(0, -(height / 133.4)) : @"Help"];
    bubbleLabel = [Helpers configureLabelNode: bubbleLabel : (width / 8.33) : CGPointMake(0, (height / 3)) : @"bubble"];
    popLabel = [Helpers configureLabelNode:popLabel : (width / 8.33) : CGPointMake(0, (height / 3.7)) : @"Pop"];
    startGameButton = [Helpers configureButtonNode: startGameButton : CGPointMake(0, (height / 8.89)) : CGSizeMake((width / 3.75),(height / 17.786)): @"startButton"];
    settingsGameButton = [Helpers configureButtonNode: settingsGameButton : CGPointMake(0, 0) : CGSizeMake((width / 3.75),(height / 17.786)): @"settingsButton"];
    helpGameButton = [Helpers configureButtonNode: helpGameButton : CGPointMake(0, -(height / 8.89)) : CGSizeMake((width / 3.75),(height / 17.786)): @"helpButton"];
    
    [startGameButton addChild: startLabel];
    [settingsGameButton addChild: settingsLabel];
    [helpGameButton addChild: helpLabel];
    [Helpers animateUpAndDown: bubbleLabel];
    [Helpers animateUpAndDown: popLabel];
    [menu addChild: bubbleLabel];
    [menu addChild: popLabel];
    [menu addChild: startGameButton];
    [menu addChild: settingsGameButton];
    [menu addChild: helpGameButton];
    return menu;
}

/**
 *  This function creates the settings menu and returns it.
 */
-(SKSpriteNode *) createSettingsMenu {
    CGSize menuS = CGSizeMake(width,height);
    SKSpriteNode *menu = [SKSpriteNode spriteNodeWithColor: [UIColor clearColor] size:  menuS];
    SKLabelNode *titleLabel = [[SKLabelNode alloc] init];
    titleLabel = [Helpers configureLabelNode: titleLabel : (width / 12.5) : CGPointMake(0, (height / 2.668)) : @"settings"];
    [menu addChild: titleLabel];
    [menu addChild: [self createBackButton]];
    return menu;
}

/**
 *  This function creates the help menu and returns it.
 */
-(SKSpriteNode *) createHelpMenu {
    NSArray *textArr = [NSArray arrayWithObjects: @"bubble pop is a simple", @"game where the primary", @"objective is to pop", @"as many bubbles in a time", @"limit you set. change how", @"the game plays in the", @"settings and play your way." @"",@"Enjoy!", nil];
    int labelPositions[10] = {(height / 2.42), (height / 3.335), (height / 4.446), (height / 6.67), (height / 13.34), 0, -(height / 13.34), -(height / 6.67), -(height / 4.446), -(height / 3.335)};
    int count = 0;
    CGSize menuS = CGSizeMake(width, height);
    SKShapeNode *topCircle = [[SKShapeNode alloc] init];
    SKSpriteNode *rectangle = [SKSpriteNode spriteNodeWithColor: [UIColor whiteColor] size: CGSizeMake((width / 10), (height / 66.7))];
    topCircle.path = [Bubble circleInRect: CGRectMake(0, 0, (width / 7.5), (width / 7.5))];
    topCircle.fillColor = buttonColor;
    topCircle.lineWidth = 0;
    topCircle.position = CGPointMake(0, labelPositions[0]);
    topCircle.zPosition = -1;
    [Helpers spinNode: topCircle];
    [topCircle addChild: rectangle];
    SKSpriteNode *menu = [SKSpriteNode spriteNodeWithColor: [UIColor clearColor] size:  menuS];
    for (NSString *string in textArr) {
        count++;
        SKLabelNode *thisLabel = [[SKLabelNode alloc] init];
        thisLabel = [Helpers configureLabelNode: thisLabel : (width / 18.75) : CGPointMake(0, labelPositions[count]) : string];
        [menu addChild: thisLabel];
    }
    [menu addChild: topCircle];
    [menu addChild: [self createBackButton]];
    return menu;
}

/**
 *  This function creates the game over menu and returns it.
 */
-(SKSpriteNode *) createGameOverMenu : (NSString *) currentPlayerName {
    CGSize menuS = CGSizeMake(width, height);
    SKSpriteNode *menu = [SKSpriteNode spriteNodeWithColor: [UIColor clearColor] size:  menuS];
    SKLabelNode *gameOverLabel = [[SKLabelNode alloc] init];
    SKLabelNode *leaderboardLabel = [[SKLabelNode alloc] init];
    leaderboardLabel = [Helpers configureLabelNode: leaderboardLabel : (width / 15) : CGPointMake(0, (height / 3.335)) : @"Leaderboard"];
    gameOverLabel = [Helpers configureLabelNode: gameOverLabel : (width / 12.5) : CGPointMake(0, (height / 2.668)) : @"Game over"];
    leaderboardLabel.fontColor = buttonColor;
    [Helpers fadeAnimation: gameOverLabel];
    [menu addChild: gameOverLabel];
    [menu addChild: leaderboardLabel];
    [menu addChild: [self createScoreBoard : currentPlayerName]];
    [menu addChild: [self createBackButton]];
    return menu;
}

/**
 *  This function creates a sprite node for back button and returns it.
 */
-(SKSpriteNode *) createBackButton {
    SKSpriteNode *backButton = [SKSpriteNode spriteNodeWithColor: buttonColor size: CGSizeMake((width / 3.75), (height / 17.78))];
    SKLabelNode *backLabel = [[SKLabelNode alloc] init];
    backLabel = [Helpers configureLabelNode: backLabel : (width / 18.75) : CGPointMake(0, -(height / 133.4)) : @"Back"];
    [backButton addChild:backLabel];
    backButton = [Helpers configureButtonNode: backButton : CGPointMake(0, -(height / 2.668)) : CGSizeMake((width / 3.75), (height / 17.78)): @"backButton"];
    return backButton;
}

/**
 *  Creates the scoreboard node and returns it.
 */
-(SKSpriteNode *) createScoreBoard : (NSString *) currentPlayerName {
    int count = 0;
    int boardPosy[10] = {(height / 4.446), (height / 6.67), (height / 13.34), 0, -(height / 13.34), -(height / 6.67), -(height / 4.446), -(height / 3.335)};
    CGSize menuS = CGSizeMake(width,height);
    SKSpriteNode *board = [SKSpriteNode spriteNodeWithColor: [UIColor clearColor] size:  menuS];
    NSMutableArray *players = [ScoreBoard getPlayers];
    
    for (Player *player in players) {
        if (count < 8) {
            NSString *boardEntry = [NSString stringWithFormat: @"%@, highscore: %i", player.name, player.highScore];
            SKLabelNode *thisEntry = [[SKLabelNode alloc] initWithFontNamed: boardEntry];
            thisEntry = [Helpers configureLabelNode: thisEntry : (width / 21.42) : CGPointMake( 0, boardPosy[count]): boardEntry];
            if ([player.name isEqualToString: currentPlayerName]) { thisEntry.fontColor = [UIColor yellowColor]; }
            [board addChild: thisEntry];
            count++;
        } else {
            break;
        }
    }
    return board;
}

@end

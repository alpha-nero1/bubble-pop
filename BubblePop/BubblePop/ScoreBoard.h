//
//  ScoreBoard.h
//  BubblePop
//
//  Created by Alessandro Alberga on 15/4/17.
//  Copyright © 2017 ___Alberga Apps___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"
#import "Helpers.h"

@interface ScoreBoard : NSObject

+ (void) handleNewScoreEntry : (Player *) player;
+ (NSMutableArray *) getPlayers;
+ (Player *) currentPlayer : (NSString *) name;
+ (Boolean) matchesPlayer : (NSString *) name;
+ (void) grabPlayersArray;
+ (int) getHighestScore;

@end

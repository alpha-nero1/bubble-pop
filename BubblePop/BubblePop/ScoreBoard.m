//
//  ScoreBoard.m
//  BubblePop
//
//  Created by Alessandro Alberga on 15/4/17.
//  Copyright © 2017 ___Alberga Apps___. All rights reserved.
//

#import "ScoreBoard.h"

@implementation ScoreBoard

NSMutableArray<Player *> *players;

/**
 *  Fetch the players from nsuserdefaults.
 */
+ (NSMutableArray *) getPlayers {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [self sortScoreBoard];
    NSData *arrayData = [defaults objectForKey:@"players"];
    return [NSKeyedUnarchiver unarchiveObjectWithData: arrayData];
}

/**
 *  Executes a bubble sort of the score board, sorting by highscore
 *  and sets back into defaults.
 */
+ (void) sortScoreBoard {
    [self grabPlayersArray];
    for (int i = 0; i < players.count - 1; i++) {
    for (int i = 0; i < players.count - 1 ; i++) {
        if ([players objectAtIndex: i+1].highScore > [players objectAtIndex: i].highScore) { // Swap condition.
            Player *temp = [players objectAtIndex: i];
            [players replaceObjectAtIndex: i withObject: [players objectAtIndex: i + 1]];
            [players replaceObjectAtIndex: i + 1 withObject: temp];
        }
    }
    }
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject: players] forKey:@"players"]; // Insert back into NSUserDefaults
}

/**
 *  Adds a new player to the players array and saves.
 */
+ (void) handleNewScoreEntry : (Player *) player {
    [self grabPlayersArray];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [players addObject: player];
    [defaults setObject:[NSKeyedArchiver archivedDataWithRootObject: players] forKey:@"players"];
    [defaults setObject:[NSKeyedArchiver archivedDataWithRootObject: player] forKey:@"currentPlayer"];
}

/**
 *  This function checks if there exists a player with the same 
 *  name in the players array.
 */
+ (Boolean) matchesPlayer : (NSString *) name {
    [self grabPlayersArray];
    for (Player *player in players) {
        if ([player.name isEqualToString: name]) {
            return true;
        }
    }
    return false;
}

/**
 *  This function extracts and returns the current player saved.
 */
+ (Player *) currentPlayer : (NSString *) name {
    [self grabPlayersArray];
    for (Player *player in players) {
        if ([player.name isEqualToString: name]) {
            return player;
        }
    }
    return NULL;
}

/**
 *  This function returns the largest highscore value of all players.
 */
+ (int) getHighestScore {
    [self grabPlayersArray];
    int highscore = 0;
    for (Player *player in players) {
        if (player.highScore > highscore) {
            highscore = player.highScore;
        }
    }
    return highscore;
}

/**
 *  This method updates the current players array from nsuserdefaults.
 */
+ (void) grabPlayersArray {
    NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
    NSData *arrayData = [currentDefaults objectForKey:@"players"];
    if (arrayData != nil) { // We have data!
        NSArray *oldSavedArray = [NSKeyedUnarchiver unarchiveObjectWithData: arrayData];
        if (oldSavedArray != nil) {
            players = [[NSMutableArray alloc] initWithArray:oldSavedArray];
        } else {
            players = [[NSMutableArray alloc] init];
        }
    }
}


@end

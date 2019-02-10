//
//  Player.m
//  BubblePop
//
//  Created by Alessandro Alberga on 16/4/17.
//  Copyright © 2017 ___Alberga Apps___. All rights reserved.
//

#import "Player.h"
#import "ScoreBoard.h"

@implementation Player

@synthesize name;
@synthesize highScore;

-(id)initWithName:(NSString *)newName : (int)newHighScore {
    self = [super init];
    if (self) {
        self.name = newName;
        self.highScore = newHighScore;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        name = [aDecoder decodeObjectForKey:@"name"];
        highScore = (int)[aDecoder decodeIntegerForKey: @"highscore"];
    }
    return self;
}
                       
- (void)encodeWithCoder:(NSCoder *)aCoder {
   [aCoder encodeObject : name forKey: @"name"];
   [aCoder encodeInteger: highScore forKey: @"highscore"];
}

/**
 *  This method updates the highscore of the character.
 */
- (void) updateCharacter : (int) score {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (score > self.highScore) { self.highScore = score; }
    [self replaceInPlayersArray: self];
    [defaults setObject:[NSKeyedArchiver archivedDataWithRootObject: self] forKey: name];
    [defaults setObject:[NSKeyedArchiver archivedDataWithRootObject: self] forKey:@"currentPlayer"];
}

/**
 *  This method inserts player into player array.
 */
- (void)replaceInPlayersArray : (Player *) newEntry {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *arrayData = [defaults objectForKey:@"players"];
    NSMutableArray<Player *> *players = [NSKeyedUnarchiver unarchiveObjectWithData: arrayData];
    
    for (int i = 0; i< players.count ; i++) {
        if ([newEntry.name isEqualToString: [players objectAtIndex: i].name]) {
            [players replaceObjectAtIndex:  i withObject: newEntry];    //re-inserts the players new data into array.
        }
    }
    
    [defaults setObject:[NSKeyedArchiver archivedDataWithRootObject: players] forKey: @"players"];
}

@end

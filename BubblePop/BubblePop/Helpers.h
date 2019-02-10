//
//  Helpers.h
//  BubblePop
//
//  Created by Alessandro Alberga on 15/4/17.
//  Copyright © 2017 ___Alberga Apps___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "Bubble.h"

@interface Helpers : NSObject

+ (SKLabelNode *) configureLabelNode: (SKLabelNode *)labelNode :(int) fontSize :(CGPoint) labelPos : (NSString *) text;
+ (SKSpriteNode *) configureButtonNode: (SKSpriteNode *)buttonNode :(CGPoint) buttonPos : (CGSize) size : (NSString *) name;
+ (void) fadeAnimation: (SKLabelNode *) label;
+ (void) animateUpAndDown: (SKLabelNode *) label;
+ (void) scaleButton: (SKNode *) node : (Boolean) down;
+ (void) setNumberDefault: (NSString *) key : (NSNumber *) value;
+ (CGPoint)randomCGPoint: (CGSize)screenSize;
+ (SKAction *) changeLabel: (int) val : (SKLabelNode *) labelnode;
+ (void) animateComboSequence: (SKLabelNode *) label;
+ (void) spinNode : (SKNode *) node;
+ (SKSpriteNode *) configureSpriteNode: (SKSpriteNode *) node : (CGPoint) point;

@end

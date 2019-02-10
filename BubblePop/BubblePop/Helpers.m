//
//  Helpers.m
//  BubblePop
//
//  Created by Alessandro Alberga on 15/4/17.
//  Copyright © 2017 ___Alberga Apps___. All rights reserved.
//

#import "Helpers.h"

@implementation Helpers

/**
 *  This method configures a label node with params.
 */
+ (SKLabelNode *) configureLabelNode: (SKLabelNode *)labelNode :(int) fontSize :(CGPoint) labelPos : (NSString *) text {
    SKLabelNode *thisLabel = labelNode;
    thisLabel.fontName = @"Silkscreen";
    thisLabel.fontSize = fontSize;
    thisLabel.position = labelPos;
    [thisLabel setText: text];
    return thisLabel;
}

/**
 *  This method configures a button node with params.
 */
+ (SKSpriteNode *) configureButtonNode: (SKSpriteNode *)buttonNode :(CGPoint) buttonPos : (CGSize) size : (NSString *) name {
    SKSpriteNode *button = buttonNode;
    button.position = buttonPos;
    button.size = size;
    button.name = name;
    return button;
}

/**
 *  This method configures a sprite node with params.
 */
+ (SKSpriteNode *) configureSpriteNode: (SKSpriteNode *) node : (CGPoint) point {
    SKSpriteNode *thisNode = node;
    thisNode.position = point;
    thisNode.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize: node.frame.size];
    thisNode.physicsBody.dynamic = NO;
    thisNode.physicsBody.affectedByGravity = NO;
    return thisNode;
}

/**
 *  This method is takes in a label as a parameter and animates it accordingly.
 */
+ (void) animateComboSequence: (SKLabelNode *) label {
    SKAction *fadeIn = [SKAction fadeAlphaTo: 1.0 duration: 0.05];
    SKAction *wait = [SKAction waitForDuration: 0.5];
    SKAction *fadeOut = [SKAction fadeAlphaTo: 0.0 duration: 0.8];
    SKAction *sequence = [SKAction sequence: @[fadeIn, wait, fadeOut]];
    [label runAction: sequence];
}

/**
 *  This method runs repeated fade animation on a label.
 */
+ (void) fadeAnimation: (SKLabelNode *) label {
    SKAction *fadeOut = [SKAction fadeAlphaTo: 1 duration: 0.8];
    SKAction *fadeIn = [SKAction fadeAlphaTo: 0 duration: 0.8];
    SKAction *fadeSequence = [SKAction sequence: @[fadeIn, fadeOut]];
    [label runAction: [SKAction repeatActionForever: fadeSequence]];
}

+ (void) animateUpAndDown: (SKLabelNode *) label {
    SKAction *moveUp = [SKAction moveToY: (label.position.y + label.frame.size.height / 4) duration: 0.5];
    SKAction *moveDown = [SKAction moveToY: (label.position.y - label.frame.size.height / 2) duration: 1.0];
    SKAction *sequence = [SKAction sequence: @[moveUp, moveDown, moveUp]];
    [label runAction: [SKAction repeatActionForever: sequence]];
}

/**
 *  This method returns a SKAction sequence to change a label.
 */
+(SKAction *) changeLabel: (int) val : (SKLabelNode *) labelnode  {
    SKAction *setLabel = [SKAction runBlock:^(void) { NSString *currentCount = [NSString stringWithFormat: @"%d", val];
        labelnode.text = currentCount;
    }];
    SKAction *fadeOut = [SKAction fadeAlphaTo: 0.0 duration: 0.15];
    SKAction *fadeIn = [SKAction fadeAlphaTo: 1.0 duration: 0.15];
    SKAction *sequence = [SKAction sequence: @[fadeOut, setLabel, fadeIn]];
    return sequence;
}

/**
 *  Scales a node down or up depending on the down value.
 */
+ (void) scaleButton: (SKNode *) node : (Boolean) down {
    if (down) {
        node.yScale = 0.9;
        node.xScale = 0.9;
    } else {
        node.yScale = 1;
        node.xScale = 1;
    }
}

/**
 *  Sets a number default in nsuserdefaults.
 */
+ (void)setNumberDefault: (NSString *) key : (NSNumber *) value {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue: value forKey: key];
    [defaults synchronize];
}

/**
 *  return a random cgpoint within the screen bounds.
 */
+ (CGPoint)randomCGPoint: (CGSize)screenSize {
    CGFloat randx = (CGFloat)arc4random_uniform(screenSize.width / 2) - (screenSize.width / 4);
    CGFloat randy =  (CGFloat)arc4random_uniform(screenSize.height / 2) - (screenSize.height / 4); 
    return CGPointMake(randx,randy);
}

/**
 *  This method spins the sknode parameter sent in.
 */
+ (void) spinNode : (SKNode *) node {
    SKAction *spin = [SKAction repeatActionForever:[SKAction rotateByAngle: -6.28319 duration: 3.0]]; // 6.28319 = 360 degrees.
    [node runAction: spin];
}

@end

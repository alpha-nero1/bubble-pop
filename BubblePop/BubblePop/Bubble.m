//
//  Bubble.m
//  BubblePop
//
//  Created by Alessandro Alberga on 16/4/17.
//  Copyright © 2017 ___Alberga Apps___. All rights reserved.
//

#import "Bubble.h"

@implementation Bubble

@synthesize scoreMultiplier;
@synthesize width;
@synthesize height;

-(id)initWithName:(CGFloat)swidth :(CGFloat)sheight {
    self = [super init];
    if (self) {
        self.width = swidth;
        self.height = sheight;
        CGRect bubbleSize = CGRectMake(0, 0, (width / 6.5), (width / 6.5));
        self.path = [Bubble circleInRect: bubbleSize];
        self.fillColor = [self handleRandomColor];
        self.lineWidth = 0;
        self.position = [Helpers randomCGPoint: CGSizeMake(width, height)];
        self.name = @"bubble";
        self.zPosition = -10;
        self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius: (width / 10)];
        self.physicsBody.dynamic = YES;
        self.physicsBody.affectedByGravity = NO;
    }
    return self;
}

/**
 *  This method returns a random colour and sets a multiplier
 *  according to probability.
 */
-(UIColor *) handleRandomColor {
    int randNum = arc4random_uniform(20);
    UIColor *randColour;
    if (randNum <= 1) {
        randColour = [UIColor blackColor];
        self.scoreMultiplier = 10;
    } else if (randNum < 3) {
        randColour = [UIColor blueColor];
        self.scoreMultiplier = 8;
    } else if (randNum < 6) {
        randColour = [UIColor greenColor];
        self.scoreMultiplier = 5;
    } else if (randNum < 12) {
        randColour = [UIColor magentaColor];
        self.scoreMultiplier = 2;
    } else if (randNum < 20) {
        randColour = [UIColor redColor];
        self.scoreMultiplier = 1;
    }
    return randColour;
}

/**
 *  This function returns the path for a circle.
 */
+ (CGPathRef) circleInRect:(CGRect)rect {
    CGRect adjustedRect = CGRectMake(rect.origin.x-rect.size.width/2, rect.origin.y-rect.size.height/2, rect.size.width, rect.size.height);
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithOvalInRect:adjustedRect];
    return bezierPath.CGPath;
}

/**
 *  This method animates the bubble off screen.
 */
+ (void) animateToPos : (CGPoint) point : (Bubble *) bubble {
    SKAction *move = [SKAction moveTo: point duration: 0.2];
    SKAction *kill = [SKAction runBlock:^(void) {
        [bubble removeFromParent];
    }];
    SKAction *moveSeq = [SKAction sequence: @[move,kill]];
    [bubble runAction: moveSeq];
}

@end

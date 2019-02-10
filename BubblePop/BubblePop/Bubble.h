//
//  Bubble.h
//  BubblePop
//
//  Created by Alessandro Alberga on 16/4/17.
//  Copyright © 2017 ___Alberga Apps___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "Helpers.h"

@interface Bubble : SKShapeNode

@property (nonatomic) double scoreMultiplier;

-(id)initWithName:(CGFloat)swidth :(CGFloat)sheight;
+ (CGPathRef) circleInRect:(CGRect)rect;
+ (void) animateToPos : (CGPoint) point : (Bubble *) bubble;

@property CGFloat width;
@property CGFloat height;

@end

//
//  BackgroundWithRects.m
//  Battle Solitare
//
//  Created by Kevin Yue on 5/9/14.
//  Copyright 2014 Kevin Yue. All rights reserved.
//

#import "BackgroundWithRects.h"
#import "ImprovedSprite.h"
#import "Grid.h"

const int rectMargin = 20;

@implementation BackgroundWithRects

-(id)init{
    self = [super init];
    [self addPlayerRects];
    return self;
}


-(void)addPlayerRects{
    CGFloat x = [[Grid getInstance] width];
    CGFloat y = [[Grid getInstance] verticalMargin];
    ImprovedSprite * top = [[ImprovedSprite alloc] initWithFile:@"black felt.png"];
    ImprovedSprite * bot = [[ImprovedSprite alloc] initWithFile:@"white felt.png"];
    
    [bot scaleToX:x - rectMargin Y:y - [[Grid getInstance] sqHeight]/2 - rectMargin];
    [top scaleToX:x - rectMargin Y:y - [[Grid getInstance] sqHeight]/2 - rectMargin];
    
    bot.position = ccp(bot.boundingBox.size.width/2 + rectMargin/2, bot.boundingBox.size.height/2 + rectMargin/2);
    top.position = ccp(top.boundingBox.size.width/2 + rectMargin/2, [[Grid getInstance] height] - top.boundingBox.size.height/2 - rectMargin/2);
    
    [self addChild:top];
    [self addChild:bot];
    
}
@end

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

ImprovedSprite * topRect;
ImprovedSprite * botRect;

-(id)init{
    self = [super init];
    [self addPlayerRects];
    return self;
}


-(void)addPlayerRects{
    CGFloat x = [[Grid getInstance] width];
    CGFloat y = [[Grid getInstance] verticalMargin];
    topRect = [[ImprovedSprite alloc] initWithFile:@"black felt.png"];
    botRect = [[ImprovedSprite alloc] initWithFile:@"white felt.png"];
    
    [botRect scaleToX:x - rectMargin Y:y - [[Grid getInstance] sqHeight]/2 - rectMargin];
    [topRect scaleToX:x - rectMargin Y:y - [[Grid getInstance] sqHeight]/2 - rectMargin];
    
    botRect.position = ccp(botRect.boundingBox.size.width/2 + rectMargin/2, botRect.boundingBox.size.height/2 + rectMargin/2);
    topRect.position = ccp(topRect.boundingBox.size.width/2 + rectMargin/2, [[Grid getInstance] height] - topRect.boundingBox.size.height/2 - rectMargin/2);
    
    [self addChild:topRect];
    [self addChild:botRect];
    
}

-(ImprovedSprite*)topRect{
    return topRect;
}

-(ImprovedSprite*)botRect{
    return botRect;
}
@end

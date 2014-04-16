//
//  BackgroundLayer.m
//  Battle Solitare
//
//  Created by Kevin Yue on 4/9/14.
//  Copyright 2014 Kevin Yue. All rights reserved.
//

#import "BackgroundLayer.h"
#import "ImprovedChild.h"
#import "ImprovedSprite.h"
#import "Grid.h"

const NSString * file = @"green felt.png";

@implementation BackgroundLayer

-(id)init{
    self = [super init];
    
    [self addBackground];
    
    return self;
}

-(void)addBackground{
    ImprovedSprite * background = [[ImprovedSprite alloc] initWithFile:file];
    [background scaleToX:[[Grid getInstance] width] Y:[[Grid getInstance] height]];
    background.position = ccp([[Grid getInstance] width]/2, [[Grid getInstance] height]/2);
    [self addChild:background];
}

@end

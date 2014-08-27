//
//  TutorialLayer.m
//  Battle Solitare
//
//  Created by Kevin Yue on 8/27/14.
//  Copyright 2014 Kevin Yue. All rights reserved.
//

#import "TutorialLayer.h"
#import "BackgroundLayer.h"
#import "BackgroundWithRects.h"
#import "Grid.h"
#import "MenuScene.h"

const int numPages = 3;
int currentPage;

BackgroundLayer * cardLayer;
BackgroundWithRects * gameLayer;
BackgroundWithRects * scoreLayer;

@implementation TutorialLayer

-(id)init{
    self = [super init];
    
    [self setupLayers];
    currentPage = 1;
    
    return self;
}

-(void)setupLayers{
    cardLayer = [[BackgroundLayer alloc] init];
    gameLayer = [[BackgroundWithRects alloc] init];
    scoreLayer = [[BackgroundWithRects alloc] init];
    
    [self addChild:cardLayer];
    [self addChild:gameLayer];
    [self addChild:scoreLayer];
    
    cardLayer.position = ccp(0,0);
    gameLayer.position = ccp([[Grid getInstance] width],0);
    scoreLayer.position = ccp([[Grid getInstance] width]*2,0);
}

-(void)shiftLayerRight{
    currentPage -= 1;
    [super shiftLayerRight];
    [self checkBackToMenu];
}

-(void)shiftLayerLeft{
    currentPage += 1;
    [super shiftLayerLeft];
    [self checkBackToMenu];
}

-(void)checkBackToMenu{
    if(currentPage <=0 || currentPage > numPages) {
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[MenuScene scene]]];
    }
}

@end

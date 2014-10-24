//
//  TutorialLayer.m
//  Battle Solitare
//
//  Created by Kevin Yue on 8/27/14.
//  Copyright 2014 Kevin Yue. All rights reserved.
//

#import "TutorialLayer.h"
#import "GameTutorialLayer.h"
#import "ScoringTutorialLayer.h"
#import "CardTutorialLayer.h"
#import "FontsAndSpacings.h"
#import "ImprovedSprite.h"
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
    [self addMenuControlButtons];
    currentPage = 1;
    
    return self;
}

-(void)setupLayers{
    cardLayer = [[CardTutorialLayer alloc] init];
    gameLayer = [[GameTutorialLayer alloc] init];
    scoreLayer = [[ScoringTutorialLayer alloc] init];
    
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

-(void)addMenuControlButtons{
    CGFloat buttonSize = [[FontsAndSpacings getInstance] border];
    
    for(int i=0; i<numPages; i++){
        ImprovedSprite * leftSprite = [[ImprovedSprite alloc] initWithFile:@"next icon.png"];
        ImprovedSprite * rightSprite = [[ImprovedSprite alloc] initWithFile:@"next icon.png"];
        
        if(i==0){leftSprite = [[ImprovedSprite alloc] initWithFile:@"back icon.png"];}
        if(i== numPages-1){rightSprite = [[ImprovedSprite alloc] initWithFile:@"back icon.png"];}
        
        [leftSprite changeOpacity:150];
        [rightSprite changeOpacity:150];
        
        
        [leftSprite scaleToX:buttonSize Y:buttonSize];
        [rightSprite scaleToX:buttonSize Y:buttonSize];
        
        leftSprite.position = ccp([[Grid getInstance] width] * i + buttonSize/2,
                                   [[Grid getInstance] height]/2);
        rightSprite.position = ccp([[Grid getInstance] width] * (i+1) - buttonSize/2,
                                   [[Grid getInstance] height]/2);
        
        leftSprite.rotation = 180;
        
        [self addChild:leftSprite];
        [self addChild:rightSprite];
    }
}



@end

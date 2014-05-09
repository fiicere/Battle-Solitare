//
//  ScoreLayer.m
//  Battle Solitare
//
//  Created by Kevin Yue on 5/7/14.
//  Copyright 2014 Kevin Yue. All rights reserved.
//

#import "ScoreLayer.h"
#import "TileManager.h"
#import "Tile.h"
#import "MenuScene.h"
#import "Drawer.h"
#import "Score.h"
#import "Grid.h"

@implementation ScoreLayer

NSMutableArray * dropList;

const float shrinkTime = 1;

float xShrinkRate;
float yShrinkRate;

-(id) init{
    self = [super init];
    
    [self addAllCards];
    
//    [self addChild:[[Drawer alloc]initWithPath:[[Score getInstance] blackPath] andColorIsBlack:true] z:10];
//    [self addChild:[[Drawer alloc]initWithPath:[[Score getInstance] whitePath] andColorIsBlack:false] z:10];
    
    xShrinkRate = [[Grid getInstance] sqWidth] / shrinkTime;
    yShrinkRate = [[Grid getInstance] sqHeight] / shrinkTime;
    
    [self schedule:@selector(dropCard:) interval:0.1];
    [self schedule:@selector(shrink:)];
    
    return self;
}

-(void) addAllCards{
    for (Tile * t in [[TileManager getInstance] getPlacedTiles]){
        [self addChild:t];
    }
}

-(void) dropCard:(ccTime)dt{
    for(Tile* t in [[TileManager getInstance] getPlacedTiles]){
        if([[[Score getInstance] whitePath] containsObject:t]){
            continue;
        }
        else if([[[Score getInstance] blackPath] containsObject:t]){
            continue;
        }
        else if(![dropList containsObject:t]){
            continue;
        }
        else{
            [dropList addObject:t];
            break;
        }
        [self unschedule:@selector(dropCard:)];
    }
}

-(void)shrink:(ccTime)dt{
    for (Tile*t in dropList){
        float height = t.boundingBox.size.height;
        float width = t.boundingBox.size.width;
        if(height <=0.1 && width <=0.1){
            continue;
        }
        else{
            [t scaleToX:width/2 Y:height/2];
        }
    }
    
}


/////////////////////////INIT METHODS//////////////////////////
-(void)onEnter{
    [[CCTouchDispatcher sharedDispatcher] addStandardDelegate:self priority:0];
    [super onEnter];
}
-(void)onExit{
    [[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
    [super onExit];
}


/////////////////////////TOUCH EVENTS//////////////////////////

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [[CCDirector sharedDirector] replaceScene:[MenuScene scene]];}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
}

-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
}

@end

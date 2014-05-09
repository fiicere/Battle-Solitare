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
#import "ImprovedChild.h"
#import "Drawer.h"
#import "Score.h"
#import "Grid.h"

@implementation ScoreLayer

NSMutableArray * dropList;
NSMutableArray * notDropList;

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
    
    dropList = [NSMutableArray new];
    notDropList = [NSMutableArray new];
    
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
        if([notDropList containsObject:t]){
            continue;
        }
        else if([dropList containsObject:t]){
            continue;
        }
        else if([[[Score getInstance] whitePath] containsObject:t]){
            [notDropList addObject:t];
            return;
        }
        else if([[[Score getInstance] blackPath] containsObject:t]){
            [notDropList addObject:t];
            return;
        }
        else{
            [dropList addObject:t];
            return;
        }
    }
    [self unschedule:@selector(dropCard:)];

}

-(void)shrink:(ccTime)dt{
    for (Tile*t in dropList){
        if(t.scaleX <=0.000001 && t.scaleY <=0.000001){
            continue;
        }
        else{
            t.scaleX = t.scaleX / (1+dt);
            t.scaleY = t.scaleY / (1+dt);
        }
    }
    for (Tile*t in notDropList){
        for(ImprovedChild * child in t.children){
            child.scaleX = child.scaleX/(1+dt*2);
            child.scaleY = child.scaleY/(1+dt*2);
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

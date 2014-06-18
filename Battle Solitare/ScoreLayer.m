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
    [self addScore];
    
    xShrinkRate = [[Grid getInstance] sqWidth] / shrinkTime;
    yShrinkRate = [[Grid getInstance] sqHeight] / shrinkTime;
    
    dropList = [NSMutableArray new];
    notDropList = [NSMutableArray new];
    
    [self schedule:@selector(dropCard:) interval:0.075];
    [self schedule:@selector(shrinkCards:)];
    
    Drawer * whitePath = [[Drawer alloc] initWithPath:[[Score getInstance] whitePath] andColorIsBlack:false];
    [self addChild:whitePath];
    
    Drawer * blackPath = [[Drawer alloc] initWithPath:[[Score getInstance] blackPath] andColorIsBlack:true];
    [self addChild:blackPath];
    return self;
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
    [self schedule:@selector(shrinkSuitsAndNums:)];
    [self fireworks];
}

-(void)shrinkCards:(ccTime)dt{
    for (Tile*t in dropList){
        if(t.scaleX <=0.000001 && t.scaleY <=0.000001){
            continue;
        }
        else{
            t.scaleX = t.scaleX / (1+dt*2);
            t.scaleY = t.scaleY / (1+dt*2);
        }
    }
}

-(void)shrinkSuitsAndNums:(ccTime)dt{
    for (Tile*t in notDropList){
        for(ImprovedChild * child in t.children){
            child.scaleX = child.scaleX/(1+dt*2);
            child.scaleY = child.scaleY/(1+dt*2);
        }
    }
}

-(void)fadeOutPathCards:(ccTime)dt{
    for (Tile*t in notDropList){
        t.opacity = t.opacity / (1+dt);
        for(ImprovedChild * child in t.children){
            child.opacity = child.opacity/(1+dt*2);
        }
    }
}

-(void) fireworks{
    //TODO
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


-(void) addAllCards{
    for (Tile * t in [[TileManager getInstance] getPlacedTiles]){
        t.opacity = 150;
        [self addChild:t];
    }
}

-(void) addScore{
    NSString * blackScoreText = [NSString stringWithFormat:@"Score = %u", [[Score getInstance] blackScore]];
    NSString * whiteScoreText = [NSString stringWithFormat:@"Score = %u", [[Score getInstance] whiteScore]];
    
    CCLabelTTF * botScoreLabel = [CCLabelTTF labelWithString:whiteScoreText fontName:@"TrajanPro-Regular" fontSize:18];
    CCLabelTTF * topScoreLabel = [CCLabelTTF labelWithString:blackScoreText fontName:@"TrajanPro-Regular" fontSize:18];
    
    topScoreLabel.rotation = 180;
    
    topScoreLabel.color = ccWHITE;
    botScoreLabel.color = ccBLACK;
    
    botScoreLabel.position = ccp([[Grid getInstance] width]/2, [[Grid getInstance] botCardLoc].y);
    topScoreLabel.position = ccp([[Grid getInstance] width]/2, [[Grid getInstance] topCardLoc].y);
    
    [self addChild:topScoreLabel];
    [self addChild:botScoreLabel];
}

/////////////////////////TOUCH EVENTS//////////////////////////

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self removeAllChildren];
    [[CCDirector sharedDirector] replaceScene:[MenuScene scene]];}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
}

-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
}

@end

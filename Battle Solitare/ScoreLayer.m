//
//  ScoreLayer.m
//  Battle Solitare
//
//  Created by Kevin Yue on 5/7/14.
//  Copyright 2014 Kevin Yue. All rights reserved.
//

#import "ScoreLayer.h"
#import "TileManager.h"
#import "BackgroundLayer.h"
#import "Tile.h"
#import "MenuScene.h"
#import "Score.h"
#import "Grid.h"

int blackScore;
int whiteScore;

int currentWhiteInd;
int currentBlackInd;

CGPoint lastPoint;

// In pixels/second
const float speed = 1000;

@implementation ScoreLayer

-(id) init{
    self = [super init];
    
    [self addAllCards];
    blackScore = 0;
    whiteScore = 0;
    
    currentWhiteInd = 0;
    currentBlackInd = 0;
    
    lastPoint = [[[[Score getInstance] blackPath] objectAtIndex:0] position];
    
    [self schedule:@selector(pathing:)];
    
    return self;
}

-(void) addAllCards{
    for (Tile * t in [[TileManager getInstance] getPlacedTiles]){
        [self addChild:t];
    }

}

-(void)pathing:(ccTime)dt{
    // If drawing the black path
    if(currentBlackInd < [[Score getInstance] blackScore]){
        
    }
    // If drawing the white path
    else if(currentWhiteInd < [[Score getInstance] whiteScore]){
        
    }
    // Else if both paths finished
    else{
        
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

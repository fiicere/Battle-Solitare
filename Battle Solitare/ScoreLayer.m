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
#import "Score.h"

const int scoreOffset = 50;
const int rectMargin = 20;

@implementation ScoreLayer

-(id) init{
    self = [super init];
    
    [self addAllCards];
//    [self addPlayerRects];
    
    [self schedule:@selector(drawPath:) interval:0.1];
    
    return self;
}

-(void) addAllCards{
    for (Tile * t in [[TileManager getInstance] getPlacedTiles]){
        [self addChild:t];
    }

}


/////////////////////////PATH DRAWING//////////////////////////
-(void) drawPath:(ccTime)dt{
    
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

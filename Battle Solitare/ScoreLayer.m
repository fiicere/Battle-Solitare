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
#import "Draw.h"


@implementation ScoreLayer

-(id) init{
    self = [super init];
    
    [self addAllCards];
    
    [self addChild:[[Draw alloc]init] z:10];
    
    return self;
}

-(void) addAllCards{
    for (Tile * t in [[TileManager getInstance] getPlacedTiles]){
        [self addChild:t];
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

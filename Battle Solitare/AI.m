//
//  AI.m
//  Battle Solitare
//
//  Created by Kevin Yue on 8/6/14.
//  Copyright (c) 2014 Kevin Yue. All rights reserved.
//

#import "AI.h"
#import "TileManager.h"
#import "Grid.h"
#import "Tile.h"

const float moveRate = 1;
const float moveDuration = 0.3;
Tile * currentTile;
SqID* bestSquare;
float bestSquareValue;

@implementation AI

-(id)init{
    self = [super init];
    [self schedule:@selector(chooseMove:) interval:moveRate];
    currentTile = [[TileManager getInstance] topCard];
    return self;
}


-(void)chooseMove:(ccTime) dt{
    [self resetHeuristic];
    
    if([currentTile.backgroundColor  isEqual: @"b"]) {[self scoreMyTile];}
    if([currentTile.backgroundColor  isEqual: @"w"]) {[self scoreOpponentTile];}
    else {[self scoreWildCard];}

}

-(void)resetHeuristic{
    bestSquare = nil;
    bestSquareValue = 0;
    [[TileManager getInstance] resetAllSqIDValues];
}

-(void)scoreMyTile{
    for(Tile* t in [[TileManager getInstance] getPlacedTiles]){
        if([currentTile matches:t]){
            [self incrementAdjacentSquares:t];
        }
    }
}

-(void)scoreOpponentTile{
    
}

-(void)scoreWildCard{
    
}

-(void)decrementAdjacentSquares:(Tile*) t{
    [self addValue:-t.scoreHeuristic unlessSqOccupied:[[Grid getInstance] up:t.sqID]];
    [self addValue:-t.scoreHeuristic unlessSqOccupied:[[Grid getInstance] down:t.sqID]];
    [self addValue:-t.scoreHeuristic unlessSqOccupied:[[Grid getInstance] left:t.sqID]];
    [self addValue:-t.scoreHeuristic unlessSqOccupied:[[Grid getInstance] right:t.sqID]];
    
}

-(void)incrementAdjacentSquares:(Tile*) t{
    [self addValue:t.scoreHeuristic unlessSqOccupied:[[Grid getInstance] up:t.sqID]];
    [self addValue:t.scoreHeuristic unlessSqOccupied:[[Grid getInstance] down:t.sqID]];
    [self addValue:t.scoreHeuristic unlessSqOccupied:[[Grid getInstance] left:t.sqID]];
    [self addValue:t.scoreHeuristic unlessSqOccupied:[[Grid getInstance] right:t.sqID]];
    
}

-(void)addValue:(float)val unlessSqOccupied:(SqID*)sqID{
    if(!sqID.occupied) {sqID.squareHeuristic += val;}
}

-(SqID*)findHighestScoringSquare{
    for(SqID*sqid in [[TileManager getInstance] getAllSqIDs]){
        if (sqid.squareHeuristic > bestSquareValue){
            bestSquare = sqid;
            bestSquareValue = sqid.squareHeuristic;
        }
    }
    return bestSquare;
}
@end

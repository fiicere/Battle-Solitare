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

const float moveRate = 2;
const float moveDuration = 0.3;
Tile * currentTile;
SqID* bestSquare;
float bestSquareValue;

@implementation AI

-(id)init{
    self = [super init];
    [self schedule:@selector(chooseMove:) interval:moveRate];
    return self;
}


-(void)chooseMove:(ccTime) dt{
    if([TileManager getInstance].getPlacedTiles.count >= 49){
        [self unschedule:@selector(chooseMove:)];
        return;}
//    NSLog(@"Card Count = %u", [TileManager getInstance].getPlacedTiles.count);
    
    [self resetHeuristic];
    if([currentTile.backgroundColor isEqual:@"b"]) {[self scoreMyTile];}
    else if([currentTile.backgroundColor isEqual:@"w"]) {[self scoreOpponentTile];}
    else {[self scoreWildCard];}
    
    [[TileManager getInstance] moveTile:currentTile toLoc:[[Grid getInstance] getCenter:bestSquare]];

}

-(void)resetHeuristic{
    bestSquare = nil;
    bestSquareValue = FLT_MIN;
    [[TileManager getInstance] resetAllSqIDValues];
    currentTile = [[TileManager getInstance] topCard];
}

-(void)scoreMyTile{
    for(Tile* t in [[TileManager getInstance] getPlacedTiles]){
        if([currentTile matches:t]){[self incrementAdjacentSquares:t];}
    }
    [self findHighestScoringSquare];
}

-(void)scoreOpponentTile{
    for(Tile* t in [[TileManager getInstance] getPlacedTiles]){
        if([currentTile matches:t]) {[self decrementAdjacentSquares:t];}
    }
    [self findHighestScoringSquare];
}

-(void)scoreWildCard{
    for(Tile* t in [[TileManager getInstance] getPlacedTiles]){
        if([t.backgroundColor isEqualToString:@"b"]) {[self incrementAdjacentSquares:t];}
        if([t.backgroundColor isEqualToString:@"w"]) {[self decrementAdjacentSquares:t];}
        if([t.backgroundColor isEqualToString:@"wild"]) {[self validateAdjacentSquares:t];}

    }
    [self findHighestScoringSquare];
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

-(void)validateAdjacentSquares:(Tile*) t{
    [self addValue:0 unlessSqOccupied:[[Grid getInstance] up:t.sqID]];
    [self addValue:0 unlessSqOccupied:[[Grid getInstance] down:t.sqID]];
    [self addValue:0 unlessSqOccupied:[[Grid getInstance] left:t.sqID]];
    [self addValue:0 unlessSqOccupied:[[Grid getInstance] right:t.sqID]];
    
}

-(void)addValue:(float)val unlessSqOccupied:(SqID*)sqID{
    if(!sqID.occupied) {
        if(sqID.squareHeuristic == -FLT_MAX) {sqID.squareHeuristic = 0;}
        sqID.squareHeuristic += val;
    }
}

-(void)findHighestScoringSquare{
    bestSquareValue = -FLT_MAX;
    for(SqID*sqid in [[TileManager getInstance] getAllSqIDs]){
        if (sqid.squareHeuristic > bestSquareValue){
            bestSquare = sqid;
            bestSquareValue = sqid.squareHeuristic;
        }
    }
}

-(void)findLowestScoringSquare{
    bestSquareValue = FLT_MAX;
    for(SqID*sqid in [[TileManager getInstance] getAllSqIDs]){
        if (sqid.squareHeuristic < bestSquareValue){
            bestSquare = sqid;
            bestSquareValue = sqid.squareHeuristic;
        }
    }
}
@end

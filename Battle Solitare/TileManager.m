//
//  TileManager.m
//  Battle Solitare
//
//  Created by Kevin Yue on 12/30/13.
//  Copyright (c) 2013 Kevin Yue. All rights reserved.
//

#import "TileManager.h"
#import "Tile.h"
#import "cocos2d.h"
#import "Grid.h"
#import "Deck.h"
#import "Score.h"

TileManager* instance;
NSMutableArray* placedTiles;

@implementation TileManager

+(TileManager *)getInstance{
    if(instance == nil){
        instance = [[self alloc] init];
    }
    return instance;
}

-(id)init{
    if(self = [super init]){
        
    }
    [self newGame];
    return self;
}

-(void) newGame{
    [[Deck getInstance] resetDeck];
    [[Score getInstance] reset];
    [[Grid getInstance] resetSquares];
    [self replaceTiles];
}

-(void)replaceTiles{
    for(Tile * t in placedTiles){
        [t release];
    }
    [_topCard release];
    [_botCard release];
    _topCard = nil;
    _botCard = nil;
    placedTiles = [[NSMutableArray alloc] init];

    [self newCenterTile];
    [self newBotTile];
    [self newTopTile];
    }

-(Tile *)newTopTile{
    if(_topCard != nil){
        [self placeTile:_topCard];
    }
    
    Tile * t = [self getNewValidCard];
    
    t.position = [[Grid getInstance] topCardLoc];
    _topCard = t;

    return t;
}

-(Tile *)newBotTile{
    if(_botCard != nil){
        [self placeTile:_botCard];
    }
    
    Tile * t = [self getNewValidCard];
    
    t.position = [[Grid getInstance] botCardLoc];
    _botCard = t;
    return t;
}

-(Tile *)newCenterTile{
    Tile * t = [[Tile alloc] initWildCard];
    t.position = ccp(([Grid getInstance].width / 2), [Grid getInstance].height/2);
    t.sqID = [[Grid getInstance] getSquareID:t.position];
    t.sqID.occupied = true;
    [placedTiles addObject:t];
    
    return t;
}

-(NSMutableArray*) getPlacedTiles{
    return placedTiles.copy;
}

-(void)placeTile:(Tile*)t{
    if([placedTiles containsObject:t]) {NSLog(@"ERROR: attempting to place %@%u%@ twice", t.backgroundColor, t.value, t.suit);}
    [placedTiles addObject:t];
    [[Score getInstance] floodUpdateForPlayedTile:t];
}

-(Tile*)getNewValidCard{
    Tile * t = [[Deck getInstance] getNextCard];
    
    if (![self canPlaceTile:t]){
        [self returnTileToDeck:t];
        return [self getNewValidCard];
    }
    
    return t;
}

// Tries to move a tile to a location, returns false if invalid move
-(BOOL)moveTile:(Tile *)t toLoc:(CGPoint)loc{

    //If valid location
    if([self isValidMoveTile: t ToLoc:loc]){
        
        // Move the tile
        t.position = [[Grid getInstance] getNearestCenter:loc];
        t.sqID = [[Grid getInstance] getSquareID:t.position];
        t.sqID.occupied = true;
        
        // Replace the tile
        if(t == _topCard){
            [self newTopTile];
        }
        else if(t == _botCard){
            [self newBotTile];
        }
        else{
            NSLog(@"ERROR: Card played that was neither top nor bot");
        }
        
        return true;
    }
    return false;
}

// Checks move validity
-(BOOL) isValidMoveTile:(Tile *) t ToLoc:(CGPoint)loc{
    
    if([[Grid getInstance] getSquareID:loc].occupied){return false;}
    
    if(! [self hasMatchingTile:t AtLoc:loc]){return false;}
    
    return true;
}

// Returns the tile at a sqID, or nil if there is none
// CAN RETURN NULL!!!!
-(Tile *) tileOnSquare:(SqID*) sqID{
    for(Tile * t in placedTiles){
        if([[Grid getInstance] thisID:sqID equalsThisID:t.sqID]){
            return t;
        }
    }
    return nil;
}

//Note: Only works if given a grid location
-(BOOL) hasMatchingTile:(Tile *)t AtLoc:(CGPoint)location{
    SqID * sqID = [[Grid getInstance] getSquareID:location];
    
    Tile * adj = [self getRight:sqID];
    if(adj != nil){
        if([t matches:adj]){
            return true;
        }
    }
    
    adj = [self getLeft:sqID];
    if(adj != nil){
        if([t matches:adj]){
            return true;
        }
    }
    
    adj = [self getAbove:sqID];
    if(adj != nil){
        if([t matches:adj]){
            return true;
        }
    }
    
    adj = [self getBelow:sqID];
    if(adj != nil){
        if([t matches:adj]){
            return true;
        }
    }

    return false;
}

-(Tile*) getRight:(SqID*)loc{
    return [self tileOnSquare:[[Grid getInstance] right:loc]];
    
}
-(Tile*) getLeft:(SqID*)loc{
    return [self tileOnSquare:[[Grid getInstance] left:loc]];
}
-(Tile*) getAbove:(SqID*)loc{
    return [self tileOnSquare:[[Grid getInstance] up:loc]];

}
-(Tile*) getBelow:(SqID*)loc{
    return [self tileOnSquare:[[Grid getInstance] down:loc]];
}

-(NSArray*)getAdjTiles:(Tile*)t{
    NSMutableArray * adjTiles = [NSMutableArray new];
    
    if([self getRight:t.sqID] != nil) {[adjTiles addObject:[self getRight:t.sqID]];}
    if([self getLeft:t.sqID] != nil) {[adjTiles addObject:[self getLeft:t.sqID]];}
    if([self getAbove:t.sqID] != nil) {[adjTiles addObject:[self getAbove:t.sqID]];}
    if([self getBelow:t.sqID] != nil) {[adjTiles addObject:[self getBelow:t.sqID]];}
    
    return adjTiles;
}

-(BOOL) canPlaceTile:(Tile*) t{
    for (SqID* sqID in [[Grid getInstance] getAllSqIDs]){
        if([self isValidMoveTile:t ToLoc:[[Grid getInstance] getCenter:sqID]]){return true;}
    }
    if([t.suit isEqualToString:@"wild"]){return true;}
    if (t == _topCard){
        [[Deck getInstance] replaceCard:t];
        _topCard = nil;
        [self newTopTile];
    }
    if (t == _botCard){
        [[Deck getInstance] replaceCard:t];
        _botCard = nil;
        [self newBotTile];
    }
    return false;
}

-(void)returnTileToDeck:(Tile*)t{
    [[Deck getInstance] replaceCard:t];
}

-(void) printCard:(Tile*)t{
    NSLog(@"Card = %@%u%@", t.backgroundColor, t.value, t.suit);
}

////////////////AI METHODS///////////////

-(NSArray*)getAllSqIDs{
    return [[Grid getInstance] getAllSqIDs];
}

-(void)resetAllSqIDValues{
    for (SqID* sqID in [[Grid getInstance] getAllSqIDs]){
        sqID.squareHeuristic = -FLT_MAX;
    }
}

@end

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
    [self reset];
    return self;
}

-(void) reset{
    [self replaceTiles];
    [[Deck getInstance] resetDeck];
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
}

-(Tile *)newTopTile{
    if(_topCard != nil){
     [placedTiles addObject:_topCard];
     [[Score getInstance] improvedUpdate:_topCard];
    }
    Tile * t = [[Deck getInstance] getNextCard];
    t.position = [[Grid getInstance] topCardLoc];
    _topCard = t;
    return t;
}

-(Tile *)newBotTile{
    if(_botCard != nil){
        [placedTiles addObject:_botCard];
        [[Score getInstance] improvedUpdate:_botCard];
    }
    Tile * t = [[Deck getInstance] getNextCard];
    t.position = [[Grid getInstance] botCardLoc];
    _botCard = t;
    return t;
}

-(Tile *)newCenterTile{
    Tile * t = [[Tile alloc] initWildCard];
    t.position = ccp(([Grid getInstance].width / 2), [Grid getInstance].height/2);
    t.sqID = [[Grid getInstance] getSquareID:t.position];
    [placedTiles addObject:t];
    return t;
}

-(NSMutableArray*) getPlacedTiles{
    return placedTiles;
}


// Tries to move a tile to a location, returns false if invalid move
-(BOOL)moveTile:(Tile *)t toLoc:(CGPoint)loc{
    
    //If valid location
    if([self isValidTile: t Loc:loc]){
        
        // Move the tile
        t.position = [[Grid getInstance] getNearestCenter:loc];
        t.sqID = [[Grid getInstance] getSquareID:t.position];
        
        return true;
    }
    return false;
}

// Checks move validity
-(BOOL) isValidTile:(Tile *) t Loc:(CGPoint)loc{
    SqID locID = [[Grid getInstance] getSquareID:loc];
    
    if(! [[Grid getInstance] isOnGrid:locID]){
        return false;
    }
    if([self tileOnSquare:locID] != nil){
        return false;
    }
    if(! [self hasMatchingTile:t]){
        return false;
    }

    return true;
}

// Returns the tile at a sqID, or nil if there is none
// CAN RETURN NULL!!!!
-(Tile *) tileOnSquare:(SqID) sqID{
    for(Tile * t in placedTiles){
        if([[Grid getInstance] thisID:sqID equalsThisID:t.sqID]){
            return t;
        }
    }
    return nil;
}

//Note: Only works if given a grid location
-(BOOL) hasMatchingTile:(Tile *)t{
    SqID sqID = [[Grid getInstance] getSquareID:t.position];
    
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

-(Tile*) getRight:(SqID)loc{
    return [self tileOnSquare:[[Grid getInstance] right:loc]];
    
}
-(Tile*) getLeft:(SqID)loc{
    return [self tileOnSquare:[[Grid getInstance] left:loc]];
}
-(Tile*) getAbove:(SqID)loc{
    return [self tileOnSquare:[[Grid getInstance] up:loc]];

}
-(Tile*) getBelow:(SqID)loc{
    return [self tileOnSquare:[[Grid getInstance] down:loc]];
}

-(void) printCard:(Tile*)t{
    NSLog(@"Card = %@%u%@", t.backgroundColor, t.value, t.suit);
}

@end

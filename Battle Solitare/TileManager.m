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

TileManager* instance;
NSMutableArray* allTiles;

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
    allTiles = [[NSMutableArray alloc] init];
    return self;
}

-(Tile *)newBotTile{
    Tile * t = [[Deck getInstance] getNextCard];
    t.position = [[Grid getInstance] botCardLoc];
    [allTiles addObject:t];
    _topCard = t;
    return t;
}

-(Tile *)newTopTile{
    Tile * t = [[Deck getInstance] getNextCard];
    t.position = [[Grid getInstance] topCardLoc];
    [allTiles addObject:t];
    _botCard = t;
    return t;
}

-(Tile *)newCenterTile{
    Tile * t = [[Tile alloc] initWildCard];
    t.position = ccp(([Grid getInstance].width / 2), [Grid getInstance].height/2);
    [allTiles addObject:t];
    return t;
}

-(NSMutableArray*) getAllTiles{
    return allTiles;
}

-(BOOL)moveTile:(Tile *)t toLoc:(CGPoint)loc{
    if([self isValidTile: t Loc:loc]){
        
        t.position = [[Grid getInstance] getGridPoint:loc];
        
        return true;
    }
    return false;
}

-(BOOL) isValidTile:(Tile *) t Loc:(CGPoint)loc{
    CGPoint gridLoc = [[Grid getInstance] getGridPoint:loc];
    if(! [[Grid getInstance] isOnGrid:gridLoc]){
        return false;
    }
    if([self tileOnSquare:gridLoc] != nil){
        return false;
    }
    if(! [self hasMatchingTile:t atLoc:gridLoc]){
        return false;
    }

    return true;
}

// Note: Only works if given a grid location
// CAN RETURN NULL!!!!
-(Tile *) tileOnSquare:(CGPoint) gridLoc{
    for(Tile * t in allTiles){
        if(t.position.x == gridLoc.x && t.position.y == gridLoc.y){
            return t;
        }
    }
    return nil;
}

//Note: Only works if given a grid location
-(BOOL) isAdjacentTile:(CGPoint)gridLoc{
    if([self tileOnSquare:ccp(gridLoc.x+[Grid getInstance].sqWidth, gridLoc.y)]){
        return true;
    }
    if([self tileOnSquare:ccp(gridLoc.x-[Grid getInstance].sqWidth, gridLoc.y)]){
        return true;
    }
    if([self tileOnSquare:ccp(gridLoc.x, gridLoc.y+[Grid getInstance].sqHeight)]){
        return true;
    }
    if([self tileOnSquare:ccp(gridLoc.x, gridLoc.y-[Grid getInstance].sqHeight)]){
        return true;
    }
    return false;
}

//Note: Only works if given a grid location
-(BOOL) hasMatchingTile:(Tile *)t atLoc:(CGPoint) gridLoc{
    Tile * adj = [self getRight:gridLoc];
    if(adj != nil){
        if([t matches:adj]){
            return true;
        }
    }
    
    adj = [self getLeft:gridLoc];
    if(adj != nil){
        if([t matches:adj]){
            return true;
        }
    }
    
    adj = [self getAbove:gridLoc];
    if(adj != nil){
        if([t matches:adj]){
            return true;
        }
    }
    
    adj = [self getBelow:gridLoc];
    if(adj != nil){
        if([t matches:adj]){
            return true;
        }
    }

    return false;
}

-(Tile*) getRight:(CGPoint)p{
    CGPoint loc = [[Grid getInstance] getGridPoint:p];
    return [self tileOnSquare:ccp(loc.x+[Grid getInstance].sqWidth, loc.y)];
}
-(Tile*) getLeft:(CGPoint)p{
    CGPoint loc = [[Grid getInstance] getGridPoint:p];
    return [self tileOnSquare:ccp(loc.x-[Grid getInstance].sqWidth, loc.y)];
}
-(Tile*) getAbove:(CGPoint)p{
    CGPoint loc = [[Grid getInstance] getGridPoint:p];
    return [self tileOnSquare:ccp(loc.x, loc.y+[Grid getInstance].sqHeight)];
}
-(Tile*) getBelow:(CGPoint)p{
    CGPoint loc = [[Grid getInstance] getGridPoint:p];
    return [self tileOnSquare:ccp(loc.x, loc.y-[Grid getInstance].sqHeight)];
}

-(void) printCard:(Tile*)t{
    NSLog(@"Card = %@%u%@", t.backgroundColor, t.value, t.suit);
}

@end

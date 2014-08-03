//
//  Score.m
//  Battle Solitare
//
//  Created by Kevin Yue on 3/7/14.
//  Copyright (c) 2014 Kevin Yue. All rights reserved.
//

#import "Score.h"
#import "cocos2d.h"
#import "TileManager.h"
#import "Tile.h"

@implementation Score

static Score * instance;
NSArray *blackTiles;
NSArray *whiteTiles;


+(Score *) getInstance{
    if (instance == nil){
        instance = [[self alloc] init];
    }
    return instance;
}

-(id) init{
    self = [super init];
    [self reset];
    return self;
}


-(void) updateScores{
    for(Tile* startTile in [[TileManager getInstance] getPlacedTiles]){
        NSMutableArray * a = [NSMutableArray new];
        NSString *startColor;
        if([startTile.backgroundColor isEqualToString:@"wild"]){
            startColor = @"none";
        }
        else{
            startColor = startTile.backgroundColor;
        }
        
        startTile.scoreHeuristic = 0;
        [a addObject:startTile];
        [self extendAllDirections:a ofColor:startColor];
    }

}

-(void) improvedUpdate:(Tile*)t{
    NSString *startColor;
    if([t.backgroundColor isEqualToString:@"wild"]){
        return [self updateScores];
    }
    else{
        startColor = t.backgroundColor;
    }

    for(Tile* startTile in [[TileManager getInstance] getPlacedTiles]){
        NSMutableArray * a = [NSMutableArray new];
        
        if(![startTile.backgroundColor isEqualToString:@"wild"] &&
           ![startTile.backgroundColor isEqualToString:startColor]){
            continue;
        }
        
        // Set startTile maxpath = 0
        startTile.scoreHeuristic = 0;

        [a addObject:startTile];
        [self extendAllDirections:a ofColor:startColor];
    }
}

-(void) extendChain:(NSMutableArray*)tiles ofColor:(NSString*)color toTile:(Tile* )t{
    
    //No duplicate tiles
    for(Tile* tile in tiles){
        if (tile == t){
            return;
        }
    }
    // No empty squares
    if(t == nil){
        return;
    }
    // If the path currently does not belong to either color, and you get a colored tile
    else if([color isEqualToString:@"none"] && ![t.backgroundColor isEqualToString:@"wild"]){
        // Extend the path with the color of the colored tile
        [tiles addObject:t];
        color = t.backgroundColor;
        
        // Check if longest path
        if([color isEqualToString:@"b"]){
            if(tiles.count > blackTiles.count){
                blackTiles = [[NSArray alloc] initWithArray:tiles];
            }
        }
        if([color isEqualToString:@"w"]){
            if(tiles.count > whiteTiles.count){
                whiteTiles = [[NSArray alloc] initWithArray:tiles];
            }
        }
        
        // Check heuristic
        Tile * first = tiles.firstObject;
        first.scoreHeuristic = MAX(first.scoreHeuristic, tiles.count);
        
        // Extend Path
        [self extendAllDirections:tiles ofColor:color];
    }
    // Otherwise if the background color of the new card matches, or if the new card is wild
    else if(t.backgroundColor == color || [t.backgroundColor isEqualToString:@"wild"]){
        //Extend the path with the current tile
        [tiles addObject:t];
        
        // Check if longest path
        if([color isEqualToString:@"b"]){
            if(tiles.count > blackTiles.count){
                blackTiles = [[NSArray alloc] initWithArray:tiles];
            }
        }
        if([color isEqualToString:@"w"]){
            if(tiles.count > whiteTiles.count){
                whiteTiles = [[NSArray alloc] initWithArray:tiles];
            }
        }
        
        // Check heuristic
        Tile * first = tiles.firstObject;
        first.scoreHeuristic = MAX(first.scoreHeuristic, tiles.count);
        
        // Extend Path
        [self extendAllDirections:tiles ofColor:color];
    }
}

-(void)extendAllDirections:(NSArray*)tiles ofColor:(NSString*)color{
    Tile * t = tiles.lastObject;
    [self extendChain:[NSMutableArray arrayWithArray:tiles] ofColor:color toTile:[[TileManager getInstance] getRight:[[Grid getInstance] getSquareID:t.position]]];
    [self extendChain:[NSMutableArray arrayWithArray:tiles] ofColor:color toTile:[[TileManager getInstance] getLeft:[[Grid getInstance] getSquareID:t.position]]];
    [self extendChain:[NSMutableArray arrayWithArray:tiles] ofColor:color toTile:[[TileManager getInstance] getAbove:[[Grid getInstance] getSquareID:t.position]]];
    [self extendChain:[NSMutableArray arrayWithArray:tiles] ofColor:color toTile:[[TileManager getInstance] getBelow:[[Grid getInstance] getSquareID:t.position]]];
}

-(int)blackScore{
    return (int) blackTiles.count;
}
-(int)whiteScore{
    return (int) whiteTiles.count;
}
-(NSArray *)blackPath{
    return [NSMutableArray arrayWithArray:blackTiles];
}
-(NSArray *)whitePath{
    return [NSMutableArray arrayWithArray:whiteTiles];
}
-(void) printWhitePath{
    for(Tile* t in whiteTiles){
        [t printCard];
    }
}
-(void) printBlackPath{
    for(Tile* t in blackTiles){
        [t printCard];
    }
}

-(void)reset{
    blackTiles = [NSArray new];
    whiteTiles = [NSArray new];
}

@end

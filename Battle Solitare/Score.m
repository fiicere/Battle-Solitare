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
    [self resetVariables];
    return self;
}

-(void) resetVariables{
    blackTiles = [NSArray new];
    whiteTiles = [NSArray new];

}

-(void) updateScores{
    for(Tile* startTile in [[TileManager getInstance] getAllTiles]){
        if([startTile.backgroundColor isEqualToString:@"wild"]){
            continue;
        }
        NSMutableArray * a = [NSMutableArray new];
        [a addObject:startTile];
        [self extendChain:[NSMutableArray arrayWithArray:a] ofColor:startTile.backgroundColor toTile:[[TileManager getInstance] getRight:startTile.position]];
        [self extendChain:[NSMutableArray arrayWithArray:a] ofColor:startTile.backgroundColor toTile:[[TileManager getInstance] getLeft:startTile.position]];
        [self extendChain:[NSMutableArray arrayWithArray:a] ofColor:startTile.backgroundColor toTile:[[TileManager getInstance] getAbove:startTile.position]];
        [self extendChain:[NSMutableArray arrayWithArray:a] ofColor:startTile.backgroundColor toTile:[[TileManager getInstance] getBelow:startTile.position]];
    }

}

-(void) extendChain:(NSMutableArray*)tiles ofColor:(NSString*)color toTile:(Tile* )t{
    
    //No duplicate tiles
    for(Tile* tile in tiles){
        if (tile == t){
            return;
        }
    }
    //No empty squares
    if(t == nil){
        return;
    }
    else if(t.backgroundColor == color || [t.backgroundColor isEqualToString:@"wild"]){
        [tiles addObject:t];
        
        if([color isEqualToString:@"b"]){
            if(tiles.count > blackTiles.count){
                blackTiles = [[NSArray alloc] initWithArray:tiles];
                NSLog(@"Black Score = %u", blackTiles.count);
            }
        }
        if([color isEqualToString:@"w"]){
            if(tiles.count > whiteTiles.count){
                whiteTiles = [[NSArray alloc] initWithArray:tiles];
                NSLog(@"White Score = %u", whiteTiles.count);
            }
        }
        [self extendChain:[NSMutableArray arrayWithArray:tiles] ofColor:color toTile:[[TileManager getInstance] getRight:t.position]];
        [self extendChain:[NSMutableArray arrayWithArray:tiles] ofColor:color toTile:[[TileManager getInstance] getLeft:t.position]];
        [self extendChain:[NSMutableArray arrayWithArray:tiles] ofColor:color toTile:[[TileManager getInstance] getAbove:t.position]];
        [self extendChain:[NSMutableArray arrayWithArray:tiles] ofColor:color toTile:[[TileManager getInstance] getBelow:t.position]];
    }
}

-(int)blackScore{
    return (int) blackTiles.count;
}
-(int)whiteScore{
    return (int) whiteTiles.count;
}

@end

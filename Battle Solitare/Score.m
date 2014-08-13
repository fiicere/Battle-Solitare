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
NSMutableArray * floodTiles;


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

-(void)updateForPlayedTile:(Tile*)t{
    [self floodTile:t];
    [self findBestPath];
}

-(void)floodTile:(Tile*)t{
    floodTiles = [NSMutableArray new];
    [floodTiles addObject:t];
    for (Tile*adj in [[TileManager getInstance] getAdjTiles:t]){
        [self addTileToFloodTilesRecurse:adj];
    };
}

-(void)addTileToFloodTilesRecurse:(Tile*)t{
    if(![floodTiles containsObject:t] && [floodTiles.firstObject matchesBackgroundColor:t.backgroundColor]){
        [floodTiles addObject:t];
        for(Tile* adj in [[TileManager getInstance] getAdjTiles:t]) {
            [self addTileToFloodTilesRecurse:adj];
        }
    }
}

-(void)findBestPath{
    for (Tile* startTile in floodTiles) {[self dfs:startTile];}
}

-(void)dfs:(Tile*)t{
    if ([t.backgroundColor isEqualToString:@"b"]) {[self dfsRecurse:[NSMutableArray new] toTile:t withColor:@"b"];}
    if ([t.backgroundColor isEqualToString:@"w"]) {[self dfsRecurse:[NSMutableArray new] toTile:t withColor:@"w"];}
    if ([t.backgroundColor isEqualToString:@"wild"]) {
        [self dfsRecurse:[NSMutableArray new] toTile:t withColor:@"b"];
        [self dfsRecurse:[NSMutableArray new] toTile:t withColor:@"w"];
    }
}

-(void)dfsRecurse:(NSMutableArray*)path toTile:(Tile*) t withColor:(NSString*)color{
    if([t matchesBackgroundColor:color] && ![path containsObject:t]) {
        [path addObject:t];
        for(Tile* nextTile in [[TileManager getInstance] getAdjTiles:t]){
            [self dfsRecurse:[NSMutableArray arrayWithArray:path] toTile:nextTile withColor:color];
        }
    }
    else{
        [self replaceBestPath:path Color:color];
        [self updateSquareHeuristic:path];
    }
}

-(void)replaceBestPath:(NSMutableArray*)path Color:(NSString*)color{
    if([color isEqualToString:@"b"]){
        if(path.count > blackTiles.count) {blackTiles = [[NSArray alloc] initWithArray:path];}
    }
    else if([color isEqualToString:@"w"]){
        if(path.count > whiteTiles.count) {whiteTiles = [[NSArray alloc] initWithArray:path];}
    }
    else{NSLog(@"ERROR: %@ is not a valid color for a scoring path", color);}
}

-(void)updateSquareHeuristic:(NSArray*)path{
    Tile * startTile = path.firstObject;
    startTile.scoreHeuristic = max(startTile.scoreHeuristic, path.count);
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

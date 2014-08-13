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
NSArray *bestBlackPath;
NSArray *bestWhitePath;
NSMutableArray * floodTiles;

NSArray *farthestWhiteTile;
NSArray *farthestBlackTile;


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

-(void)floodUpdateForPlayedTile:(Tile*)t{
    [self floodTile:t];
    [self findBestPathFromFlood];
}

-(void)farUpdateForPlayedTile:(Tile*)t{
    NSLog(@"FAR UPDATE FOR TILE %@%u%@", t.backgroundColor, t.value, t.suit);
    [self dfs:t];
    [self findBestPathFromDFS];
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

-(void)findBestPathFromFlood{
    for (Tile* startTile in floodTiles) {
        [self dfs:startTile];
        [self updateBestPaths];
    }
}

-(void)findBestPathFromDFS{
    if(farthestWhiteTile.count > 0) {
        Tile * farthestWhite = farthestWhiteTile.lastObject;
        NSLog(@"Farthest White Tile is %@%u%@", farthestWhite.backgroundColor, farthestWhite.value, farthestWhite.suit);
        [self dfs:farthestWhite];
    }
    if(farthestBlackTile.count > 0) {
        Tile * farthestBlack = farthestBlackTile.lastObject;
        NSLog(@"Farthest Black Tile is %@%u%@", farthestBlack.backgroundColor, farthestBlack.value, farthestBlack.suit);
        [self dfs:farthestBlack];
    }
    [self updateBestPaths];
}

-(void)dfs:(Tile*)t{
    [self resetDFSArrays];
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
        [self replaceFarthestTile:path Color:color];
        [self updateSquareHeuristic:path];
        for(Tile* nextTile in [[TileManager getInstance] getAdjTiles:t]){
            [self dfsRecurse:[NSMutableArray arrayWithArray:path] toTile:nextTile withColor:color];
        }
    }
}

-(void)resetDFSArrays{
    farthestBlackTile = [NSArray new];
    farthestWhiteTile = [NSArray new];
}

-(void)updateBestPaths{
    if(farthestBlackTile.count > bestBlackPath.count) {bestBlackPath = [[NSArray alloc] initWithArray:farthestBlackTile];}
    if(farthestWhiteTile.count > bestWhitePath.count) {bestWhitePath = [[NSArray alloc] initWithArray:farthestWhiteTile];}
}

-(void)replaceFarthestTile:(NSMutableArray*)path Color:(NSString*)color{
    if([color isEqualToString:@"b"]){
        if(path.count > farthestBlackTile.count) {farthestBlackTile = [[NSArray alloc] initWithArray:path];}
    }
    else if([color isEqualToString:@"w"]){
        if(path.count > farthestWhiteTile.count) {farthestWhiteTile = [[NSArray alloc] initWithArray:path];}
    }
    else{NSLog(@"ERROR: %@ is not a valid color for a scoring path", color);}
}

-(void)updateSquareHeuristic:(NSArray*)path{
    Tile * startTile = path.firstObject;
    startTile.scoreHeuristic = max(startTile.scoreHeuristic, path.count);
}

-(NSMutableArray*)reverseArray:(NSArray*)arrayToReverse{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[arrayToReverse count]];
    NSEnumerator *enumerator = [arrayToReverse reverseObjectEnumerator];
    for (id element in enumerator) {[array addObject:element];}
    return array;
}


-(int)blackScore{
    return (int) bestBlackPath.count;
}
-(int)whiteScore{
    return (int) bestWhitePath.count;
}
-(NSArray *)blackPath{
    return [NSMutableArray arrayWithArray:bestBlackPath];
}
-(NSArray *)whitePath{
    return [NSMutableArray arrayWithArray:bestWhitePath];
}
-(void) printWhitePath{
    for(Tile* t in bestWhitePath){
        [t printCard];
    }
}
-(void) printBlackPath{
    for(Tile* t in bestBlackPath){
        [t printCard];
    }
}

-(void)reset{
    bestBlackPath = [NSArray new];
    bestWhitePath = [NSArray new];
}

@end

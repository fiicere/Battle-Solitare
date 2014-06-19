//
//  MoveHeuristic.m
//  Battle Solitare
//
//  Created by Kevin Yue on 6/18/14.
//  Copyright (c) 2014 Kevin Yue. All rights reserved.
//

#import "MoveHeuristic.h"
#import "Tile.h"
#import "TileManager.h"

NSMutableDictionary * squareValues;
MoveHeuristic * instance;

@implementation MoveHeuristic

+(MoveHeuristic*)getInstance{
    if (instance == nil) {instance = [[self alloc] init];}
    return instance;
}

-(id)init{
    self = [super init];
    squareValues = [NSMutableDictionary dictionary];
    return self;
}

-(void)canPlaceTile:(Tile*)tile{
    
}



@end

//
//  Touch.m
//  Battle Solitare
//
//  Created by Kevin Yue on 2/22/14.
//  Copyright (c) 2014 Kevin Yue. All rights reserved.
//

#import "Touch.h"
#import "Tile.h"

@implementation Touch

Tile *tile;
CGPoint start;

-(id)init{
    if (self = [super init]){
        
    }
    return self;
}

-(id)touchedTile:(Tile *)t atLoc:(CGPoint)loc{
    if (self = [super init]){
        
    }
    start = loc;
    tile = t;
    return self;
}

-(Tile*) getTile{
    return tile;
}

-(CGPoint) getStartPoint{
    return start;
}


@end

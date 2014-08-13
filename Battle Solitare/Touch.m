//
//  Touch.m
//  Battle Solitare
//
//  Created by Kevin Yue on 2/22/14.
//  Copyright (c) 2014 Kevin Yue. All rights reserved.
//

#import "Touch.h"
#import "Tile.h"
#import "Clock.h"

@implementation Touch

Tile *tile;
CGPoint startLoc;
float startTime;

-(id)init{
    if (self = [super init]){
        
    }
    return self;
}

-(id)touchedTile:(Tile *)t atLoc:(CGPoint)loc{
    if (self = [super init]){}
    NSLog(@"TOUCHED TILE");
    startLoc = loc;
    tile = t;
    NSLog(@"WTF");
    [Clock getInstance];
    NSLog(@"WTFx2");    
    startTime = [[Clock getInstance] getTime];
    NSLog(@"FINISHED CREATING TOUCHED TILE");
    return self;
}

-(Tile*) getTile{
    return tile;
}

-(CGPoint) getStartPoint{
    return startLoc;
}

-(float)getStartTime{
    return startTime;
}

@end

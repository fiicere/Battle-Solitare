//
//  SqID.m
//  Battle Solitare
//
//  Created by Kevin Yue on 8/2/14.
//  Copyright (c) 2014 Kevin Yue. All rights reserved.
//

#import "SqID.h"
#import "Tile.h"

@implementation SqID

int myXCoord;
int myYCoord;

Tile * tileOnSqID;

-(id)initWithX:(int)xCoord Y:(int)yCoord{
    self = [super init];
    
    myXCoord = xCoord;
    myYCoord = yCoord;
    
    return self;
}

-(int)x {return myXCoord;}

-(int)y {return myYCoord;}

-(BOOL) isOccupied{
    return tileOnSqID != nil;
}

-(Tile *) tileOnSquare{
    return tileOnSqID;
}

-(void) fillSquareWithTile:(Tile*)t{
    tileOnSqID = t;
}

@end

//
//  SqID.h
//  Battle Solitare
//
//  Created by Kevin Yue on 8/2/14.
//  Copyright (c) 2014 Kevin Yue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tile.h"

@interface SqID : NSObject

-(id)initWithX:(int)xCoord Y:(int)yCoord;

-(int) x;
-(int) y;

-(BOOL) isOccupied;

-(Tile *) tileOnSquare;

-(void) fillSquareWithTile:(Tile*)t;
@end

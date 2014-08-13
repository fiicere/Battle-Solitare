//
//  Touch.h
//  Battle Solitare
//
//  Created by Kevin Yue on 2/22/14.
//  Copyright (c) 2014 Kevin Yue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tile.h"

@interface Touch : NSObject

-(id)touchedTile:(Tile *)t atLoc:(CGPoint)loc;
-(Tile*) getTile;
-(CGPoint) getStartPoint;
-(float)getStartTime;

@end

//
//  TileManager.h
//  Battle Solitare
//
//  Created by Kevin Yue on 12/30/13.
//  Copyright (c) 2013 Kevin Yue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tile.h"

@interface TileManager : NSObject

+(TileManager *)getInstance;
-(Tile*)newBotTile;
-(Tile*)newTopTile;
-(Tile *)newCenterTile;

@property (nonatomic, assign) Tile * topCard;
@property (nonatomic, assign) Tile * botCard;

-(BOOL)moveTile:(Tile *)tile toLoc:(CGPoint)point;

-(NSMutableArray*) getAllTiles;

-(Tile*) getRight:(CGPoint)loc;
-(Tile*) getLeft:(CGPoint)loc;
-(Tile*) getAbove:(CGPoint)loc;
-(Tile*) getBelow:(CGPoint)loc;

-(void) printCard:(Tile*)t;

@end

//
//  TileManager.h
//  Battle Solitare
//
//  Created by Kevin Yue on 12/30/13.
//  Copyright (c) 2013 Kevin Yue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tile.h"
#import "Grid.h"

@interface TileManager : NSObject

+(TileManager *)getInstance;

@property (nonatomic, assign) Tile * topCard;
@property (nonatomic, assign) Tile * botCard;

-(BOOL)moveTile:(Tile *)tile toLoc:(CGPoint)point;

-(NSMutableArray*) getPlacedTiles;

-(Tile*) getRight:(SqID*)loc;
-(Tile*) getLeft:(SqID*)loc;
-(Tile*) getAbove:(SqID*)loc;
-(Tile*) getBelow:(SqID*)loc;

-(NSArray*)getAdjTiles:(Tile*)t;

-(void) printCard:(Tile*)t;

-(void) newGame;


//AI Methods
-(NSArray*)getAllSqIDs;

-(void)resetAllSqIDValues;

@end

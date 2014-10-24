//
//  Grid.m
//  Battle Solitare
//
//  Created by Kevin Yue on 12/30/13.
//  Copyright (c) 2013 Kevin Yue. All rights reserved.
//

#import "Grid.h"
#import "cocos2d.h"

@implementation Grid

static Grid *instance;
const int gridDimens = 7;
NSArray * allSqIDs;

+(Grid *)getInstance{
    if(instance == nil){
        instance = [[self alloc] init];
    }
    return instance;
}

-(id)init{
    self = [super init];
    [self setupVariables];
    [self setupSqIDs];
    return self;
}

-(void)resetSquares{
    [self setupSqIDs];
}

-(void)setupVariables{
    _width = [CCDirector sharedDirector].winSize.width;
    _height = [CCDirector sharedDirector].winSize.height;
    
    _sqWidth = _width / (gridDimens + 1);
    _sideMargin = _sqWidth;
    
    _sqHeight = _height / (gridDimens + 3);
    _verticalMargin = 2 * _sqHeight;
    
    _botCardLoc = ccp(_width/2, _sqHeight * 3 / 4);
    _topCardLoc = ccp(_width/2, _height - _sqHeight * 3 / 4);
}

-(void) setupSqIDs{
    NSMutableArray * newSqIDs = [NSMutableArray new];
    for(int i=0; i<gridDimens; i++){
        for(int j=0; j<gridDimens; j++){
            [newSqIDs addObject:[[SqID alloc] initWithX:i Y:j]];
        }
    }
    allSqIDs = newSqIDs;
}

-(SqID*) getSquareID:(CGPoint)loc{
    return [self getSquareIDX:(int) roundf((loc.x-_sideMargin)/_sqWidth)
                        Y:(int) roundf((loc.y-_verticalMargin)/_sqHeight)];

}

-(SqID*) getSquareIDX:(int)x Y:(int)y{
    for(SqID * sqID in allSqIDs){
        if(sqID.x == x && sqID.y == y){
            return sqID;
        }
    }
    SqID * newSqID = [[SqID alloc] initWithX:x Y:y];
    newSqID.occupied = true;
    return newSqID;
}

-(CGPoint) getCenter:(SqID*)squareID{
    CGPoint loc;
    loc.x = squareID.x * _sqWidth + _sideMargin;
    loc.y = squareID.y * _sqHeight + _verticalMargin;
    return loc;
}

-(CGPoint) getNearestCenter:(CGPoint)loc{
    CGPoint point;
    
    point.x = ((roundf((loc.x-_sideMargin)/_sqWidth)*_sqWidth)+_sideMargin);
    point.y = ((roundf((loc.y-_verticalMargin)/_sqHeight)*_sqHeight)+_verticalMargin);
    return point;
}

//NOTE: Point not necessarily on grid
-(SqID*)right:(SqID*)point{return [self getSquareIDX:point.x+1 Y:point.y];}

-(SqID*)left:(SqID*)point{return [self getSquareIDX:point.x-1 Y:point.y];}

-(SqID*)up:(SqID*)point{return [self getSquareIDX:point.x Y:point.y+1];}

-(SqID*)down:(SqID*)point{return [self getSquareIDX:point.x Y:point.y-1];}


-(BOOL) isOnGrid:(SqID*)sqID{
    if (sqID.x >= gridDimens || sqID.x < 0 || sqID.y >= gridDimens || sqID.y < 0) {
        return false;
    }
    return true;
}

-(BOOL) thisID:(SqID*)a equalsThisID:(SqID*)b{
    if(a.x == b.x && a.y == b.y){
        return true;
    }
    return false;
}

-(NSArray*)getAllSqIDs{
    return allSqIDs;
}


@end

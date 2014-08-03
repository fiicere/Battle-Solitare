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


+(Grid *)getInstance{
    if(instance == nil){
        instance = [[self alloc] init];
    }
    return instance;
}

-(id)init{
    self = [super init];
    [self setupVariables];
    return self;
}

-(void)setupVariables{
    _width = [CCDirector sharedDirector].winSize.width;
    _height = [CCDirector sharedDirector].winSize.height;
    
    _sqWidth = _width / (gridDimens + 1);
    _sideMargin = _sqWidth;
    
    _sqHeight = _height / (gridDimens + 3);
    _verticalMargin = 2* _sqHeight;
    
    _botCardLoc = ccp(_width/2, _sqHeight * 3 / 4);
    _topCardLoc = ccp(_width/2, _height - _sqHeight * 3 / 4);
}


-(SqID*) getSquareID:(CGPoint)loc{
    SqID * squareID = [[SqID alloc] initWithX:(int) roundf((loc.x-_sideMargin)/_sqWidth)
                                            Y:(int) roundf((loc.y-_verticalMargin)/_sqHeight)];
    return squareID;
}

-(CGPoint) getCenter:(SqID *)squareID{
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
-(SqID*)right:(SqID*)point{
    return [[SqID alloc] initWithX:point.x+1 Y:point.y];
}
-(SqID*)left:(SqID*)point{
    return [[SqID alloc] initWithX:point.x-1 Y:point.y];
}

    
-(SqID*)up:(SqID*)point{
    return [[SqID alloc] initWithX:point.x Y:point.y+1];
}

-(SqID*)down:(SqID*)point{
    return [[SqID alloc] initWithX:point.x Y:point.y-1];
}

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

@end

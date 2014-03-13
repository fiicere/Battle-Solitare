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
    
    _sqWidth = _width / 8;
    _sideMargin = _sqWidth;
    
    _sqHeight = _height / 10;
    _verticalMargin = 2* _sqHeight;
    
    _botCardLoc = ccp(_width/2, _sqHeight * 3 / 4);
    _topCardLoc = ccp(_width/2, _height - _sqHeight * 3 / 4);
}

-(CGPoint)getGridPoint:(CGPoint)point{
    return [self getGridX:point.x Y:point.y];
}

-(CGPoint)getGridX:(CGFloat)x Y:(CGFloat)y{
    CGPoint point;
    
    point.x = ((roundf((x-_sideMargin)/_sqWidth)*_sqWidth)+_sideMargin);
    point.y = ((roundf((y-_verticalMargin)/_sqHeight)*_sqHeight)+_verticalMargin);
    return point;
}

//NOTE: Point not necessarily on grid
-(CGPoint)getRight:(CGPoint)point{
    CGPoint newPoint = ccp(point.x + _sqWidth, point.y);
    return [self getGridPoint:newPoint];
}
-(CGPoint)getLeft:(CGPoint)point{
    CGPoint newPoint = ccp(point.x - _sqWidth, point.y);
    return [self getGridPoint:newPoint];
}
-(CGPoint)getUp:(CGPoint)point{
    CGPoint newPoint = ccp(point.x, point.y + _sqHeight);
    return [self getGridPoint:newPoint];
}
-(CGPoint)getDown:(CGPoint)point{
    CGPoint newPoint = ccp(point.x, point.y + _sqHeight);
    return [self getGridPoint:newPoint];
}

-(BOOL) isOnGrid:(CGPoint) loc{
    // Check
    if (loc.x < _sideMargin){
        return false;
    }
    else if (loc.x > (_width -_sideMargin)){
        return false;
    }
    else if (loc.y < _verticalMargin){
        return false;
    }
    else if (loc.y > (_height - _verticalMargin)){
        return false;
    }
    return true;
}


@end

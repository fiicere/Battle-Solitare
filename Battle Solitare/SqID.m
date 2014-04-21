//
//  SqID.m
//  Battle Solitare
//
//  Created by Kevin Yue on 4/21/14.
//  Copyright (c) 2014 Kevin Yue. All rights reserved.
//

#import "SqID.h"

@implementation SqID

-(id)init:(CGPoint)point{
    self = [super init];
    
    _x = (int) (point.x + 0.5);
    _y = (int) (point.y + 0.5);
 
    return self;
}

-(id)initX:(int)x Y:(int)y{
    self = [super init];
    _x = x;
    _y = y;
    
    return self;
}

-(SqID *) right{
    SqID * new = [[SqID alloc] initX:_x+1 Y:_y];
    return new;
}
-(SqID *) left{
    SqID * new = [[SqID alloc] initX:_x-1 Y:_y];
    return new;
}
-(SqID *) up{
    SqID * new = [[SqID alloc] initX:_x Y:_y+1];
    return new;
}
-(SqID *) down{
    SqID * new = [[SqID alloc] initX:_x Y:_y-1];
    return new;
}

@end

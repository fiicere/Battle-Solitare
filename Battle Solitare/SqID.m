//
//  SqID.m
//  Battle Solitare
//
//  Created by Kevin Yue on 8/3/14.
//  Copyright (c) 2014 Kevin Yue. All rights reserved.
//

#import "SqID.h"

@implementation SqID

-(id)initWithX:(int)xCoord Y:(int)yCoord{
    self = [super init];
    _x = xCoord;
    _y = yCoord;
    return self;
}


@end

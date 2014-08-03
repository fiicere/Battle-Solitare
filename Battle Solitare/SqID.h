//
//  SqID.h
//  Battle Solitare
//
//  Created by Kevin Yue on 8/3/14.
//  Copyright (c) 2014 Kevin Yue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SqID : NSObject

@property (nonatomic, assign) int x;
@property (nonatomic, assign) int y;

@property (nonatomic, assign) bool occupied;


-(id)initWithX:(int)xCoord Y:(int)yCoord;


@end

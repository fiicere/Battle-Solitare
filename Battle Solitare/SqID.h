//
//  SqID.h
//  Battle Solitare
//
//  Created by Kevin Yue on 4/21/14.
//  Copyright (c) 2014 Kevin Yue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SqID : NSObject

@property (nonatomic, assign) int x;
@property (nonatomic, assign) int y;


-(id)init:(CGPoint)point;
-(id)initX:(int)x Y:(int)y;


@end

//
//  Grid.h
//  Battle Solitare
//
//  Created by Kevin Yue on 12/30/13.
//  Copyright (c) 2013 Kevin Yue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Grid : NSObject {
    
}

+(Grid *)getInstance;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat sqWidth;
@property (nonatomic, assign) CGFloat sqHeight;
@property (nonatomic, assign) CGFloat sideMargin;
@property (nonatomic, assign) CGFloat verticalMargin;

@property (nonatomic, assign) CGPoint topCardLoc;
@property (nonatomic, assign) CGPoint botCardLoc;


-(CGPoint)getGridPoint:(CGPoint)point;
-(CGPoint)getGridX:(CGFloat)x Y:(CGFloat)y;
-(BOOL) isOnGrid:(CGPoint) loc;


-(CGPoint)getRight:(CGPoint)point;
-(CGPoint)getLeft:(CGPoint)point;
-(CGPoint)getUp:(CGPoint)point;
-(CGPoint)getDown:(CGPoint)point;

@end

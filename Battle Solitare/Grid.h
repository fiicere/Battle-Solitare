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

struct SqID {
    int x;
    int y;
};
typedef struct SqID SqID;

+(Grid *)getInstance;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat sqWidth;
@property (nonatomic, assign) CGFloat sqHeight;
@property (nonatomic, assign) CGFloat sideMargin;
@property (nonatomic, assign) CGFloat verticalMargin;

@property (nonatomic, assign) CGPoint topCardLoc;
@property (nonatomic, assign) CGPoint botCardLoc;

-(SqID) getSquareID:(CGPoint)loc;
-(CGPoint) getCenter:(SqID)squareID;
-(CGPoint) getNearestCenter:(CGPoint)loc;

-(BOOL) isOnGrid:(SqID) loc;


-(SqID)right:(SqID)point;
-(SqID)left:(SqID)point;
-(SqID)up:(SqID)point;
-(SqID)down:(SqID)point;

-(BOOL) thisID:(SqID)a equalsThisID:(SqID)b;

@end

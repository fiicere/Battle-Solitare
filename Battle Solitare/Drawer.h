//
//  Draw.h
//  Battle Solitare
//
//  Created by Kevin Yue on 5/8/14.
//  Copyright 2014 Kevin Yue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Drawer : CCDrawNode {

}

-(id)initWithPath:(NSArray*)p andColorIsBlack:(BOOL)isBlack;
+(float)getMarkerWidth;
-(bool)isFinishedDrawing;

@end

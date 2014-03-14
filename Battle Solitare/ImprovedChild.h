//
//  ImprovedChild.h
//  Battle Solitare
//
//  Created by Kevin Yue on 3/13/14.
//  Copyright 2014 Kevin Yue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ImprovedSprite.h"

@interface ImprovedChild : ImprovedSprite {
}

-(id) initWithParent:(ImprovedSprite*) p andFile:(NSString*)filename;
-(void) scaleToX:(CGFloat)newX Y:(CGFloat)newY;
-(void) setPositionX:(CGFloat)x Y:(CGFloat)y;
-(void) debug;

@end

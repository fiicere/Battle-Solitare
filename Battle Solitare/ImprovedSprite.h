//
//  ImprovedSprite.h
//  Battle Solitare
//
//  Created by Kevin Yue on 3/6/14.
//  Copyright 2014 Kevin Yue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface ImprovedSprite : CCSprite {
    
}

-(void)scaleToX:(CGFloat)newX Y:(CGFloat)newY;
-(void) changeOpacity:(CGFloat)newOpacity;

@end

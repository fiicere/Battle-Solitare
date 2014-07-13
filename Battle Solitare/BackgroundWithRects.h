//
//  BackgroundWithRects.h
//  Battle Solitare
//
//  Created by Kevin Yue on 5/9/14.
//  Copyright 2014 Kevin Yue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "BackgroundLayer.h"
#import "ImprovedSprite.h"

@interface BackgroundWithRects : BackgroundLayer {
    
}

-(void)addPlayerRects;

-(ImprovedSprite*)topRect;

-(ImprovedSprite*)botRect;

@end

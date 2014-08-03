//
//  PauseLayer.h
//  Battle Solitare
//
//  Created by Kevin Yue on 5/2/14.
//  Copyright 2014 Kevin Yue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "BackgroundLayer.h"

@interface PauseLayer : BackgroundLayer {
    
}

-(id)initWithOrientation:(BOOL)isRightSideUp isSoloMode:(BOOL)isSoloMode;

@end

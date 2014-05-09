//
//  ImprovedSprite.m
//  Battle Solitare
//
//  Created by Kevin Yue on 3/6/14.
//  Copyright 2014 Kevin Yue. All rights reserved.
//

#import "ImprovedSprite.h"


@implementation ImprovedSprite

-(id) init{
    self = [super init];
    return self;
}

-(void) scaleToX:(CGFloat)newX Y:(CGFloat)newY{
    CGFloat currentWidth = [self boundingBox].size.width;
    CGFloat currentHeight = [self boundingBox].size.height;
    
    self.scaleX = newX / currentWidth;
    self.scaleY = newY / currentHeight;
}

-(void) changeOpacity:(CGFloat)newOpacity{
    self.opacity = newOpacity;
    for (ImprovedSprite* child in self.children){
        [child changeOpacity:newOpacity];
    }
}

@end

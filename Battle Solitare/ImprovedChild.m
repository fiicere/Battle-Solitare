//
//  ImprovedChild.m
//  Battle Solitare
//
//  Created by Kevin Yue on 3/13/14.
//  Copyright 2014 Kevin Yue. All rights reserved.
//

#import "ImprovedChild.h"
#import "ImprovedSprite.h"

ImprovedSprite * myParent;
BOOL debug = false;

@implementation ImprovedChild

-(id) initWithParent:(ImprovedSprite*) p andFile:(NSString*)filename{
    self = [super initWithFile:filename];
    debug = false;
    myParent = p;
    [self setPositionX:0 Y:0];
    return self;
}

-(void) scaleToX:(CGFloat)newX Y:(CGFloat)newY{

    CGFloat currentWidth = [self boundingBox].size.width;
    CGFloat currentHeight = [self boundingBox].size.height;
    
    self.scaleX = newX / currentWidth / myParent.scaleX;
    self.scaleY = newY / currentHeight / myParent.scaleY;
    
}



-(void) setPositionX:(CGFloat)x Y:(CGFloat)y{
    CGFloat newX = (x + myParent.boundingBox.size.width/2) / myParent.scaleX;
    CGFloat newY = (y + myParent.boundingBox.size.height/2) / myParent.scaleY;
    self.position = ccp(newX, newY);
}

-(void) debug{
    printf("\n");
    NSLog(@"Data for %@", self);
    NSLog(@"Parent = %@", myParent);
    NSLog(@"My Position = (%f, %f)", self.position.x, self.position.y);
    NSLog(@"Scale = (%f, %f)", self.scaleX, self.scaleY);
}

@end

//
//  TutorialLayer.m
//  Battle Solitare
//
//  Created by Kevin Yue on 8/22/14.
//  Copyright 2014 Kevin Yue. All rights reserved.
//

#import "FlipThroughLayer.h"
#import "cocos2d.h"
#import "Grid.h"
#import "FontsAndSpacings.h"

@implementation FlipThroughLayer

const float snapBackAcc = .9;
const float snapBackRate = 10;

UITouch * myTouch;
CGPoint startingTouchPoint;

CGPoint myPosition;
CGFloat xOffset;

-(id)init{
    self = [super init];
//    [self addDebugChild];
    [self setupPositionVariables];
    [self setupTouchVariables];
    [self schedule:@selector(updatePosition:)];
    [self setIsTouchEnabled:YES];
    return self;
}

-(void)setupPositionVariables{
    myPosition = ccp(0,0);
    xOffset = 0;
}

-(void)setupTouchVariables{
    myTouch = nil;
}

-(void)addDebugChild{
    [self addChild:[[BackgroundLayer alloc]init]];
}

-(void)updatePosition:(ccTime)dt{
    [self snapBack:dt];
    [self setPosition:ccp(myPosition.x + xOffset, myPosition.y)];
}

-(void)snapBack:(ccTime)dt{
    if(myTouch == nil){
        if(fabsf(xOffset) < snapBackRate) {xOffset = 0;}
        else {xOffset -= copysignf(fabsf(xOffset *snapBackAcc*dt)+snapBackRate, xOffset);}
    }
}

-(void)shiftLayerRight{
    myPosition.x += [[Grid getInstance] width];
    xOffset -= [[Grid getInstance] width];
}
-(void)shiftLayerLeft{
    myPosition.x -= [[Grid getInstance] width];
    xOffset += [[Grid getInstance] width];
}


//////////////////////////TOUCH HANDLING/////////////////////////

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    if(myTouch == nil){
        myTouch = touch;
        float x =[self convertTouchToNodeSpace:touch].x;
        if([self posModA:x B:[[Grid getInstance] width]] < [[FontsAndSpacings getInstance] border]){
            [self shiftLayerRight];
        }
        if([self posModA:x B:[[Grid getInstance] width]] > [[Grid getInstance] width]
           - [[FontsAndSpacings getInstance] border]){
            [self shiftLayerLeft];
        }
    }
    return YES;
}

-(float)posModA:(float)numerator B:(float)denominator{
    if(numerator < 0){return [self posModA:numerator + denominator B:denominator];}
    return (int)numerator % (int)denominator;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    if(touch == myTouch){
        
    }
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    if(touch == myTouch){myTouch = nil;}
}

-(void) registerWithTouchDispatcher
{
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:1 swallowsTouches:YES];
}

@end

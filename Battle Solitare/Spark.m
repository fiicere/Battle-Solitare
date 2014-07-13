//
//  Spark.m
//  Battle Solitare
//
//  Created by Kevin Yue on 7/13/14.
//  Copyright 2014 Kevin Yue. All rights reserved.
//

#import "Spark.h"

const float sparkSize = 2;
const float sparkFrict = 0.05;
const float sparkAccelPerMS = 0.001;
const int startVelMax = 2;

@implementation Spark

ccColor4F sparkColor;
BOOL sparkIsBlack;
float xVel;
float yVel;

-(id)initWithRandomVelAndColor:(BOOL)isBlack{
    self = [super init];
    
    sparkIsBlack = isBlack;
    
    //Set Spark Color
    sparkColor = ccc4f(1.0f, 1.0f, 1.0f, 1.0f);
    if(isBlack) {sparkColor = ccc4f(0.0f, 0.0f, 0.0f, 1.0f);}
    
    [self schedule:@selector(updatePosition:)];

    return self;
}

-(void)setRandomVelocities{
    xVel = (arc4random() % (2*startVelMax))-startVelMax;
    yVel = (arc4random() % (2*startVelMax))-startVelMax;
}


-(void)updatePosition:(ccTime)dt{
    [self accelerateSpark:dt];
    [self applyFriction:dt];
    [self moveSpark:dt];

}

-(void)accelerateSpark:(ccTime)dt{
    if(sparkIsBlack) {yVel += sparkAccelPerMS * dt;}
    else {yVel -= sparkAccelPerMS * dt;}
}

-(void)moveSpark:(ccTime)dt{
    self.position = ccpAdd(self.position, ccp(xVel, yVel));
}

-(void)applyFriction:(ccTime)dt{
    xVel *= (1-sparkFrict);
    yVel *= (1-sparkFrict);
}


@end

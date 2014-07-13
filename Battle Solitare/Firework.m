//
//  Firework.m
//  Battle Solitare
//
//  Created by Kevin Yue on 7/13/14.
//  Copyright 2014 Kevin Yue. All rights reserved.
//

#import "Firework.h"
#import "Spark.h"
#import "Grid.h"


const int numSparks = 100;

@implementation Firework

bool colorIsBlack;

-(id)initWithRandomLocAndColor:(BOOL)isBlack{
    self = [super init];
    
    colorIsBlack = isBlack;
    
    [self setRandomPosition];
    [self spawnSparks];
    
    [self schedule:@selector(checkSparkBoundaries:)];
    
    return self;
}

-(void)setRandomPosition{
    float x = arc4random() % (int) roundf([[Grid getInstance] width]);
    float y = arc4random() % (int) roundf([[Grid getInstance] height]);
    [self setPositionX:x Y:y];
}

-(void)spawnSparks{
    for (int i=0; i<numSparks; i++) {
        [self addChild:[[Spark alloc] initWithRandomVelAndColor:colorIsBlack]];
    }
}

-(void)checkSparkBoundaries:(ccTime)dt{
    [self checkSelfDelete];
    
    for(Spark *spark in [self children]){
        if(fabsf(spark.position.x)>[[Grid getInstance] width]){[self removeChild:spark];}
        if(fabsf(spark.position.y)>[[Grid getInstance] height]){[self removeChild:spark];}

    }
}

-(void)checkSelfDelete{
    if(self.children.count <=0){
        [[self parent] removeChild:self];
    }
}

@end

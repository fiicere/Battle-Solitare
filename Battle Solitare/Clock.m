//
//  Clock.m
//  Battle Solitare
//
//  Created by Kevin Yue on 8/13/14.
//  Copyright 2014 Kevin Yue. All rights reserved.
//

#import "Clock.h"

Clock * instance;
float clockTime;

@implementation Clock

-(id)init{
    self = [super init];
    [self resetClock];
    return self;
}

+(Clock*) getInstance{
    if(instance == nil) {
        instance = [[Clock alloc] init];
    }
    return instance;
}

-(void)incrementClock:(float)dt{
    clockTime+= dt;
}


-(void)resetClock{
    clockTime = 0;
}

-(float)getTime{
    return clockTime;
}

@end

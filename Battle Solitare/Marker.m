//
//  Marker.m
//  Battle Solitare
//
//  Created by Kevin Yue on 5/7/14.
//  Copyright 2014 Kevin Yue. All rights reserved.
//

#import "Marker.h"


@implementation Marker

const float speed = 500;
int i;
NSArray * path;
ccColor4F myColor;
CCMotionStreak * trail;


-(id)init{
    self = [super init];
    return self;
}

-(id)initWithPath:(NSArray*)markerPath andParent:(ImprovedSprite*)parent andColor:(ccColor4F)color{
    // Create object
    self = [super initWithParent:parent andFile:@"Black Pixel.tiff"];
    
    // Set Marker Properties
    path = markerPath;
    myColor = color;

    
    // Set it on its path
    i = 0;
    [self setPositionX:[[path objectAtIndex:i] position].x Y:[[path objectAtIndex:i] position].y];
    
    // Make it move
    self.opacity = 0.0f;
    
    //TODO: Make it draw (CCMotionStreak)
    
    // Schedule Timers
    [self schedule:@selector(move:)];
    
    //
    
    return self;
}

// NOTE: TAXICAB GEOMETRY ONLY
-(void)move:(ccTime) dt{
    float d = speed * dt;
    CGPoint destination = [[path objectAtIndex:i+1] position];
    
    float dx = min(fabsf(destination.x - self.position.x), d);
    float dy = min(fabsf(destination.y - self.position.y), d);
    
    float newX;
    float newY;
    if(destination.x < self.position.x){
        newX = self.position.x - dx;
    }
    else{
        newX = self.position.x + dx;
    }
    if(destination.y < self.position.y){
        newY = self.position.y - dy;
    }
    else{
        newY = self.position.y + dy;
    }
    
    self.position = ccp(newX, newY);
    }

-(float)distanceSqToPoint:(CGPoint)point{
    float dx = self.position.x-point.x;
    float dy = self.position.y-point.y;
    return dx*dx+dy*dy;
}



@end

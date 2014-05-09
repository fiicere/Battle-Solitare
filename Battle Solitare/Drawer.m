//
//  Draw.m
//  Battle Solitare
//
//  Created by Kevin Yue on 5/8/14.
//  Copyright 2014 Kevin Yue. All rights reserved.
//

#import "Drawer.h"

const float size = 15;
const float speed = 2;
BOOL colorIsBlack;

int numPoints;
NSArray * path;
CGPoint endPoint;

@implementation Drawer

-(id)init{
    self = [super init];
    numPoints = 1;
    colorIsBlack = true;
    return self;
}

-(id)initWithPath:(NSArray*)p andColorIsBlack:(BOOL)isBlack{
    self = [super init];
    
    // Record input
    path = p.copy;
    colorIsBlack = isBlack;
    
    // Set variables
    numPoints = 1;
    endPoint = [[path firstObject] position];
    
    NSLog(@"Drawer initialized with path of length %u and color %hhd (isblack)", p.count, isBlack);
    
    return self;
}


-(void)draw{
    // Call to still render everything
    [super draw];
    
    // Set the appropriate color and line width
    if(colorIsBlack){
        ccDrawColor4F(0.0f, 0.0f, 0.0f, 1.0f);
    }
    else{
        ccDrawColor4F(1.0f, 1.0f, 1.0f, 1.0f);
    }
    glLineWidth(size);
    
    // Update endpoint
    [self updateEndpoint];
    
    // Draw the line through the path
    for (int j=0; j<numPoints-1; j++){
        ccDrawLine([[path objectAtIndex:j] position], [[path objectAtIndex:j+1] position]);
    }
    // Draw to the endpoint
    ccDrawLine([[path objectAtIndex:numPoints-1] position], endPoint);
}

-(void)updateEndpoint{
    CGPoint dest = [[path objectAtIndex:numPoints] position];
    
    float dx = dest.x - endPoint.x;
    float dy = dest.y - endPoint.y;
    
    // new coords are current + distance * sign of distance
    float newX = endPoint.x + MIN(speed, fabsf(dx)) * ((dx>0) - (dx<0));
    float newY = endPoint.y + MIN(speed, fabsf(dy)) * ((dy>0) - (dy<0));
    
    endPoint = ccp(newX, newY);
    
    if(endPoint.x == dest.x && endPoint.y == dest.y && numPoints<path.count-1){
        numPoints += 1;
        NSLog(@"NumPoints = %u", numPoints);
    }
}



@end

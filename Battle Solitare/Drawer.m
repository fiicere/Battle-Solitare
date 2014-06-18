//
//  Draw.m
//  Battle Solitare
//
//  Created by Kevin Yue on 5/8/14.
//  Copyright 2014 Kevin Yue. All rights reserved.
//

#import "Drawer.h"

const float size = 30;
const float speed = 2;
ccColor4F pathColor;

int numPoints;
NSArray * path;
CGPoint endPoint;

@implementation Drawer

-(id)init{
    self = [super init];
    numPoints = 1;
    pathColor = ccc4f(1.0f, 1.0f, 1.0f, 1.0f);
    return self;
}

-(id)initWithPath:(NSArray*)p andColorIsBlack:(BOOL)isBlack{
    self = [super init];
    
    // Record input
    path = p.copy;
    
    pathColor = ccc4f(1.0f, 1.0f, 1.0f, 1.0f);
    if(isBlack){
        pathColor = ccc4f(0.0f, 0.0f, 0.0f, 1.0f);
    }
    
    
    // Set variables
    numPoints = 1;
    endPoint = [[path firstObject] position];
    
    NSLog(@"Drawer initialized with path of length %u and color %hhd (isblack)", p.count, isBlack);
    
    return self;
}


-(void)visit{
    // Call to still render everything
    [super visit];
    
    // Set the appropriate color and line width
    ccDrawColor4F(pathColor.r, pathColor.g, pathColor.b, pathColor.a);

    glLineWidth(size);
    
    // Update endpoint
    [self updateEndpoint];
    
    [self drawPath];
}

-(void) drawPath{
    [self drawPathLines];
    [self drawPathVertices];
}

-(void) drawPathLines{
    // Draw the line through the path
    for (int j=0; j<numPoints-1; j++){
        ccDrawLine([[path objectAtIndex:j] position], [[path objectAtIndex:j+1] position]);
    }
    // Draw to the endpoint
    ccDrawLine([[path objectAtIndex:numPoints-1] position], endPoint);
}

-(void) drawPathVertices{
    for(int j=0; j<numPoints; j++){
        ccDrawSolidRect(ccp([[path objectAtIndex:j] position].x - size/4,
                            [[path objectAtIndex:j] position].y - size/4),
                        ccp([[path objectAtIndex:j] position].x + size/4,
                            [[path objectAtIndex:j] position].y + size/4),
                        ccc4f(0.0f, 0.0f, 0.0f, 1.0f));
    }
    
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
    }
}



@end

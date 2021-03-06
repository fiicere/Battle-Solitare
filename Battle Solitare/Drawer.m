//
//  Draw.m
//  Battle Solitare
//
//  Created by Kevin Yue on 5/8/14.
//  Copyright 2014 Kevin Yue. All rights reserved.
//

#import "Drawer.h"
const float size = 10;
const float speed = 5;

@implementation Drawer{

    ccColor4F pathColor;
    
    bool isFinishedDrawing;

    int numPoints;
    NSArray * path;
    CGPoint endPoint;
    
}


-(id)initWithPath:(NSArray*)p andColorIsBlack:(BOOL)isBlack{
    self = [super init];
    
    // Record input
    path = p.copy;
    
    pathColor = ccc4f(1.0f, 1.0f, 1.0f, 1.0f);
    if(isBlack){pathColor = ccc4f(0.0f, 0.0f, 0.0f, 1.0f);}
    
    isFinishedDrawing = false;
    
    
    // Set variables
    numPoints = 1;
    endPoint = [[path firstObject] position];
        
    [self schedule:@selector(updateEndpoint:)];
    
    return self;
}

-(void)updateEndpoint:(ccTime)dt{
    [self drawDot:endPoint radius:size color:pathColor];

    CGPoint dest = [[path objectAtIndex:numPoints] position];
    
    float dx = dest.x - endPoint.x;
    float dy = dest.y - endPoint.y;
    
    // new coords are current + distance * sign of distance
    float newX = endPoint.x + MIN(speed, fabsf(dx)) * ((dx>0) - (dx<0));
    float newY = endPoint.y + MIN(speed, fabsf(dy)) * ((dy>0) - (dy<0));
    
    endPoint = ccp(newX, newY);
    
    if(endPoint.x == dest.x && endPoint.y == dest.y){

        if(numPoints < path.count-1){
            numPoints+=1;
        }
        else{
            isFinishedDrawing = true;
            [self unschedule:@selector(updateEndpoint:)];
        }
    }
}

+(float)getMarkerWidth{
    return size;
}

-(bool)isFinishedDrawing{
    return isFinishedDrawing;
}


@end

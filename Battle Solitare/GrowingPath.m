//
//  Path.m
//  Battle Solitare
//
//  Created by Kevin Yue on 6/17/14.
//  Copyright (c) 2014 Kevin Yue. All rights reserved.
//

#import "GrowingPath.h"
#import "Tile.h"

ccColor4F pathColor;
NSMutableArray * fullPath;

NSMutableArray * currentPath;
CGPoint endpoint;


const float endpointSpeed = 1;
const float pathWidth = 50;

@implementation GrowingPath


-(id)initWithNodes:(NSArray*) path andColor:(ccColor4F)color{
    self = [super init];
    pathColor = color;
    
    fullPath = [NSMutableArray arrayWithArray:path];
    currentPath = [NSMutableArray arrayWithObject:path.firstObject];
    
    [self schedule:@selector(drawPath:)];
    [self schedule:@selector(moveEndpointDownPath:)];
    
    
    return self;
}

-(void)moveEndpointDownPath:(ccTime)dt{
    CGPoint destination = [[fullPath objectAtIndex:currentPath.count] position];
    
    endpoint.x = copysignf(dt*endpointSpeed, (destination.x - endpoint.x));
    endpoint.y = copysignf(dt*endpointSpeed, (destination.y - endpoint.y));
    
    if(abs(endpoint.x - destination.x) < dt*endpointSpeed) {endpoint.x = destination.x;}
    if(abs(endpoint.y - destination.y) < dt*endpointSpeed) {endpoint.y = destination.y;}
    
    // Update position
    if(endpoint.x == destination.x && endpoint.y == destination.y) {[self incrementCurrentPath];}
}

-(void)incrementCurrentPath{

    if(currentPath.count > fullPath.count - 1){
        [self unschedule:@selector(moveEndpointDownPath:)];
    }
    else{
        [currentPath addObject: [fullPath objectAtIndex:currentPath.count]];   
    }
}

-(void)drawPath:(ccTime)dt{
    [self drawPathSegments];
    [self drawPathVertices];
}

-(void) drawPathSegments{
    NSLog(@"Path length = %u", currentPath.count);
    for (int i = 0; i < currentPath.count - 1; i++){
        
        [self drawSegmentFrom: [[currentPath objectAtIndex:i] position]
                           to: [[currentPath objectAtIndex:i+1] position]
                       radius:pathWidth
                        color:pathColor];
    }
    [self drawSegmentFrom: [[currentPath lastObject] position]
                       to: endpoint
                   radius:pathWidth
                    color:pathColor];
}

-(void) drawPathVertices{
    for (CCNode * node in currentPath){
        [self drawDot:[node position] radius:pathWidth color:pathColor];
    }
    [self drawDot:endpoint radius:pathWidth color:pathColor];
}


@end

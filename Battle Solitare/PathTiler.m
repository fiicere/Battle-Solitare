//
//  PathTiler.m
//  Battle Solitare
//
//  Created by Kevin Yue on 6/18/14.
//  Copyright 2014 Kevin Yue. All rights reserved.
//

#import "PathTiler.h"

const float pathSize = 10;
const float pathSpeed = 5;
ccColor4F pathColor;

NSArray * path;
int verticesCompleted;
CGPoint endpoint;

@implementation PathTiler


-(id)initWithPath: (NSArray*)p andColor:(ccColor4F)color{
    self = [super init];
    
    pathColor = color;
    path = [NSArray arrayWithArray:p];
    
    verticesCompleted = 1;
    endpoint = [[path firstObject] position];
    
    return self;
}



@end

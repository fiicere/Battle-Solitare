//
//  Draw.m
//  Battle Solitare
//
//  Created by Kevin Yue on 5/8/14.
//  Copyright 2014 Kevin Yue. All rights reserved.
//

#import "Draw.h"

const float size = 15;
int index;
NSArray * path;
BOOL colorIsBlack;

@implementation Draw

-(id)init{
    self = [super init];
    index = 0;
    colorIsBlack = true;
    return self;
}

-(id)initWithPath:(NSArray*)p andColor:(BOOL)isBlack{
    self = [super init];
    path = p;
    colorIsBlack = isBlack;
    index = 0;
    
    return self;
}


-(void)draw{
    [super draw];
    
    if(colorIsBlack){
        ccDrawColor4F(0.0f, 0.0f, 0.0f, 1.0f);
    }
    else{
        ccDrawColor4F(1.0f, 1.0f, 1.0f, 1.0f);
    }
    
    glLineWidth(size);
    
    CGPoint a = ccp(0,300);
    CGPoint b = ccp(i,300);
    ccDrawLine(a,b);
    
    i+=1;
}
@end

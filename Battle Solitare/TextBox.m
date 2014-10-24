//
//  TextBox.m
//  Battle Solitare
//
//  Created by Kevin Yue on 10/24/14.
//  Copyright 2014 Kevin Yue. All rights reserved.
//

#import "TextBox.h"
#import "FontsAndSpacings.h"
#import "Grid.h"

@implementation TextBox

CCLabelTTF * label;

-(id) init{
    self = [super init];
    
    return self;
}

-(id)initFromA:(CGPoint)pointA ToB:(CGPoint)pointB{
    self = [super init];
    [self setupTextBoxDimensions:pointA to:pointB];
    return self;
}

-(void)setupTextBoxDimensions:(CGPoint)a to:(CGPoint)b{
    label = [CCLabelTTF new];
    
    label.dimensions = CGSizeMake(fabsf(a.x - b.x), fabsf(a.y - b.y));
    label.position = ccp((a.x+b.x)/2, (a.y+b.y)/2);

    label.horizontalAlignment = NSTextAlignmentLeft;
    
    label.fontName = [[FontsAndSpacings getInstance] font];
    label.fontSize = [[FontsAndSpacings getInstance] hudFontSize];
    
    [self addChild:label];
}

-(void)setText:(NSString*)text{
    [label setString:text];
}

@end

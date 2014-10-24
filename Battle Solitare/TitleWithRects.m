//
//  TitleWithRects.m
//  Battle Solitare
//
//  Created by Kevin Yue on 10/23/14.
//  Copyright 2014 Kevin Yue. All rights reserved.
//

#import "TitleWithRects.h"
#import "FontsAndSpacings.h"
#import "Grid.h"

@implementation TitleWithRects

NSString * title;


-(id)initWithTitle:(NSString*)layerTitle{
    self = [super init];
    title = layerTitle;
    [self makeTitle];
    return self;
}

-(void) makeTitle{
    CCLabelTTF * titleLabel = [CCLabelTTF labelWithString:title
                                                    fontName:[[FontsAndSpacings getInstance] font]
                                                    fontSize:[[FontsAndSpacings getInstance] menuFontSize]];
    
    titleLabel.color = ccWHITE;
    
    titleLabel.position = ccp([[Grid getInstance] width]/2, [[Grid getInstance] topCardLoc].y);
    
    [self addChild:titleLabel];
}

@end

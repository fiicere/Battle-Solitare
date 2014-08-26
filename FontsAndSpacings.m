//
//  Font.m
//  Battle Solitare
//
//  Created by Kevin Yue on 8/21/14.
//  Copyright (c) 2014 Kevin Yue. All rights reserved.
//

#import "FontsAndSpacings.h"
#import "cocos2d.h"

static FontsAndSpacings* instance;
const float menuFontScale = 12;
const float hudFontScale = 30;
const float scoreOffsetScale = 6;
const float borderRatio = 4;

NSString * const defaultFont = @"TrajanPro-Regular";

@implementation FontsAndSpacings
+(FontsAndSpacings*)getInstance{
    if(instance == nil) {instance = [[self alloc] init];}
    return instance;
}

-(id)init{
    self = [super init];
    
    [self setupVariables];
    
    return self;
}

-(void)setupVariables{
    _menuFontSize = (int) ([CCDirector sharedDirector].winSize.width/ menuFontScale);
    _hudFontSize = (int) ([CCDirector sharedDirector].winSize.width / hudFontScale);
    _textOffset = (int) ([CCDirector sharedDirector].winSize.width / scoreOffsetScale);
    
    _border = ([CCDirector sharedDirector].winSize.width / borderRatio);

    _font = defaultFont;
}

@end
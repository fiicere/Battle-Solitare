//
//  Font.m
//  Battle Solitare
//
//  Created by Kevin Yue on 8/21/14.
//  Copyright (c) 2014 Kevin Yue. All rights reserved.
//

#import "Font.h"
#import "cocos2d.h"

static Font* instance;
const float menuFontScale = 15;
const float hudFontScale = 40;
const float scoreOffsetScale = 6;
NSString * const defaultFont = @"TrajanPro-Regular";

@implementation Font
+(Font*)getInstance{
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
    _font = defaultFont;
}

@end
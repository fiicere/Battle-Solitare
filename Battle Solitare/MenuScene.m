//
//  MenuScene.m
//  Battle Solitare
//
//  Created by Kevin Yue on 3/27/14.
//  Copyright 2014 Kevin Yue. All rights reserved.
//

#import "MenuScene.h"
#import "GameScene.h"

CCLayer * ml;

@implementation MenuScene

-(id) init {
    self = [super init];
    
    ml = [CCLayer node];
    
    [self SetUpMenu:ml];
    
    [self addChild:ml];
    return self;
}

-(void) SetUpMenu:(CCLayer*) menuLayer {
    CCMenu *menu = [CCMenu menuWithItems:nil];
    
    // Game Mode Labels
    CCLabelTTF * startGame = [CCLabelTTF labelWithString:@"Start Game" fontName:@"Arial" fontSize:32];
    CCLabelTTF * instructions = [CCLabelTTF labelWithString:@"How to Play" fontName:@"Arial" fontSize:32];
    CCLabelTTF * options = [CCLabelTTF labelWithString:@"Options" fontName:@"Arial" fontSize:32];

    
    CCMenuItem *gameButton = [CCMenuItemLabel itemWithLabel:startGame target:self selector:@selector(newGame)];
    CCMenuItem *rulesButton = [CCMenuItemLabel itemWithLabel:instructions target:self selector:@selector(insPage)];
    CCMenuItem *optionsButton = [CCMenuItemLabel itemWithLabel:instructions target:self selector:@selector(opPage)];

    
    
    
    [menu addChild:gameButton];
    [menu addChild:rulesButton];
    [menu addChild:options];

    
    [menu alignItemsVerticallyWithPadding:32.0f];
    [menuLayer addChild:menu];
    
    
    // Timer
    [self schedule:@selector(checkStart:)];
}

-(void)newGame{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[GameScene scene]]];

}

-(void)insPage{
    
}

-(void)opPage{
    
}

@end

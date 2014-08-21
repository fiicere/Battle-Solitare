//
//  MenuScene.m
//  Battle Solitare
//
//  Created by Kevin Yue on 3/27/14.
//  Copyright 2014 Kevin Yue. All rights reserved.
//

#import "MenuScene.h"
#import "DuoGameScene.h"
#import "SoloGameScene.h"
#import "BackgroundLayer.h"
#import "TileManager.h"

BackgroundLayer * ml;

@implementation MenuScene

+(CCScene *) scene{
    // 'scene' is an autorelease object.
	MenuScene *scene = [MenuScene node];
	
    ml = [[BackgroundLayer alloc] init];
    
	// 'layer' is an autorelease object.
	[scene SetUpMenu:ml];
    
	// add layer as a child to scene
	[scene addChild:ml];
    
	// return the scene
	return scene;
    
}

-(void) SetUpMenu:(CCLayer*) menuLayer {
    CCMenu *menu = [CCMenu menuWithItems:nil];
    
    // Game Mode Labels
    CCLabelTTF * startSoloGame = [CCLabelTTF labelWithString:@"Solo Game" fontName:@"TrajanPro-Regular" fontSize:32];
    CCLabelTTF * startDuoGame = [CCLabelTTF labelWithString:@"Multiplayer Game" fontName:@"TrajanPro-Regular" fontSize:32];

    CCLabelTTF * instructions = [CCLabelTTF labelWithString:@"How to Play" fontName:@"TrajanPro-Regular" fontSize:32];
    CCLabelTTF * options = [CCLabelTTF labelWithString:@"Options" fontName:@"TrajanPro-Regular" fontSize:32];
    
    startSoloGame.color = ccWHITE;
    instructions.color = ccWHITE;
    options.color = ccWHITE;

    
    CCMenuItem *soloGameButton = [CCMenuItemLabel itemWithLabel:startSoloGame target:self selector:@selector(newSoloGame)];
    CCMenuItem *duoGameButton = [CCMenuItemLabel itemWithLabel:startDuoGame target:self selector:@selector(newDuoGame)];
    CCMenuItem *rulesButton = [CCMenuItemLabel itemWithLabel:instructions target:self selector:@selector(insPage)];
    CCMenuItem *optionsButton = [CCMenuItemLabel itemWithLabel:options target:self selector:@selector(opPage)];

    
    
    
    [menu addChild:soloGameButton];
    [menu addChild:duoGameButton];
    [menu addChild:rulesButton];
    [menu addChild:optionsButton];

    [menu alignItemsVerticallyWithPadding:32.0f];
    [menuLayer addChild:menu];
}

-(void)newSoloGame{
    [[TileManager getInstance] newGame];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[SoloGameScene scene]]];
}

-(void)newDuoGame{
    [[TileManager getInstance] newGame];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[DuoGameScene scene]]];
}

-(void)insPage{
    
}

-(void)opPage{
    
}

@end

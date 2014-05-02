//
//  MenuScene.m
//  Battle Solitare
//
//  Created by Kevin Yue on 3/27/14.
//  Copyright 2014 Kevin Yue. All rights reserved.
//

#import "MenuScene.h"
#import "GameScene.h"
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
    CCLabelTTF * startGame = [CCLabelTTF labelWithString:@"Start Game" fontName:@"TrajanPro-Regular" fontSize:32];
    CCLabelTTF * instructions = [CCLabelTTF labelWithString:@"How to Play" fontName:@"TrajanPro-Regular" fontSize:32];
    CCLabelTTF * options = [CCLabelTTF labelWithString:@"Options" fontName:@"TrajanPro-Regular" fontSize:32];
    
    startGame.color = ccWHITE;
    instructions.color = ccWHITE;
    options.color = ccWHITE;

    
    CCMenuItem *gameButton = [CCMenuItemLabel itemWithLabel:startGame target:self selector:@selector(newGame)];
    CCMenuItem *rulesButton = [CCMenuItemLabel itemWithLabel:instructions target:self selector:@selector(insPage)];
    CCMenuItem *optionsButton = [CCMenuItemLabel itemWithLabel:options target:self selector:@selector(opPage)];

    
    
    
    [menu addChild:gameButton];
    [menu addChild:rulesButton];
    [menu addChild:optionsButton];

    [menu alignItemsVerticallyWithPadding:32.0f];
    [menuLayer addChild:menu];
}

-(void)newGame{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[GameScene scene]]];
}

-(void)insPage{
    
}

-(void)opPage{
    
}

@end

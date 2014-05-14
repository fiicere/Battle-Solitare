//
//  GameScene.m
//  Battle Solitare
//
//  Created by Kevin Yue on 3/19/14.
//  Copyright 2014 Kevin Yue. All rights reserved.
//

#import "DuoGameScene.h"
#import "DuoGameLayer.h"
#import "ScoreScreen.h"

@implementation DuoGameScene

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	DuoGameScene *scene = [DuoGameScene node];
	
	// 'layer' is an autorelease object.
	DuoGameLayer *layer = [DuoGameLayer node];
    
	// add layer as a child to scene
	[scene addChild: layer z:0];

	// return the scene
	return scene;
}


@end

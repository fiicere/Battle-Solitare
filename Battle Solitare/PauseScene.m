//
//  PauseScene.m
//  Battle Solitare
//
//  Created by Kevin Yue on 5/2/14.
//  Copyright 2014 Kevin Yue. All rights reserved.
//

#import "PauseScene.h"
#import "PauseLayer.h"


@implementation PauseScene

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) sceneWithOrientation:(BOOL)upright andIsSoloMode:(BOOL)mode
{
	// 'scene' is an autorelease object.
	PauseScene *scene = [PauseScene node];
	
	// 'layer' is an autorelease object.
	PauseLayer *pl = [[PauseLayer alloc] initWithOrientation:upright isSoloMode:mode];
    
	// add layer as a child to scene
	[scene addChild: pl z:0];
    
	// return the scene
	return scene;
}

@end

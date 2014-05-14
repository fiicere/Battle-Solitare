//
//  SoloGameScene.m
//  Battle Solitare
//
//  Created by Kevin Yue on 5/14/14.
//  Copyright 2014 Kevin Yue. All rights reserved.
//

#import "SoloGameScene.h"
#import "SoloGameLayer.h"


@implementation SoloGameScene

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	SoloGameScene *scene = [SoloGameScene node];
	
	// 'layer' is an autorelease object.
	SoloGameLayer *layer = [SoloGameLayer node];
    
	// add layer as a child to scene
	[scene addChild: layer z:0];
    
	// return the scene
	return scene;
}

@end

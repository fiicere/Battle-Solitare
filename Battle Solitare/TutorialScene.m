//
//  TutorialScene.m
//  Battle Solitare
//
//  Created by Kevin Yue on 8/22/14.
//  Copyright 2014 Kevin Yue. All rights reserved.
//

#import "cocos2d.h"
#import "TutorialScene.h"
#import "FlipThroughLayer.h"
#import "Grid.h"

@implementation TutorialScene

+(CCScene *) scene{
    // 'scene' is an autorelease object.
	TutorialScene *scene = [[TutorialScene alloc] init];
    
    [scene addChild:[[FlipThroughLayer alloc] init]];
    
	// return the scene
	return scene;
}

@end

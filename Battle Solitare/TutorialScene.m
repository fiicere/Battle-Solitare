//
//  TutorialScene.m
//  Battle Solitare
//
//  Created by Kevin Yue on 8/22/14.
//  Copyright 2014 Kevin Yue. All rights reserved.
//

#import "TutorialScene.h"
#import "TutorialLayer.h"

@implementation TutorialScene


+(CCScene *) scene{
    // 'scene' is an autorelease object.
	TutorialScene *scene = [TutorialScene node];
	
	// add layer as a child to scene
	[scene addChild: [TutorialLayer node]];
    
	// return the scene
	return scene;
}

@end

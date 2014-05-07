//
//  ScoreScreen.m
//  Battle Solitare
//
//  Created by Kevin Yue on 3/19/14.
//  Copyright 2014 Kevin Yue. All rights reserved.
//

#import "ScoreScreen.h"
#import "Score.h"
#import "IntroScene.h"
#import "GameScene.h"
#import "ScoreLayer.h"

@implementation ScoreScreen

ScoreLayer * cardLayer;

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	cardLayer = [[ScoreLayer alloc] init];
    
	// add layer as a child to scene
	[scene addChild: cardLayer];
    
	// return the scene
	return scene;
}


/////////////////////////TOUCH EVENTS//////////////////////////

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [[CCDirector sharedDirector] replaceScene:[GameScene scene]];}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{

}

-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{

}


@end

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
#import "BackgroundLayer.h"

@implementation ScoreScreen

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	BackgroundLayer * layer = [[BackgroundLayer alloc] init];
	
	// add layer as a child to scene
	[scene addChild: layer];
    
	// return the scene
	return scene;
}

//
-(id) init
{
	self = [super init];
    [self displayWinningText];
	return self;
}


-(void)displayWinningText{
    NSString * message;
    if([[Score getInstance] whiteScore] > [[Score getInstance] blackScore]){
        message = [NSString stringWithFormat:@"White Wins! \n%d to %d",
                              [[Score getInstance] whiteScore],
                              [[Score getInstance] blackScore]];
    }
    else if([[Score getInstance] blackScore] > [[Score getInstance] whiteScore]){
        message = [NSString stringWithFormat:@"Black Wins! \n%d to %d",
                   [[Score getInstance] blackScore],
                   [[Score getInstance] whiteScore]];
    }
    else{
        message = [NSString stringWithFormat:@"Draw! \n%d to %d",
                   [[Score getInstance] blackScore],
                   [[Score getInstance] whiteScore]];
    }
    
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    CCLabelTTF * label = [CCLabelTTF labelWithString:message fontName:@"TrajanPro-Regular" fontSize:32];
    label.color = ccc3(255,255,255);
    label.position = ccp(winSize.width/2, winSize.height/2);
    
    [self addChild:label];
}


-(void)onEnter{
    [[CCTouchDispatcher sharedDispatcher] addStandardDelegate:self priority:0];
    [super onEnter];
}
-(void)onExit{
    [[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
    [super onExit];
}


/////////////////////////TOUCH EVENTS//////////////////////////

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [[CCDirector sharedDirector] replaceScene:[GameScene scene]];}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{

}

-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{

}


@end

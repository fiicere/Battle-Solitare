//
//  PauseLayer.m
//  Battle Solitare
//
//  Created by Kevin Yue on 5/2/14.
//  Copyright 2014 Kevin Yue. All rights reserved.
//

#import "PauseLayer.h"
#import "DuoGameScene.h"
#import "MenuScene.h"
#import "TileManager.h"

@implementation PauseLayer

BOOL rightSideUp;

-(id)init{
    self = [super init];
    [self createPauseMenu];
    return self;
}

-(id)initWithOrientation:(BOOL)isRightSideUp{
    rightSideUp = isRightSideUp;
    return [self init];
}

-(void) createPauseMenu{
    CCMenu *menu = [CCMenu menuWithItems:nil];
    
    // Game Mode Labels
    CCLabelTTF * resume = [CCLabelTTF labelWithString:@"Resume" fontName:@"TrajanPro-Regular" fontSize:32];
    CCLabelTTF * newGame = [CCLabelTTF labelWithString:@"Start New Game" fontName:@"TrajanPro-Regular" fontSize:32];
    CCLabelTTF * mainMenu = [CCLabelTTF labelWithString:@"Quit to Menu" fontName:@"TrajanPro-Regular" fontSize:32];
    
    // Label Colors
    resume.color = ccWHITE;
    newGame.color = ccWHITE;
    mainMenu.color = ccWHITE;
    
    // Buttons for labels
    CCMenuItem *resumeButton = [CCMenuItemLabel itemWithLabel:resume target:self selector:@selector(resumeGame)];
    CCMenuItem *newGameButton = [CCMenuItemLabel itemWithLabel:newGame target:self selector:@selector(startNewGame)];
    CCMenuItem *mainMenuButton = [CCMenuItemLabel itemWithLabel:mainMenu target:self selector:@selector(backToMenu)];
    
    // Label Orientation
    if(! rightSideUp){
        resumeButton.rotation = 180;
        newGameButton.rotation = 180;
        mainMenuButton.rotation = 180;
        
        // Add children
        [menu addChild:mainMenuButton];
        [menu addChild:newGameButton];
        [menu addChild:resumeButton];
    }
    else{
        // Add children
        [menu addChild:resumeButton];
        [menu addChild:newGameButton];
        [menu addChild:mainMenuButton];
    }

    [menu alignItemsVerticallyWithPadding:32.0f];
    
    [self addChild:menu];
}

-(void)resumeGame{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[DuoGameScene scene]]];

}
-(void)startNewGame{
    [[TileManager getInstance] newGame];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[DuoGameScene scene]]];

}
-(void)backToMenu{
    [[TileManager getInstance] newGame];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[MenuScene scene]]];
}

@end

//
//  PauseLayer.m
//  Battle Solitare
//
//  Created by Kevin Yue on 5/2/14.
//  Copyright 2014 Kevin Yue. All rights reserved.
//

#import "PauseLayer.h"
#import "DuoGameScene.h"
#import "SoloGameScene.h"
#import "MenuScene.h"
#import "TileManager.h"

#import "FontsAndSpacings.h"

@implementation PauseLayer

BOOL rightSideUp;
BOOL soloMode;

-(id)init{
    self = [super init];
    [self createPauseMenu];
    return self;
}

-(id)initWithOrientation:(BOOL)isRightSideUp isSoloMode:(BOOL)isSoloMode{
    rightSideUp = isRightSideUp;
    soloMode = isSoloMode;
    return [self init];
}

-(void) createPauseMenu{
    CCMenu *menu = [CCMenu menuWithItems:nil];
    
    // Game Mode Labels
    CCLabelTTF * resume = [CCLabelTTF labelWithString:@"Resume"
                                             fontName:[[FontsAndSpacings getInstance] font]
                                             fontSize:[[FontsAndSpacings getInstance] menuFontSize]];
    CCLabelTTF * newGame = [CCLabelTTF labelWithString:@"Start New Game"
                                              fontName:[[FontsAndSpacings getInstance] font]
                                              fontSize:[[FontsAndSpacings getInstance] menuFontSize]];
    CCLabelTTF * mainMenu = [CCLabelTTF labelWithString:@"Quit to Menu"
                                               fontName:[[FontsAndSpacings getInstance] font]
                                               fontSize:[[FontsAndSpacings getInstance] menuFontSize]];
    
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
    if(soloMode){
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[SoloGameScene scene]]];
    }
    else{
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[DuoGameScene scene]]];
    }

}
-(void)startNewGame{
    if(soloMode) {
        [[TileManager getInstance] newGame];
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[SoloGameScene scene]]];
    }
    else{
        [[TileManager getInstance] newGame];
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[DuoGameScene scene]]];
    }

}
-(void)backToMenu{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[MenuScene scene]]];
}

@end

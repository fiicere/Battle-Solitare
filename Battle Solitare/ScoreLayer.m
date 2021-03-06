//
//  ScoreLayer.m
//  Battle Solitare
//
//  Created by Kevin Yue on 5/7/14.
//  Copyright 2014 Kevin Yue. All rights reserved.
//

#import "ScoreLayer.h"
#import "TileManager.h"
#import "Tile.h"
#import "MenuScene.h"
#import "ImprovedChild.h"
#import "Drawer.h"
#import "Score.h"
#import "Grid.h"

#import "FontsAndSpacings.h"

@implementation ScoreLayer

NSMutableArray * dropList;
NSMutableArray * notDropList;

const float shrinkTime = 1;
//const float fireworksPerSecond = .5;
const float flashesPerSecond = 2;

float xShrinkRate;
float yShrinkRate;

Drawer * whiteDrawer;
Drawer * blackDrawer;

-(id) init{
    self = [super init];
    
    [self addAllCards];
    [self addScore];
    [self setShrinkRates];
    [self resetArrays];
    
    
    [self schedule:@selector(dropCard:) interval:0.075];
    [self schedule:@selector(shrinkCards:)];
    [self schedule:@selector(flashScoreBoxes:) interval:1/flashesPerSecond];
    
    [self drawPaths];
    
    return self;
}

-(void)setShrinkRates{
    xShrinkRate = [[Grid getInstance] sqWidth] / shrinkTime;
    yShrinkRate = [[Grid getInstance] sqHeight] / shrinkTime;
}

-(void)resetArrays{
    dropList = [NSMutableArray new];
    notDropList = [NSMutableArray new];
}

-(void)drawPaths{
    if([[Score getInstance] blackScore] > [[Score getInstance] whiteScore]){
        whiteDrawer = [[Drawer alloc] initWithPath:[[Score getInstance] whitePath] andColorIsBlack:false];
        [self addChild:whiteDrawer];
        
        blackDrawer = [[Drawer alloc] initWithPath:[[Score getInstance] blackPath] andColorIsBlack:true];
        [self addChild:blackDrawer];
    }
    else{
        blackDrawer = [[Drawer alloc] initWithPath:[[Score getInstance] blackPath] andColorIsBlack:true];
        [self addChild:blackDrawer];
        
        whiteDrawer = [[Drawer alloc] initWithPath:[[Score getInstance] whitePath] andColorIsBlack:false];
        [self addChild:whiteDrawer];
    }
}

-(void) dropCard:(ccTime)dt{
    for(Tile* t in [[TileManager getInstance] getPlacedTiles]){
        if([notDropList containsObject:t]){
            continue;
        }
        else if([dropList containsObject:t]){
            continue;
        }
        else if([[[Score getInstance] whitePath] containsObject:t]){
            [notDropList addObject:t];
            return;
        }
        else if([[[Score getInstance] blackPath] containsObject:t]){
            [notDropList addObject:t];
            return;
        }
        else{
            [dropList addObject:t];
            return;
        }
    }
    [self schedule:@selector(shrinkSuitsAndNums:)];
    [self unschedule:@selector(dropCard:)];

}

-(void)shrinkCards:(ccTime)dt{
    for (Tile*t in dropList){
        if(t.scaleX <=0.000001 && t.scaleY <=0.000001){
            continue;
        }
        else{
            t.scaleX = t.scaleX / (1+dt*2);
            t.scaleY = t.scaleY / (1+dt*2);
        }
    }
}

-(void)shrinkSuitsAndNums:(ccTime)dt{
    for (Tile*t in notDropList){
        for(ImprovedChild * child in t.children){
            child.scaleX = child.scaleX/(1+dt*2);
            child.scaleY = child.scaleY/(1+dt*2);
        }
    }
}

-(void)fadeOutPathCards:(ccTime)dt{
    for (Tile*t in notDropList){
        t.opacity = t.opacity / (1+dt);
        for(ImprovedChild * child in t.children){
            child.opacity = child.opacity/(1+dt*2);
        }
    }
}

-(void) flashScoreBoxes:(ccTime)dt{
    if(![whiteDrawer isFinishedDrawing] || ![blackDrawer isFinishedDrawing]){
        return;
    }
    
    if([[Score getInstance] whiteScore] > [[Score getInstance] blackScore]) {[self flashWhiteBox];}
    else if([[Score getInstance] whiteScore] < [[Score getInstance] blackScore]) {[self flashBlackBox];}
    else{
        [self flashBlackBox];
        [self flashWhiteBox];
    }

}

-(void)flashWhiteBox{
    [self botRect].opacity = 255 - [self botRect].opacity;
}
-(void)flashBlackBox{
    [self topRect].opacity = 255 - [self topRect].opacity;

}

//-(void) fireworks{
//    [self schedule:@selector(runFireworks:)];
//}
//
//-(void) runFireworks:(ccTime)dt{
//    if(arc4random()%1000 < dt * fireworksPerSecond){
//        [self addChild:[[Firework alloc] initWithRandomLocAndColor:true]];
//    }
//}


/////////////////////////INIT METHODS//////////////////////////
-(void)onEnter{
    [[CCTouchDispatcher sharedDispatcher] addStandardDelegate:self priority:0];
    [super onEnter];
}
-(void)onExit{
    [[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
    [super onExit];
}


-(void) addAllCards{
    for (Tile * t in [[TileManager getInstance] getPlacedTiles]){
        t.opacity = 150;
        [self addChild:t];
    }
}

-(void) addScore{
    NSString * blackScoreText = [NSString stringWithFormat:@"Score = %u", [[Score getInstance] blackScore]];
    NSString * whiteScoreText = [NSString stringWithFormat:@"Score = %u", [[Score getInstance] whiteScore]];
    
    CCLabelTTF * botScoreLabel = [CCLabelTTF labelWithString:whiteScoreText
                                                    fontName:[[FontsAndSpacings getInstance] font]
                                                    fontSize:[[FontsAndSpacings getInstance] menuFontSize]];
    CCLabelTTF * topScoreLabel = [CCLabelTTF labelWithString:blackScoreText
                                                    fontName:[[FontsAndSpacings getInstance] font]
                                                    fontSize:[[FontsAndSpacings getInstance] menuFontSize]];
    
    topScoreLabel.rotation = 180;
    
    topScoreLabel.color = ccWHITE;
    botScoreLabel.color = ccBLACK;
    
    botScoreLabel.position = ccp([[Grid getInstance] width]/2, [[Grid getInstance] botCardLoc].y);
    topScoreLabel.position = ccp([[Grid getInstance] width]/2, [[Grid getInstance] topCardLoc].y);
    
    [self addChild:topScoreLabel];
    [self addChild:botScoreLabel];
}

/////////////////////////TOUCH EVENTS//////////////////////////

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self removeAllChildren];
    [[CCDirector sharedDirector] replaceScene:[MenuScene scene]];}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
}

-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
}

@end

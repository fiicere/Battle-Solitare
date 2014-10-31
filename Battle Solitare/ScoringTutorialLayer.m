//
//  ScoringTutorialLayer.m
//  Battle Solitare
//
//  Created by Kevin Yue on 10/23/14.
//  Copyright 2014 Kevin Yue. All rights reserved.
//

#import "ScoringTutorialLayer.h"
#import "TextBox.h"
#import "FontsAndSpacings.h"
#import "Grid.h"


@implementation ScoringTutorialLayer

-(id)init{
    self = [super initWithTitle:@"Scoring"];
    [self addScoringExplanation];
    return self;
}

-(void)addScoringExplanation{
    TextBox * tb = [[TextBox alloc] initFromA:ccp([[FontsAndSpacings getInstance] border],
                                                  [[FontsAndSpacings getInstance] playerRectSize]*2)
                                          ToB:ccp([[Grid getInstance] width]-
                                                  [[FontsAndSpacings getInstance] border],
                                                  [[Grid getInstance] height]-
                                                  [[FontsAndSpacings getInstance] playerRectSize])];
    
    [tb setText:@"The goal of Taire is to try to have the longest path of cards in your color (face color) by the end of the game. To be valid, a path: \n\t1) Must be composed of adjacent cards (no diagonals) \n\t2) May NOT include any card twice \n\t3) May include wild cards \n\t4) May NOT include block cards.\n\t5) May NOT include any of your opponent's cards"];
    [self addChild:tb];
}

@end

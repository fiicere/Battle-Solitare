//
//  HintsTutorialLayer.m
//  Battle Solitare
//
//  Created by Kevin Yue on 10/24/14.
//  Copyright 2014 Kevin Yue. All rights reserved.
//

#import "HintsTutorialLayer.h"
#import "TextBox.h"
#import "FontsAndSpacings.h"
#import "Grid.h"


@implementation HintsTutorialLayer

-(id)init{
    self = [super initWithTitle:@"Hints and Tricks"];
    [self addHints];
    return self;
}

-(void)addHints{
    TextBox * tb = [[TextBox alloc] initFromA:ccp([[FontsAndSpacings getInstance] border],
                                                  [[FontsAndSpacings getInstance] playerRectSize]*2)
                                          ToB:ccp([[Grid getInstance] width]-
                                                  [[FontsAndSpacings getInstance] border],
                                                  [[Grid getInstance] height]-
                                                  [[FontsAndSpacings getInstance] playerRectSize])];
    
    [tb setText:@"- Remember that the way to win is to have the longest path, not the most cards in a clump. Sometimes cards next to the path will not be included in it. \n\n- It's very important to play your opponent's cards well, not just your own. If you put them near the rest of his cards, you're only helping him. \n\n - Block cards can be very useful to you even though they stop your path; the ability to put any card next to them is often worth it \n\n - Keep an eye out for when your opponent tries to connect 2 groups of his cards. Putting 1 card there could cut his score in half."];
    [self addChild:tb];
}

@end

//
//  GameTutorialLayer.m
//  Battle Solitare
//
//  Created by Kevin Yue on 10/23/14.
//  Copyright 2014 Kevin Yue. All rights reserved.
//

#import "GameTutorialLayer.h"
#import "TextBox.h"
#import "FontsAndSpacings.h"
#import "Grid.h"


@implementation GameTutorialLayer

-(id)init{
    self = [super initWithTitle:@"Playing the Game"];
    [self addGameExplanation];
    return self;
}


-(void)addGameExplanation{
    TextBox * tb = [[TextBox alloc] initFromA:ccp([[FontsAndSpacings getInstance] border],
                                                  [[FontsAndSpacings getInstance] playerRectSize]*2)
                                          ToB:ccp([[Grid getInstance] width]-
                                                  [[FontsAndSpacings getInstance] border],
                                                  [[Grid getInstance] height]-
                                                  [[FontsAndSpacings getInstance] playerRectSize])];
    
    [tb setText:@"Taire is played on an invisible grid (the green area) between the two players. It is a simple game with only 6 rules \n\n1) Each player is dealt 1 card at a time. \n2) Play that card by dragging it onto the grid \n3) You can only drag a card next to (no diagonals) a card of the same suit or value \n4) Cards do not have to match all adjacent cards, if they match any one you can play there \n5) There are no turns in Taire, both players can play as fast as they want \n6) The game is over when the grid fills up \n\n Although Taire is easy to learn, it's hard to master. Look at the 'Hints and Tips' page to improve your play"];
    [self addChild:tb];
}
@end

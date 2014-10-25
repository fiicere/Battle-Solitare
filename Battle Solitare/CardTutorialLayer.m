//
//  TutorialPageLayer.m
//  Battle Solitare
//
//  Created by Kevin Yue on 10/23/14.
//  Copyright 2014 Kevin Yue. All rights reserved.
//

#import "CardTutorialLayer.h"
#import "TextBox.h"
#import "FontsAndSpacings.h"
#import "Grid.h"

@implementation CardTutorialLayer

-(id)init{
    self = [super initWithTitle:@"The Cards"];
    [self addCardExplanations];
    return self;
}

-(void)addCardExplanations{
    TextBox * tb = [[TextBox alloc] initFromA:ccp([[FontsAndSpacings getInstance] border],
                                                  [[FontsAndSpacings getInstance] playerRectSize]*2)
                                          ToB:ccp([[Grid getInstance] width]-
                                                  [[FontsAndSpacings getInstance] border],
                                                  [[Grid getInstance] height]-
                                                  [[FontsAndSpacings getInstance] playerRectSize])];
    
    [tb setText:@"The cards in Taire are very simple. Every card has 3 properties: \n\n\t1) a background color \n\t2) a suit \n\t3) a value \n\nThe first property (background color) tells which player the card belongs to and is ONLY important during scoring. \n\nThe second and third properties (suit and number) are ONLY used when the game is in play. \n\nTaire also has 2 types of special cards. \n\t1) Wild Cards \n\t2)Block Cards \n\nWild Cards match every background color, suit, and value. Block Cards match any suit or value, just like Wild Cards do, but do not have any background color."];
    [self addChild:tb];
}
@end

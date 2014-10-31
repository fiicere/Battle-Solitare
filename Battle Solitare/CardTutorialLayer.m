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
#import "Tile.h"

@implementation CardTutorialLayer

-(id)init{
    self = [super initWithTitle:@"The Cards"];
    [self addCardExplanations];
    [self addWildCard];
    [self addBlockCard];
    
    return self;
}

-(void)addCardExplanations{
    TextBox * tb = [[TextBox alloc] initFromA:ccp([[FontsAndSpacings getInstance] border],
                                                  [[FontsAndSpacings getInstance] playerRectSize]*2)
                                          ToB:ccp([[Grid getInstance] width]-
                                                  [[FontsAndSpacings getInstance] border],
                                                  [[Grid getInstance] height]-
                                                  [[FontsAndSpacings getInstance] playerRectSize])];
    
    [tb setText:@"The cards in Taire are very simple. Every card has 3 properties: \n\n\t1) The face color \n\t2) the suit \n\t3) the value \n\nThe face color tells which player the card belongs to and is ONLY important during scoring. The suit and value tell where a card can be played and do not matter during scoring. \n\nTaire also has 2 types of special cards. \n\n\t1) Wild Cards \n\t2) Block Cards \n\nWild Cards match every background color, suit, and value. Block Cards match any suit or value, just like Wild Cards do, but do not match either background color."];
    [self addChild:tb];
}

-(void)addWildCard{
    Tile* wild = [[Tile alloc] initWildCard];
    [wild captionCard:@"Wild Card"];
    wild.position = ccp([[Grid getInstance] width]/3, [[FontsAndSpacings getInstance] playerRectSize]*1.5);
    [self addChild:wild];
}

-(void)addBlockCard{
    Tile* block = [[Tile alloc] initBlockCard];
    [block captionCard:@"Block Card"];
    block.position = ccp([[Grid getInstance] width]*2/3, [[FontsAndSpacings getInstance] playerRectSize]*1.5);
    [self addChild:block];
}
@end

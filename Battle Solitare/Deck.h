//
//  Deck.h
//  Battle Solitare
//
//  Created by Kevin Yue on 3/4/14.
//  Copyright (c) 2014 Kevin Yue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tile.h"

@interface Deck : NSObject

-(Tile *) getNextCard;
+(Deck *) getInstance;
-(void)resetDeck;
-(void) replaceCard:(Tile*) t;

@end

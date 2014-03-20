//
//  Deck.m
//  Battle Solitare
//
//  Created by Kevin Yue on 3/4/14.
//  Copyright (c) 2014 Kevin Yue. All rights reserved.
//

#import "Deck.h"
#import "Tile.h"

NSMutableArray* cardsInDeck;
static Deck * instance;

const int numWilds = 8;

NSArray * allSuits;
NSArray * allColors;

@implementation Deck


+(Deck*) getInstance{
    if(instance == nil){
        instance = [[self alloc] init];
    }
    return instance;
}

-(id)init{
    self = [super init];
    
    [self setupArrays];
    [self resetDeck];
    
    return self;
}

//Sets up the array of suits and colors
-(void)setupArrays{
    allSuits = [NSArray arrayWithObjects: @"c", @"d", @"h", @"s", nil];
    allColors = [NSArray arrayWithObjects: @"w", @"b", nil];
    cardsInDeck = [NSMutableArray new];
}

// Creates 1 of each card (and numWilds wild cards)
-(void)resetDeck{
    for (int i=0; i< numWilds; i++){
        Tile * t = [[Tile alloc] initWildCard];
        [cardsInDeck addObject:t];
    }
    for(NSString * suit in allSuits){
        for(NSString * color in allColors){
            for(int i = 1; i <= 5; i++){
                Tile * t = [[Tile alloc] initWithSuit:suit Value:i Color:color];
                [cardsInDeck addObject:t];
            }
        }
    }
}

//DEPRECATED
-(void)shuffleDeck{
    int i = [cardsInDeck count] - 1;
    Tile * t;
    
    while (i>0){
        int k = arc4random()%i;
        t = [cardsInDeck objectAtIndex:i];
        [cardsInDeck replaceObjectAtIndex:i withObject:[cardsInDeck objectAtIndex:k]];
        [cardsInDeck replaceObjectAtIndex:k withObject:t];
    }
}

//Returns a random card in the deck
-(Tile *) getNextCard{
    if([cardsInDeck count] == 0){
        return [[Tile alloc] initWildCard];
    }
    int r =(arc4random() % [cardsInDeck count]);
    Tile * t = [cardsInDeck objectAtIndex:r];
    [cardsInDeck removeObjectAtIndex:r];
    return t;
}



@end

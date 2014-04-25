//
//  Tile.m
//  Battle Solitare
//
//  Created by Kevin Yue on 12/30/13.
//  Copyright 2013 Kevin Yue. All rights reserved.
//

#import "Tile.h"
#import "CCSprite.h"
#import "Grid.h"
#import "ImprovedChild.h"
#import "ImprovedSprite.h"

const CGFloat cardMargin = 5;
const CGFloat suitSize = 0.45;
const CGFloat numSize = 0.2;
const CGFloat numOffset = 0.3;

@implementation Tile

-(id)init{
    if (self = [super init]){
        
    }
    return self;
}

// Create a card with a set suit, value, and color
-(id) initWithSuit:(NSString *)suit Value:(int)val Color:(NSString *)col{
    
    //Check to make sure all card properties are valid
    NSAssert(val >= 1 && val <= 5, @"Invalid card value: %u", val);
    NSAssert([col isEqualToString:@"b"]
             || [col isEqualToString:@"w"]
             || [col isEqualToString:@"wild"] , @"Invalid card Color");
    NSAssert([suit isEqualToString:@"d"]
             || [suit isEqualToString:@"s"]
             || [suit isEqualToString:@"h"]
             || [suit isEqualToString:@"c"]
             || [suit isEqualToString:@"wild"], @"Invalid card Color");
    
    //Create the tile
    if([col isEqualToString:@"b"]){
        self = [super initWithFile:@"black card.png"];
    }
    else if([col isEqualToString:@"w"]){
        self = [super initWithFile:@"white card.png"];
    }
    
    //Have it remember its properties
    _suit = suit;
    _value = val;
    _backgroundColor = col;
    
    
    //Scale it to the grid
    [self scaleCard];
    
    //Add the suit icon
    [self addSuit];
    
    //Add the value icon
    [self addValue];
    
    return self;
}

// Returns a wild card
-(id) initWildCard{
    self = [super initWithFile:@"wild card.png"];
    [self scaleCard];
    _suit = @"wild";
    _value = 1;
    _backgroundColor = @"wild";
    return self;
}

-(void) addSuit{

    NSString * file;
    if([_suit isEqualToString:@"s"]){
        file = @"spades.png";
    }
    else if([_suit isEqualToString:@"c"]){
        file = @"clubs.png";

    }
    else if([_suit isEqualToString:@"h"]){
        file = @"hearts.png";

    }
    else if([_suit isEqualToString:@"d"]){
        file = @"diamonds.png";
    }
    
    ImprovedChild * suitSprite = [[ImprovedChild alloc] initWithParent:self andFile:file];
    
    [self scaleSuit:suitSprite];

    [self addChild:suitSprite z:2];
}

-(void) addValue{
    // If Card is Red
    NSString * filename;
    if([_suit isEqualToString:@"h"] || [_suit isEqualToString:@"d"]){
        filename = [NSString stringWithFormat:@"r%d%s", _value, ".png"];
    }
    else{
        filename = [NSString stringWithFormat:@"b%d%s", _value, ".png"];
    }
    ImprovedChild * ns1 = [[ImprovedChild alloc] initWithParent:self andFile:filename];
    ImprovedChild * ns2 = [[ImprovedChild alloc] initWithParent:self andFile:filename];
    ns2.rotation = 180;
    
    [self scaleNum:ns1];
    [self scaleNum:ns2];
    
    [ns1 setPositionX:[[Grid getInstance] sqWidth] * -numOffset Y:[[Grid getInstance] sqHeight]*numOffset];
    [ns2 setPositionX:[[Grid getInstance] sqWidth] * numOffset Y:[[Grid getInstance] sqHeight]*-numOffset];


    [self addChild:ns1 z:2];
    [self addChild:ns2 z:2];
}


// Scales this sprite to the size of
-(void)scaleCard{
    [self scaleToX: [[Grid getInstance]sqWidth] - cardMargin Y: [[Grid getInstance]sqHeight] - cardMargin];
}

// Scales a suit sprite
-(void)scaleSuit:(ImprovedSprite*) suitSprite{
    [suitSprite scaleToX:[[Grid getInstance]sqWidth] * suitSize Y:[[Grid getInstance]sqHeight] * suitSize];
}

// Scales a suit sprite
-(void)scaleNum:(ImprovedSprite*) numSprite{
    [numSprite scaleToX:[[Grid getInstance]sqWidth] * numSize Y:[[Grid getInstance]sqHeight] * numSize];

}

// Returns true if the tile matches this one in suit or value. False otherwise
-(BOOL) matches:(Tile*)t{
    if([t.suit isEqualToString:@"wild"]){
        return true;
    }
    else if([self.suit isEqualToString:@"wild"]){
        return true;
    }
    else if([t.suit isEqualToString:self.suit]){
        return true;
    }
    else if(t.value == self.value){
        return true;
    }
    return false;
}

-(void) printCard{
    if([_suit isEqualToString:@"wild"]){
        NSLog(@"Wild Card at (%u, %u)", _sqID.x, _sqID.y);
    }
    else{
        NSLog(@"%@%u%@ at (%u, %u)", _backgroundColor, _value, _suit, _sqID.x, _sqID.y);
    }
}

@end

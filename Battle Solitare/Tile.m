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

const CGFloat margin = 5;


@implementation Tile

-(id)init{
    if (self = [super init]){
        
    }
    return self;
}

-(id) initWithFile:(NSString*) filename{
    self = [super initWithFile:filename];
    [self scaleToGrid];

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
    
    //Generate the filename based on card properties
    NSString * filename = [NSString stringWithFormat:@"%@%d%@%s", col, val, suit, ".tif"];
    
    //Create the tile
    if([col isEqualToString:@"b"]){
        self = [super initWithFile:@"black card.tif"];
    }
    else if([col isEqualToString:@"w"]){
        self = [super initWithFile:@"white card.tif"];
    }
    
    //Scale it to the grid
    [self scaleToGrid];
    
    //Have it remember its properties
    _suit = suit;
    _value = val;
    _backgroundColor = col;
    return self;
}

// Returns a wild card
-(id) initWildCard{
    self = [super initWithFile:@"Default.png"];
    [self scaleToGrid];
    _suit = @"wild";
    _value = 1;
    _backgroundColor = @"wild";
    return self;
}


// Scales this sprite to the size of
-(void)scaleToGrid{
    [self scaleToX:[Grid getInstance].sqWidth - margin Y:[Grid getInstance].sqHeight - margin];
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

@end

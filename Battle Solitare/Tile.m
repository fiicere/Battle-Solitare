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

const CGFloat cardMargin = 5;
const CGFloat suitSize = 0.5;
const CGFloat numSize = 0.2;

@implementation Tile

-(id)init{
    if (self = [super init]){
        
    }
    return self;
}

-(id) initWithFile:(NSString*) filename{
    self = [super initWithFile:filename];
    [self scaleCard];

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
        self = [super initWithFile:@"black card.tif"];
    }
    else if([col isEqualToString:@"w"]){
        self = [super initWithFile:@"white card.tif"];
    }
    
    //Scale it to the grid
    [self scaleCard];
    
    //Have it remember its properties
    _suit = suit;
    _value = val;
    _backgroundColor = col;
    
    
    //Add the suit icon
    [self addSuit];
    
    //Add the value icon
    [self addValue];
    

    return self;
}

// Returns a wild card
-(id) initWildCard{
    self = [super initWithFile:@"Default.png"];
    [self scaleCard];
    _suit = @"wild";
    _value = 1;
    _backgroundColor = @"wild";
    return self;
}

-(void) addSuit{

    NSString * file;
    if([_suit isEqualToString:@"s"]){
        file = @"spades.tif";
    }
    else if([_suit isEqualToString:@"c"]){
        file = @"clubs.tif";

    }
    else if([_suit isEqualToString:@"h"]){
        file = @"hearts.tif";

    }
    else if([_suit isEqualToString:@"d"]){
        file = @"diamonds.tif";
    }
    ImprovedSprite * suitSprite = [[ImprovedSprite alloc] initWithFile:file];
    [self scaleSuit:suitSprite];
    suitSprite.position = ccp(self.boundingBox.size.width, self.boundingBox.size.height);
    [self addChild:suitSprite z:1];
}

-(void) addValue{
    // If Card is Red
    NSString * filename;
    if([_suit isEqualToString:@"h"] || [_suit isEqualToString:@"h"]){
        filename = [NSString stringWithFormat:@"r%d%s", _value, ".tif"];
    }
    else{
        filename = [NSString stringWithFormat:@"b%d%s", _value, ".tif"];
    }
    ImprovedSprite * ns1 = [[ImprovedSprite alloc] initWithFile:filename];
    ImprovedSprite * ns2 = [[ImprovedSprite alloc] initWithFile:filename];
    ns2.rotation = 180;
    
    [self scaleNum:ns1];
    [self scaleNum:ns2];
    
    ns2.position = ccp(self.boundingBox.size.width * .75 + self.boundingBox.size.width,
                       self.boundingBox.size.height * .75 + self.boundingBox.size.height);
    ns1.position = ccp(-self.boundingBox.size.width * .75 + self.boundingBox.size.width,
                       -self.boundingBox.size.height * .75 + self.boundingBox.size.height);
    
    [self addChild:ns1 z:1];
    [self addChild:ns2 z:1];
}


// Scales this sprite to the size of
-(void)scaleCard{
    [self scaleToX:[Grid getInstance].sqWidth - cardMargin Y:[Grid getInstance].sqHeight - cardMargin];
}

// Scales a suit sprite
-(void)scaleSuit:(ImprovedSprite*) suitSprite{
    [suitSprite scaleToX:self.boundingBox.size.width * suitSize Y:self.boundingBox.size.height * suitSize];
}

// Scales a suit sprite
-(void)scaleNum:(ImprovedSprite*) numSprite{
    [numSprite scaleToX:self.boundingBox.size.width * numSize Y:self.boundingBox.size.height * numSize];
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

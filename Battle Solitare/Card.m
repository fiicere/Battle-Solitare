//
//  Card.m
//  Battle Solitare
//
//  Created by Kevin Yue on 3/12/14.
//  Copyright 2014 Kevin Yue. All rights reserved.
//

#import "Card.h"
#import "ImprovedSprite.h"
#import "Grid.h"

ImprovedSprite * ss;
ImprovedSprite * ns1;
ImprovedSprite * ns2;
ImprovedSprite * bs;

const CGFloat nsScale = 0.25;
const CGFloat ssScale = 0.4;
const CGFloat cardMargin = 5;


CGFloat cardWidth;
CGFloat cardHeight;


@implementation Card

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
    self = [super init];
    [self setupVariables];
    
    //Have it remember its properties
    _suit = suit;
    _value = val;
    _backgroundColor = col;
    
    //Create Assets
    [self assets];
    return self;
}

-(id) initWildCard{
    self = [super init];
    [self setupVariables];
    _suit = @"wild";
    _value = 1;
    _backgroundColor = @"wild";
    
    [self addChild:[[ImprovedSprite alloc] initWithFile:@"Default.png"]];
    return self;
    
}

-(void) setupVariables{
    cardWidth = [[Grid getInstance] sqWidth];
    cardHeight = [[Grid getInstance] sqHeight];
}

-(void)assets{
    [self getBackgroundCard];
    [self getSuitCard];
    [self getNumCard];
    [self addChild:bs];
    [self addChild:ss];
    [self addChild:ns1];
    [self addChild:ns2];
    
}

// Sets backgroundCard to proper colored card
-(void) getBackgroundCard{
    if([_backgroundColor isEqualToString:@"b"]){
        bs = [[ImprovedSprite alloc] initWithFile:@"black card.tif"];
    }
    else if([_backgroundColor isEqualToString:@"w"]){
        bs = [[ImprovedSprite alloc] initWithFile:@"white card.tif"];
    }
    [bs scaleToX:cardWidth - cardMargin Y:cardHeight - cardMargin];
}

// Sets backgroundCard to proper colored card
-(void) getSuitCard{
    if([_suit isEqualToString:@"c"]){
        ss = [[ImprovedSprite alloc] initWithFile:@"clubs.tif"];
    }
    else if([_suit isEqualToString:@"d"]){
        ss = [[ImprovedSprite alloc] initWithFile:@"diamonds.tif"];
    }
    else if([_suit isEqualToString:@"h"]){
        ss = [[ImprovedSprite alloc] initWithFile:@"hearts.tif"];
    }
    else if([_suit isEqualToString:@"s"]){
        ss = [[ImprovedSprite alloc] initWithFile:@"spades.tif"];
    }
    [ss scaleToX:cardWidth * ssScale Y:cardHeight * ssScale];
}
// Sets backgroundCard to proper colored card
-(void) getNumCard{
    // If Card is Red
    NSString * filename;
    if([_suit isEqualToString:@"h"] || [_suit isEqualToString:@"h"]){
        filename = [NSString stringWithFormat:@"r%d%s", _value, ".tif"];
    }
    else{
        filename = [NSString stringWithFormat:@"b%d%s", _value, ".tif"];
    }
    ns1 = [[ImprovedSprite alloc] initWithFile:filename];
    ns2 = [[ImprovedSprite alloc] initWithFile:filename];
    
    [ns1 scaleToX:cardWidth * nsScale Y:cardHeight * nsScale];
    [ns2 scaleToX:cardWidth * nsScale Y:cardHeight * nsScale];

    ns1.position = ccp(-cardWidth/2 + 2*cardMargin + cardWidth * nsScale,
                       -cardHeight/2 + 2*cardMargin + cardWidth * nsScale);
    ns2.position = ccp(- ns1.position.x, - ns1.position.y);
    
    ns2.rotation = 180;
}

-(BOOL) matches:(Card*)c{
    if([c.suit isEqualToString:@"wild"]){
        return true;
    }
    else if([self.suit isEqualToString:@"wild"]){
        return true;
    }
    else if([c.suit isEqualToString:self.suit]){
        return true;
    }
    else if(c.value == self.value){
        return true;
    }
    return false;
}

@end

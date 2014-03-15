//
//  Tile.h
//  Battle Solitare
//
//  Created by Kevin Yue on 12/30/13.
//  Copyright 2013 Kevin Yue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ImprovedSprite.h"

#import "CCSprite.h"

@interface Tile : ImprovedSprite

@property (nonatomic, assign, readonly) NSString * suit;
@property (nonatomic, assign, readonly) NSString * backgroundColor;
@property (nonatomic, assign, readonly) int value;


-(id) initWithSuit:(NSString *)suit Value:(int)val Color:(NSString *)col;
-(id) initWildCard;

-(BOOL) matches:(Tile*)t;

-(void) printCard;
@end

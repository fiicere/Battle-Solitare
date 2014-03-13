//
//  Card.h
//  Battle Solitare
//
//  Created by Kevin Yue on 3/12/14.
//  Copyright 2014 Kevin Yue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Card : CCLayer {
    
}
@property (nonatomic, assign, readonly) NSString * suit;
@property (nonatomic, assign, readonly) NSString * backgroundColor;
@property (nonatomic, assign, readonly) int value;

-(id) initWithSuit:(NSString *)suit Value:(int)val Color:(NSString *)col;
-(id) initWildCard;

-(BOOL) matches:(Card*)c;

@end

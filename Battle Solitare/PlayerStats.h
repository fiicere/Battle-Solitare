//
//  PlayerStats.h
//  Battle Solitare
//
//  Created by Kevin Yue on 8/13/14.
//  Copyright 2014 Kevin Yue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface PlayerStats : CCNode {
    
}
+(PlayerStats *) getInstance;

-(float) getWinRate;
-(float) getMoveSpeed;

-(void) justWonGame;

-(void) justLostGame;

-(void) madeMoveAtSpeed:(float)time;

@end

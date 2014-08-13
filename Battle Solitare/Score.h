//
//  Score.h
//  Battle Solitare
//
//  Created by Kevin Yue on 3/7/14.
//  Copyright (c) 2014 Kevin Yue. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Tile.h"

@interface Score : NSObject

+(Score *) getInstance;
-(void)floodUpdateForPlayedTile:(Tile*)t;

-(int)blackScore;
-(int)whiteScore;

-(NSArray*) blackPath;
-(NSArray*) whitePath;

-(void) printWhitePath;
-(void) printBlackPath;

-(void) reset;
@end

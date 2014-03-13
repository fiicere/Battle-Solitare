//
//  Score.h
//  Battle Solitare
//
//  Created by Kevin Yue on 3/7/14.
//  Copyright (c) 2014 Kevin Yue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Score : NSObject

+(Score *) getInstance;
-(void) updateScores;

-(int)blackScore;
-(int)whiteScore;

@end

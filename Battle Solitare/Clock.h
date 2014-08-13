//
//  Clock.h
//  Battle Solitare
//
//  Created by Kevin Yue on 8/13/14.
//  Copyright 2014 Kevin Yue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Clock : NSObject {
    
}

+(Clock*) getInstance;
-(void)resetClock;
-(float)getTime;
-(void)incrementClock:(float)dt;


@end

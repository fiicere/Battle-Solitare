//
//  TextBox.h
//  Battle Solitare
//
//  Created by Kevin Yue on 10/24/14.
//  Copyright 2014 Kevin Yue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface TextBox : CCNode {
    
}

-(id)initFromA:(CGPoint)pointA ToB:(CGPoint)pointB;

-(void)setText:(NSString*)text;
@end

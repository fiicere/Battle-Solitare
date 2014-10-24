//
//  Font.h
//  Battle Solitare
//
//  Created by Kevin Yue on 8/21/14.
//  Copyright (c) 2014 Kevin Yue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FontsAndSpacings : NSObject


@property (nonatomic, assign) int menuFontSize;
@property (nonatomic, assign) int hudFontSize;
@property (nonatomic, assign) int textOffset;
@property (nonatomic, assign) NSString * font;
@property (nonatomic, assign) float border;
@property (nonatomic, assign) float playerRectSize;


+(FontsAndSpacings*)getInstance;

@end
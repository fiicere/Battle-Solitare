//
//  TitleWithRects.m
//  Battle Solitare
//
//  Created by Kevin Yue on 10/23/14.
//  Copyright 2014 Kevin Yue. All rights reserved.
//

#import "TextWithRects.h"
#import "TextBox.h"
#import "FontsAndSpacings.h"
#import "Grid.h"

@implementation TextWithRects

NSString * title;

CGFloat currentHeight;


-(id)initWithTitle:(NSString*)layerTitle{
    self = [super init];
    title = layerTitle;
    [self makeTitle];
    return self;
}

-(void) makeTitle{
    CCLabelTTF * titleLabel = [CCLabelTTF labelWithString:title
                                                    fontName:[[FontsAndSpacings getInstance] font]
                                                    fontSize:[[FontsAndSpacings getInstance] menuFontSize]];
    
    titleLabel.color = ccWHITE;
    
    titleLabel.position = ccp([[Grid getInstance] width]/2, [[Grid getInstance] topCardLoc].y);
    
    [self addChild:titleLabel];
}

-(void) addDebugText{
    TextBox * tb = [[TextBox alloc] initFromA:ccp([[FontsAndSpacings getInstance] border],
                                                  [[FontsAndSpacings getInstance] playerRectSize])
                                          ToB:ccp([[Grid getInstance] width]-
                                                  [[FontsAndSpacings getInstance] border],
                                                  [[Grid getInstance] height]-
                                                  [[FontsAndSpacings getInstance] playerRectSize])];
    
    [tb setText:@"Four score and seven years ago our fathers brought forth on this continent, a new nation, conceived in Liberty, and dedicated to the proposition that all men are created equal. \nNow we are engaged in a great civil war, testing whether that nation, or any nation so conceived and so dedicated, can long endure. We are met on a great battle-field of that war. We have come to dedicate a portion of that field, as a final resting place for those who here gave their lives that that nation might live. It is altogether fitting and proper that we should do this.But, in a larger sense, we can not dedicate -- we can not consecrate -- we can not hallow -- this ground. The brave men, living and dead, who struggled here, have consecrated it, far above our poor power to add or detract. The world will little note, nor long remember what we say here, but it can never forget what they did here. It is for us the living, rather, to be dedicated here to the unfinished work which they who fought here have thus far so nobly advanced. It is rather for us to be here dedicated to the great task remaining before us -- that from these honored dead we take increased devotion to that cause for which they gave the last full measure of devotion -- that we here highly resolve that these dead shall not have died in vain -- that this nation, under God, shall have a new birth of freedom -- and that government of the people, by the people, for the people, shall not perish from the earth.\nAbraham Lincoln \nNovember 19, 1863"];
    [self addChild:tb];    
}

@end

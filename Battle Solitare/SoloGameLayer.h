//
//  HelloWorldLayer.h
//  Battle Solitare
//
//  Created by Kevin Yue on 12/31/12.
//  Copyright Kevin Yue 2012. All rights reserved.
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "BackgroundLayer.h"
#import "BackgroundWithRects.h"
#import "Tile.h"

// HelloWorldLayer
@interface SoloGameLayer : BackgroundWithRects <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate>
{
}



@end

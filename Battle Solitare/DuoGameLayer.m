//
//  HelloWorldLayer.m
//  Battle Solitare
//
//  Created by Kevin Yue on 12/31/12.
//  Copyright Kevin Yue 2012. All rights reserved.
//


// Import the interfaces
#import "DuoGameLayer.h"
#import "ScoreScreen.h"
#import "PauseScene.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#import "Grid.h"
#import "Touch.h"
#import "TileManager.h"
#import "ImprovedSprite.h"
#import "Score.h"

#pragma mark - HelloWorldLayer

NSMapTable * touchDict;

NSString * whiteScoreText;
NSString * blackScoreText;

const int scoreOffset = 50;

CCLabelTTF * botScoreLabel;
CCLabelTTF * topScoreLabel;
CCLabelTTF * pauseLabel;
CCLabelTTF * topPauseLabel;

// HelloWorldLayer implementation
@implementation DuoGameLayer


// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
        
        // Add all layer objects
        [self addPlayerRects];
        [self addPauseButtons];
        [self addScore];
        [self addPlayedCards];
        
        // Reset Touches
        touchDict = [NSMapTable new];

        [self schedule:@selector(updateView:) interval:0.1];
        
        // to enable touch detection
        [self setIsTouchEnabled:YES];
        }
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
    
	[super dealloc];
}

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

////////////////////////////////MY CODE////////////////////////////////

//-(void) testGrid{
//    CGSize size = [[CCDirector sharedDirector] winSize];
//    while([[TileManager getInstance] getPlacedTiles].count < 50){
//        Tile * card = [[TileManager getInstance] newBotTile];
//        card.position = ccp((arc4random() % (int)size.width), (arc4random() % (int)size.height));
//
//        [self addChild: card];
//    }
//}


///////////////////////////UPDATES///////////////////////

-(void)updateView:(ccTime)dt{
    [self updateScore];
    [self addHandCards];
    
    if(dt > .5){
        [self addPlayedCards];
    }
}

-(void)addPlayedCards{
    for(Tile* t in [[[TileManager getInstance] getPlacedTiles] reverseObjectEnumerator]){
        if([self isChild:t]){
            return;
        }
        [self addChild:t];
    }
}

-(void) removeAllCards{
    for(Tile*t in [[TileManager getInstance] getPlacedTiles]){
        [self removeChild:t];
    }
}

-(void)addHandCards{
    if(! [self isChild:[[TileManager getInstance] topCard]]){
        [self addChild:[[TileManager getInstance] topCard]];
    }
    if(! [self isChild:[[TileManager getInstance] botCard]]){
        [self addChild:[[TileManager getInstance] botCard]];
    }
}

-(BOOL) isChild:(Tile*)t{
    if(t.parent == self){
        return true;
    }
    return false;
}

-(void) updateScore{
    blackScoreText = [NSString stringWithFormat:@"Score = %u", [[Score getInstance] blackScore]];
    whiteScoreText = [NSString stringWithFormat:@"Score = %u", [[Score getInstance] whiteScore]];
    
    [botScoreLabel setString:whiteScoreText];
    [topScoreLabel setString:blackScoreText];
    
}

-(void)addScore{
    blackScoreText = [NSString stringWithFormat:@"Score = %u", [[Score getInstance] blackScore]];
    whiteScoreText = [NSString stringWithFormat:@"Score = %u", [[Score getInstance] whiteScore]];
    
    botScoreLabel = [CCLabelTTF labelWithString:whiteScoreText fontName:@"TrajanPro-Regular" fontSize:12];
    topScoreLabel = [CCLabelTTF labelWithString:blackScoreText fontName:@"TrajanPro-Regular" fontSize:12];
    
    topScoreLabel.rotation = 180;
    
    topScoreLabel.color = ccWHITE;
    botScoreLabel.color = ccBLACK;
    
    botScoreLabel.position = ccp([[Grid getInstance] width] - scoreOffset, [[Grid getInstance] botCardLoc].y);
    topScoreLabel.position = ccp(scoreOffset, [[Grid getInstance] topCardLoc].y);
    
    [self addChild:topScoreLabel];
    [self addChild:botScoreLabel];
}

-(void)addPauseButtons{
    topPauseLabel = [CCLabelTTF labelWithString:@"Pause" fontName:@"TrajanPro-Regular" fontSize:12];
    pauseLabel = [CCLabelTTF labelWithString:@"Pause" fontName:@"TrajanPro-Regular" fontSize:12];

    topPauseLabel.rotation = 180;

    topPauseLabel.color = ccWHITE;
    pauseLabel.color = ccBLACK;

    pauseLabel.position = ccp(scoreOffset, [[Grid getInstance] botCardLoc].y);
    topPauseLabel.position = ccp([[Grid getInstance] width] - scoreOffset, [[Grid getInstance] topCardLoc].y);
    
    [self addChild:pauseLabel];
    [self addChild:topPauseLabel];
}

-(void) botPaused{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0
                                                                                 scene:[PauseScene sceneWithOrientation:true
                                                                                        andIsSoloMode:false]]];

}

-(void) topPaused{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0
                                                                                 scene:[PauseScene sceneWithOrientation:false
                                                                                        andIsSoloMode:false]]];
}

-(void)checkGameOver{
    if([[TileManager getInstance] getPlacedTiles].count >= 49){
        [self gameOver];
    }
}

-(void)gameOver{
    [self removeAllCards];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[ScoreScreen scene]]];
}

////////////////////////////////TOUCH HANDLING////////////////////////////////


// Changes type of touch detection
// TODO: Figure out what calls this...
-(void) registerWithTouchDispatcher
{
    //	[[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
    [[CCTouchDispatcher sharedDispatcher] addStandardDelegate:self priority:0];
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch * touch in touches){
        CGPoint loc = [self convertTouchToNodeSpace:touch];
        
//        [self printSquare:loc];
        
        // Check to see if player clicked the top card
        Tile * tile = [[TileManager getInstance] topCard];
        if (CGRectContainsPoint(tile.boundingBox, loc)){
            Touch * t = [[Touch alloc] touchedTile:tile atLoc:tile.position];
            [touchDict setObject:t forKey:touch];
        }
        
        // Check to see if player clicked the bot card
        tile = [[TileManager getInstance] botCard];
        if (CGRectContainsPoint(tile.boundingBox, loc)){
            Touch * t = [[Touch alloc] touchedTile:tile atLoc:tile.position];
            [touchDict setObject:t forKey:touch];
        }

        //Check for game paused
        if(CGRectContainsPoint(pauseLabel.boundingBox, loc)){
            [self botPaused];
        }
        if(CGRectContainsPoint(topPauseLabel.boundingBox, loc)){
            [self topPaused];
        }
    }
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    for(UITouch * touch in touches){        
        Touch* t = [touchDict objectForKey:touch];
        Tile* tile = [t getTile];

        // If Invalid location
        if(! [[TileManager getInstance] moveTile:tile toLoc:([self convertTouchToNodeSpace:touch])]){
            tile.position = t.getStartPoint;
        }

        [touchDict removeObjectForKey:touch];
    }
    [self checkGameOver];
}

-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    for(UITouch * touch in touches){
        CGPoint loc = [self convertTouchToNodeSpace:touch];
        Touch* t = [touchDict objectForKey:touch];
        Tile* tile = [t getTile];
        
        tile.position = loc;
    }
}

//////////////////////////DEBUG CODE!!!!!!///////////////////
-(void)printSquare:(CGPoint)location{
    SqID * sqID = [[Grid getInstance] getSquareID:location];
    NSLog(@"Clicked (%u, %u, %@)", sqID.x, sqID.y, sqID.occupied ? @"Occupied" : @"Not Occupied");
}

-(void)printScoreHueuristic:(CGPoint)loc{
    for (Tile* t in [[TileManager getInstance] getPlacedTiles]){
        if (CGRectContainsPoint(t.boundingBox, loc)){
            NSLog(@"Card: %@%u%@ has heuristicValue: %f", t.backgroundColor, t.value, t.suit, t.scoreHeuristic);
        }
    }
}

@end

//
//  HelloWorldLayer.m
//  Battle Solitare
//
//  Created by Kevin Yue on 12/31/12.
//  Copyright Kevin Yue 2012. All rights reserved.
//


// Import the interfaces
#import "GameLayer.h"

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
const int rectMargin = 20;

CCLabelTTF * botLabel;
CCLabelTTF * topLabel;

BOOL firstRun = true;


// HelloWorldLayer implementation
@implementation GameLayer


// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
        
        [self newGame];
        
        firstRun = true;
        
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

-(void)newGame{
    for(CCNode* c in self.children){
        [c release];
    }
    [[TileManager getInstance] reset];
    [[Score getInstance] reset];

    touchDict = [NSMapTable new];
    
    [self addPlayerRects];

    [self addScore];

}

-(void) testGrid{
    CGSize size = [[CCDirector sharedDirector] winSize];
    while([[TileManager getInstance] getPlacedTiles].count < 50){
        Tile * card = [[TileManager getInstance] newBotTile];
        card.position = ccp((arc4random() % (int)size.width), (arc4random() % (int)size.height));

        [self addChild: card];
    }
}

-(void)addPlayerRects{
    CGFloat x = [[Grid getInstance] width];
    CGFloat y = [[Grid getInstance] verticalMargin];
    ImprovedSprite * top = [[ImprovedSprite alloc] initWithFile:@"black felt.png"];
    ImprovedSprite * bot = [[ImprovedSprite alloc] initWithFile:@"white felt.png"];
    
    [bot scaleToX:x - rectMargin Y:y - [[Grid getInstance] sqHeight]/2 - rectMargin];
    [top scaleToX:x - rectMargin Y:y - [[Grid getInstance] sqHeight]/2 - rectMargin];
    
    bot.position = ccp(bot.boundingBox.size.width/2 + rectMargin/2, bot.boundingBox.size.height/2 + rectMargin/2);
    top.position = ccp(top.boundingBox.size.width/2 + rectMargin/2, [[Grid getInstance] height] - top.boundingBox.size.height/2 - rectMargin/2);
    
    [self addChild:top];
    [self addChild:bot];
    
}


///////////////////////////UPDATES///////////////////////

-(void)updateView:(ccTime)dt{
    [self updateScore];
    [self addHandCards];
    
    if(dt > .5 || firstRun){
        [self addPlayedCards];
        firstRun = false;
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
    
    [botLabel setString:whiteScoreText];
    [topLabel setString:blackScoreText];
    
}

-(void)addScore{
    blackScoreText = [NSString stringWithFormat:@"Score = %u", [[Score getInstance] blackScore]];
    whiteScoreText = [NSString stringWithFormat:@"Score = %u", [[Score getInstance] whiteScore]];
    
    botLabel = [CCLabelTTF labelWithString:whiteScoreText fontName:@"TrajanPro-Regular" fontSize:12];
    topLabel = [CCLabelTTF labelWithString:blackScoreText fontName:@"TrajanPro-Regular" fontSize:12];
    
    topLabel.rotation = 180;
    
    topLabel.color = ccWHITE;
    botLabel.color = ccBLACK;
    
    botLabel.position = ccp([[Grid getInstance] width] - scoreOffset, [[Grid getInstance] botCardLoc].y);
    topLabel.position = ccp(scoreOffset, [[Grid getInstance] topCardLoc].y);
    
    [self addChild:topLabel];
    [self addChild:botLabel];
}

-(void)checkGameOver{
    if([[TileManager getInstance] getPlacedTiles].count >= 49){
        [self gameOver];
    }
}

-(void)gameOver{
    [[self parent] gameOver];
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
        
//        SqID sqID = [[Grid getInstance] getSquareID:loc];
//        NSLog(@"Clicked (%u, %u)", sqID.x, sqID.y);
        
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
        
        
        //DEBUG!!!
//        if(CGRectContainsPoint(botLabel.boundingBox, loc)){
//            [[Score getInstance] printWhitePath];
//        }
//        if(CGRectContainsPoint(topLabel.boundingBox, loc)){
//            [[Score getInstance] printBlackPath];
//        }
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


@end

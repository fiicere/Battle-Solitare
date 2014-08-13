//
//  PlayerStats.m
//  Battle Solitare
//
//  Created by Kevin Yue on 8/13/14.
//  Copyright 2014 Kevin Yue. All rights reserved.
//

#import "PlayerStats.h"

const float moveSpeedDecay = 0.01;
const float winRateDecay = 0.1;

PlayerStats * instance;

NSMutableDictionary * stats;

@implementation PlayerStats


-(id) init{
    self = [super init];
    [self loadData];
    return self;
}

+(PlayerStats *) getInstance{
    if (instance == nil){
        instance = [[PlayerStats alloc] init];
    }
    return instance;
}

-(void) loadData{
    [stats addEntriesFromDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"TairePlayerData"]];
    [self setupKeys];
    
}

-(void)setupKeys{
    if([stats objectForKey:@"WinRate" == nil]){[self setWinRate:0.5];}
    if([stats objectForKey:@"MoveSpeed" == nil]){[self setMoveSpeed:2];}
}

-(void) saveData{
    [[NSUserDefaults standardUserDefaults] setObject:stats forKey:@"TairePlayerData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void) setWinRate:(float)newWinRate{
    NSNumber * number= [NSNumber numberWithFloat:newWinRate];
    [stats setObject:number forKey:@"WinRate"];
    [self saveData];
}

-(float) getWinRate{
    return [[stats objectForKey:@"WinRate"] floatValue];
}

-(void) setMoveSpeed:(float)newMoveSpeed{
    NSNumber * number= [NSNumber numberWithFloat:newMoveSpeed];
    [stats setObject:number forKey:@"MoveSpeed"];
    [self saveData];
}

-(float) getMoveSpeed{
    return [[stats objectForKey:@"MoveSpeed"] floatValue];
}

-(void) justWonGame{
    float winrate = [self getWinRate];
    winrate = winrate * (1-winRateDecay) + winRateDecay;
    [self setWinRate:winrate];
    NSLog(@"WINRATE= %f", winrate);
}

-(void) justLostGame{
    float winrate = [self getWinRate];
    winrate = winrate * (1-winRateDecay);
    [self setWinRate:winrate];
}

-(void) madeMoveAtSpeed:(float)time{
    float movespeed= [self getMoveSpeed];
    movespeed = movespeed*(1-moveSpeedDecay) + time*moveSpeedDecay;
    [self setMoveSpeed:movespeed];
    NSLog(@"Avg move speed= %f", movespeed);

}


@end

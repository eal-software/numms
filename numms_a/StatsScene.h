
// Copyright (c) 2011 Ethan Levien

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "HelloScene.h"
#import "Score.h"
#import "Consts.h"

/*--------------------------------------------------------------
 Programmer: ethan levien
 
 SUMMARY: 
 
 todo: -clean up comment code - mostly in file io code
 
 REVISIONS: 
 05/26/2011 (eal) - wrote and implemented class basics
 
 ----------------------------------------------------------------*/


@interface StatsScene : CCLayer {
    CCLabelTTF* levels;
    CCLabelTTF* sums;
    CCLabelTTF* bonuses;
}

+(id) scene;
-(void) menuSetup;
// sets up navigation buttons and any labels etc.. that do not need to be edited during the scenes lifetime

-(void) resetData:(CCMenuItemLabel  *) menuItem;
// reset all the stats data

-(void) goBack:(CCMenuItemLabel  *) menuItem ;
// return to main

-(void) displayStats:(NSArray*) data;
// PRE: data is an array of NSData objects containing encoded
//      score objects
// POST: information is data is displayed

-(NSArray*) readStats;
// POST: reads Scores from StatsData.plist into array

@end
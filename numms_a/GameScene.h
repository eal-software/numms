
// Copyright (c) 2011 Ethan Levien

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Hud.h"
#import "StatsScene.h"
#import "Board.h"
#import "Score.h"
#import "Consts.h"

/*--------------------------------------------------------------
 Programmer: ethan levien
 
 SUMMARY: 
 
 todo:  - clean up code
        - empty stats array if it has two many elements, just to avoid getting memory warning
 
 REVISIONS: 
 05/26/2011 (eal) - wrote and implemented class basics
 
 ----------------------------------------------------------------*/


@interface GameScene : CCLayer {

    Hud *hud;     // for display of dynamic game data
    short lvlTime;
    
    // these variables are implemted here as opposed to the DataMatrix because
    // they do not effect the game logic
    short goal;    // score needed to pass level
    short bonus;
    
    Board* board;
}

+(id) scene;
-(void) playLevel;
-(void) timePlus;
-(void) goBack:(CCMenuItemLabel  *) menuItem ;
-(void) gameEnd;
-(void) saveStats;


@end

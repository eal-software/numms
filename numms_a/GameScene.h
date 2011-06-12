
// Copyright (c) 2011 Ethan Levien
// GameScene.h

#import <Foundation/Foundation.h>
#import "Consts.h"
#import "cocos2d.h"
#import "HelloScene.h"
#import "Hud.h"
#import "Board.h"
#import "Score.h"
#import "DataIOManager.h"
#import "FadeTextButton.h"

/*--------------------------------------------------------------
 Programmer: ethan levien
 
 SUMMARY: the scene is played when player is playing the game. contians one
          interactive component: back button( nav to hello scene ) and is also
          capable of recieving touch events. The scene controls two main objects:
          the hud which displays game data, and the board which encapsulates and
          displays the games logical components( in DataMatrix.cpp)
 
 REVISIONS: 
 05/26/2011 (eal) - wrote and implemented class basics
 06/06/2011 (eal) - code is clean ( organized and commented )
 06/07/2011 (eal) - will now save no more then MAX_SCORES scores
 06/08/2011 (eal) - altered ccTouchEnded to fix bug that caused pieces to be played
                    when player clicked above the board
                  - score is now decremented when play clicks bad gp and is animated
 
 ----------------------------------------------------------------*/


@interface GameScene : CCLayer {

    Hud *hud;     // for display of dynamic game data
    short lvlTime;
    
    // these variables are implemted here as opposed to the DataMatrix because
    // they do not effect the game logic
    short goal;    // score needed to pass level
    short bonus;   // not displayed
    
    Board* board;
    
} // end interface

// setup
// ====================================================
+(id) scene;
-(void) buttonSetup;


// game_control
// ====================================================
-(void) playLevel;
-(void) timePlus;

// button_selectors/nav
// ====================================================
-(void) goBack:(CCMenuItemLabel  *) menuItem ;
-(void) gameEnd;

// data
// ====================================================
-(void) saveStats;


@end

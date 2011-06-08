
// Copyright (c) 2011 Ethan Levien
// StatsScene.h

#import <Foundation/Foundation.h>
#import "Consts.h"
#import "cocos2d.h"
#import "HelloScene.h"
#import "Score.h"
#import "DataIOManager.h"

/*--------------------------------------------------------------
 Programmer: ethan levien
 
 SUMMARY: this scene is where the player can view past scores. it is
          automatically displayed after a game is over, or can be
          navigated to from hello scene. There are two interactive components:
          the back button( returns to hello scene) and the reset button
          ( resets scores history ). The class opens and decodes the file
          STATSFILE_DATA to obtian score information. The scores on displayed
          on dynamically allocated ttf labels whos references are stored in
          the scores[][] array
 
 
 REVISIONS: 
 05/26/2011 (eal) - wrote and implemented class basics
 06/06/2011 (eal) - code is clean ( organized and commented )
                  - moved io code to DataIOManager
 
 ----------------------------------------------------------------*/


@interface StatsScene : CCLayer {
   
    // pointers to labels for each number displayed
    // to be dynamically allocated as needed
    CCLabelTTF *scores[MAX_SCORES][SCORE_FIELDS];

} // end interface

// setup
// ====================================================
+(id) scene;
-(void) buttonSetup;
-(void) labelsSetup;


// button_selectors
// ====================================================

-(void) resetData:(CCMenuItemLabel  *) menuItem;
// PRE:  none 
// POST: all data in the scores array is removed
//       clear labels is called

-(void) goBack:(CCMenuItemLabel  *) menuItem ;
// POST: none
// PRE:  nav to hello scene

// display
// ====================================================
-(void) clearLabels;
// PRE:  none 
// POST: removes all ttf labels diplaying score data
//       from scenes children

-(void) displayStats:(NSMutableArray*) data;
// PRE: data is an array of NSData objects containing encoded
//      score objects
// POST: information is data is displayed, data is rewritten to
//       StatsData.plist with updated histories





@end
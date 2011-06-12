
// Copyright (c) 2011 Ethan Levien
// HelloScene.h

#import <Foundation/Foundation.h>
#import "Consts.h"
#import "cocos2d.h"
#import "GameScene.h"
#import "InfoScene.h"
#import "FadeTextButton.h"

/*--------------------------------------------------------------
 Programmer: ethan levien
 
 SUMMARY: this class is is the screen the user sees when they open the app.
          it's only functioning components are three buttons, each which 
          when touched navigates to one of the other two scenes( game,
          or rules). this scene is intended to be returned to throughout the 
          apps lifecyle because all other scenes back buttons navigate to this
          scene. in addition to providing navigation between the scenes copyright
          and other app info is displayed in this scene. 
 
 REVISIONS: 
 05/29/2011 (eal) - wrote and implemented class basics
 06/06/2011 (eal) - code is clean ( organized and commented )
 06/09/2011 (eal) - scene now diplays scores

 
 ----------------------------------------------------------------*/


@interface HelloScene : CCLayer {
    
    // no members
    
} // end interface

// setup
// ====================================================
+(id) scene;
-(void) buttonSetup;
-(void) displayStats;

// button_selectors
// ====================================================
-(void) goGame:(CCMenuItemLabel  *) menuItem ;
-(void) goStats:(CCMenuItemLabel  *) menuItem ;
-(void) goInfo:(CCMenuItemLabel  *) menuItem ;

@end
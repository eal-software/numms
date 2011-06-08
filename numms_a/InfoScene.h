
// Copyright (c) 2011 Ethan Levien
// InfoScene.h

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Consts.h"
#import "HelloScene.h"

/*--------------------------------------------------------------
 Programmer: ethan levien
 
 SUMMARY: this scene displays the rules. currently the only interactive
          component is the back button which navigates to the hello scene
 
 REVISIONS: 
 05/26/2011 (eal) - wrote and implemented class basics
 06/06/2011 (eal) - code is clean ( organized and commented )
 
 ----------------------------------------------------------------*/


@interface InfoScene : CCLayer {
    
    // no members
    
} // end interface

// setup
// ====================================================
+(id) scene;
-(void) buttonSetup;

// button_selectors
// ====================================================
-(void) goBack:(CCMenuItemLabel  *) menuItem ;

@end
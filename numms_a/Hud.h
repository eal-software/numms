
// Copyright (c) 2011 Ethan Levien
// Hud.h

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Consts.h"


/*--------------------------------------------------------------
 Programmer: ethan levien
 
 SUMMARY: 
 
 REVISIONS: 
 05/28/2011 (eal) - wrote class
 06/06/2011 (eal) - commented
 06/09/2011 (eal) - added progess bar
 
 ----------------------------------------------------------------*/


@interface Hud : CCNode {
    
     CCLabelTTF *score;
    
     CCSprite *pBarScore;
     CCSprite *pBarTime;
     CCSprite *pBarNegScore;

} // end interface


// setup
// ====================================================
-(void) labelSetup;
-(void) pBarSetup;
-(void) actionSetup;

// update_diplsay
// ====================================================
-(void) setScore:(short) s Level:(short) l Goal:(short) g;
// used everytime score or goal change

-(void) setTime:(short) t;
// when time changes

@end

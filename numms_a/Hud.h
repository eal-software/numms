
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

-(void) labelSetup;
-(void) pBarSetup;
-(void) actionSetup;

-(void) setScore:(short) s Level:(short) l Bonus:(short) b Goal:(short) g;

-(void) setTime:(short) t;

@end


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
 
 ----------------------------------------------------------------*/


@interface Hud : CCNode {
    
     CCLabelTTF *score;
     CCLabelTTF *bonus;
     CCLabelTTF *goal;
     CCLabelTTF *time;
     CCLabelTTF *level;

} // end interface

-(void) labelSetup;

-(void) setDispWithScore:(short) s Time:(short) t Level:(short) l Bonus:(short) b Goal:(short) g;

@end

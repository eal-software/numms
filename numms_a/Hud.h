
// Copyright (c) 2011 Ethan Levien

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Consts.h"


/*--------------------------------------------------------------
 Programmer: ethan levien
 
 SUMMARY: 
 
 REVISIONS: 
 05/28/2011 (eal) - 
 
 ----------------------------------------------------------------*/


@interface Hud : CCNode {
     CCLabelTTF *score;
     CCLabelTTF *bonus;
     CCLabelTTF *time;
     CCLabelTTF *level;
     CCSprite *pBar;

}

-(void) setDispWithScore:(short) s Time:(short) t Level:(short) l Bonus:(short) b;

@end

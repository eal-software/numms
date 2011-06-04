// Copyright (c) 2011 Ethan Levien

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Consts.h"

/*--------------------------------------------------------------
 Programmer: ethan levien
 
 SUMMARY: 
 todo - cache textures someplace else for better preformance
 
 REVISIONS: 
 05/26/2011 (eal) - wrote and implemented class basics
 
 ----------------------------------------------------------------*/


@interface Piece : CCNode {
    CGPoint gPos;
    short val;
    short type;
    CCLabelTTF *label;
	CCSprite *sprite;
}

-(void) setVal: (short) v;
-(void) setType: (short) t;
-(void) setGp: (CGPoint) gp;

// animations
-(void) birth;
-(void) death;
-(void) capture;

// this lets me cleaup as a selector
-(void) removeFromParentAutoCleanup;



@end

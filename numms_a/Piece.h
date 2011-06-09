// Copyright (c) 2011 Ethan Levien
// Piece.h

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Consts.h"

/*--------------------------------------------------------------
 Programmer: ethan levien
 
 SUMMARY: 
 todo - make "ctor" instead of having setters
      - maybe subclass for different types of pieces
      - in general re organize code surrounding how piece is captures
 
 
 REVISIONS: 
 05/26/2011 (eal) - wrote and implemented class basics
 06/08/2011 (eal) - moved code that drew numbers on score changes to
                    board
 
 ----------------------------------------------------------------*/


@interface Piece : CCNode {
    
    CGPoint gPos; // coords on grid
    
    // piece data 
    short val;
    short type;
    
    CCLabelTTF *label;
	CCSprite *sprite;
    
    
} // end interface

// setters
// ====================================================
-(void) setVal: (short) v;
-(void) setType: (short) t;
-(void) setGp: (CGPoint) gp;

// animations
// ====================================================
-(void) birth;
-(void) death;
-(void) capture; // changes to a human piece

// misc
// ====================================================
// this lets me cleaup as a selector
-(void) removeFromParentAutoCleanup;



@end


// Copyright (c) 2011 Ethan Levien

#import <Foundation/Foundation.h>
#import "SimpleAudioEngine.h"
#import "cocos2d.h"
#import "DataMatrix.h"
#import "Piece.h"
#import "Consts.h"

/*--------------------------------------------------------------
 Programmer: ethan levien
 
 SUMMARY: objective c container for datamatrix that also handles drawing, should be no game logic here!
 
 REVISIONS: 
 05/27/2011 (eal) - wrote and implemented class basics
 05/28/2011 (eal) - commented
 
 ----------------------------------------------------------------*/


@interface Board : CCNode {
	
    DataMatrix dMatrix;
    
}

-(short) score;
// PRE: none
// POST: returns score


-(short) level;
// PRE: none
// POST: returns level


-(void) nextLevel;
// PRE: level is < MAX_LVL
// POST: increments lvl on datamatrix

-(void) turn;
// PRE: none
// POST: ai takes a turn, updates dMatrix

-(void) reset; 
// PRE: none
// PRE: - dMatrix reset
//      - all children are removed

-(bool) placePieceAtGp:(CGPoint) gp;        
// PRE: gp is a valid board position
// POST: places human piece in dMatrix, returns true of sucess


-(void) displayBoard;
// PRE: none
// POST: the board is diplayed on the node

-(Piece*) pieceFromData: (CGPoint) gp;
// PRE: gp is a valid board position contianing a none-empty piece
// POST: returns a Piece* to represent that data




@end
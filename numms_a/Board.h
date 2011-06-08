
// Copyright (c) 2011 Ethan Levien
// Board.h

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
 06/07/2011 (eal) - code is clean( organized and commented)
 06/08/2011 (eal) - altered display board method to enable specific animations
                    to be called when piece is captured, born, or dies
 ----------------------------------------------------------------*/


@interface Board : CCNode {
	
    DataMatrix dMatrix;
    
}

// getters
// ====================================================
-(short) score;
// PRE: none
// POST: returns score


-(short) level;
// PRE: none
// POST: returns level

// game_control
// ====================================================

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


// display
// ====================================================
-(void) displayBoard;
// PRE: none
// POST: the board is diplayed on the node

-(Piece*) pieceFromData: (CGPoint) gp;
// PRE: gp is a valid board position contianing a none-empty piece
// POST: returns a Piece* to represent that data




@end
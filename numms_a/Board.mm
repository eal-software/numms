
// Copyright (c) 2011 Ethan Levien

#import "Board.h"


@implementation Board

// ----------------------------------------------------
-(id) init
{
	
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super  init])) {
        //[[SimpleAudioEngine sharedEngine] preloadEffect:@"wine.aif"];
        // cache piece textures
        [[CCTextureCache sharedTextureCache] addImage:@"p_6a.png"];
        [[CCTextureCache sharedTextureCache] addImage:@"p_6b.png"];
        [self displayBoard];
	}
	return self;
}

# pragma  mark - 
# pragma  mark getters

// ----------------------------------------------------

-(short) score{
    return dMatrix.score();
} // end score

// ----------------------------------------------------

-(short) level{
    return dMatrix.level();
} // end level

// ----------------------------------------------------

# pragma  mark - 
# pragma  mark matrix_control

-(void) nextLevel{
    dMatrix.setLevel(dMatrix.level()+1);
} // end nextLevel

// ----------------------------------------------------
-(void) turn{
    dMatrix.turn();
} // end update

// ----------------------------------------------------
-(void) reset{
    dMatrix.resetMatrix();
    [self removeAllChildrenWithCleanup:YES];
} // end reset

// ----------------------------------------------------
-(bool) placePieceAtGp:(CGPoint) gp{
    return dMatrix.placePiece_human(gp.x, gp.y);
} // end placePieceAtGposition

# pragma  mark - 
# pragma  mark display

// ----------------------------------------------------
-(void) displayBoard{
    for (int i = 0; i < GWIDTH; i++) {
        for (int j = 0; j < GHEIGHT-1; j++) {
            
            if (!dMatrix.drawn(i, j)) {
                if (dMatrix.type(i, j) != EMPTY) {
                    if ([self getChildByTag:i*10+j] != NULL) {
                        [(Piece*)[self getChildByTag:i*10+j] death];
                        
                        //[[SimpleAudioEngine sharedEngine] playEffect:@"wine.aif"];
                        
                        //[self removeChildByTag:i*10+j cleanup:YES]; 
                    }
                    [self addChild: [self pieceFromData:CGPointMake(i, j)]];
                    dMatrix.drawP(i, j);
                }else {
                    //[self removeChildByTag:i*10+j cleanup:YES]; 
                    [(Piece*)[self getChildByTag:i*10+j] death];
                    dMatrix.drawP(i, j);
                }
                
            } // end if
            
        } // end for
    } // end for   
} // end drawBoard

// ----------------------------------------------------
-(Piece*) pieceFromData: (CGPoint) gp{

    Piece* newPiece = [Piece node];
    [newPiece  setGp:gp];
    [newPiece  setVal:dMatrix.val(gp.x, gp.y)];
    newPiece.tag = gp.x*10+gp.y;
    [newPiece  setType:dMatrix.type(gp.x, gp.y)];
    return newPiece;

} // end pieceFromData

-(void) dealloc {
    [super dealloc];
    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
} // end dealloc

@end

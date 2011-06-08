
// Copyright (c) 2011 Ethan Levien
// Board.mm


#import "Board.h"


@implementation Board


#pragma mark - 
#pragma mark setup

// setup
// ====================================================

// ----------------------------------------------------
-(id) init
{

	if( (self=[super  init])) {
        
        effects = [[SoundEffectManager alloc] initEffects];
        
        // cache piece textures
        [[CCTextureCache sharedTextureCache] addImage:@"p_6a.png"];
        [[CCTextureCache sharedTextureCache] addImage:@"p_6b.png"];
        [self displayBoard];
	}
	return self;
} // end init

// ----------------------------------------------------
-(void) dealloc {
    [super dealloc];
    [effects release];
    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
} // end dealloc


#pragma mark - 
#pragma mark getters

// getters
// ====================================================

// ----------------------------------------------------
-(short) score{
    return dMatrix.score();
} // end score

// ----------------------------------------------------

-(short) level{
    return dMatrix.level();
} // end level

#pragma mark - 
#pragma mark game_control

// game_control
// ====================================================

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

#pragma mark - 
#pragma mark display

// display
// ====================================================

// ----------------------------------------------------
-(void) displayBoard{
    
    for (int i = 0; i < GWIDTH; i++) {
        for (int j = 0; j < GHEIGHT-1; j++) {
            
            switch (dMatrix.drawn(i, j)) {
                // captured
                // ----------------------------------------------------
                case CAPTURED:
                     [(Piece*)[self getChildByTag:i*10+j] capture];
                          [effects playCapture];
                    
                    break;
                // born
                // ----------------------------------------------------
                case BORN:
                    
                    if ([self getChildByTag:i*10+j] != NULL) {
                         [(Piece*)[self getChildByTag:i*10+j] death];  
                    }
                    
                     [self addChild: [self pieceFromData:CGPointMake(i, j)]];
                    break;
                    
                // died
                // ----------------------------------------------------
                case DIED:
                      [(Piece*)[self getChildByTag:i*10+j] death]; 
                    break;
    
                default:
                    break;
            }
            
            dMatrix.drawP(i, j);
            
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

@end

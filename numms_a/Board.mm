
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
        [[CCTextureCache sharedTextureCache] addImage:PLAYER_PIECE_SPRITE];
        [[CCTextureCache sharedTextureCache] addImage:AI_PIECE_SPRITE];
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
    [effects playLevel];
} // end nextLevel

// ----------------------------------------------------
-(void) turn{
    dMatrix.turn();
    [effects playPlace];
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

// ----------------------------------------------------
-(void) decrementScore{
    dMatrix.decrementScore();
    [effects playBad];
} // end decrementScore

// ----------------------------------------------------
-(void) gameOver{
    [effects playGameover];
} // end gameOver

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
                    [self animateScoreChange:dMatrix.val(i, j) atGP:ccp(i, j)];
                    
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

// ----------------------------------------------------
-(void) animateScoreChange:(short) val atGP:(CGPoint) gp{
    
    // setup string and color
    NSString *numStr;
    ccColor3B clr;
    if (val < 0) {
        clr = ccc3(225, 0, 0);
        numStr = [NSString stringWithFormat:@" %d", val];
    }else{
        clr =  ccc3(220, 196, 141);
        numStr = [NSString stringWithFormat:@" +%d", val];
    }
    
 
    CCLabelTTF *num = [CCLabelTTF 
                       labelWithString:numStr 
                       dimensions:CGSizeMake(150, 30)
                       alignment: UITextAlignmentCenter
                       fontName:STATS_FONT 
                       fontSize:30];

    num.opacity = 225;
    num.color = clr;
    num.position    = ccp([self boardToScreen:gp].x+40,[self boardToScreen:gp].y+40);
    
    [self addChild:num];
    id move = [CCMoveBy  actionWithDuration:2 position:ccp(0,200)];
    id fade = [CCFadeOut actionWithDuration:2];
    id animate = [CCSpawn actions:move,fade, nil];
    id remove = [CCCallFunc actionWithTarget:num selector:@selector(removeFromParentAndCleanup:)];
    
	[num  runAction:[CCSequence actions:animate,remove, nil]];
    
} // end animateScoreChange

// ----------------------------------------------------
-(CGPoint) boardToScreen:(CGPoint) gp{
    CCDirector *director = [CCDirector sharedDirector];
    return CGPointMake(
                       gp.x*([director winSize].width/(float)GWIDTH),
                       gp.y*([director winSize].height/(float)GHEIGHT));
} // end boardToScreen

@end

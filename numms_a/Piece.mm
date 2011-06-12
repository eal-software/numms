
// Copyright (c) 2011 Ethan Levien
// Piece.mm

#import "Piece.h"


@implementation Piece

#pragma mark - 
#pragma mark setup

// setup
// ====================================================

// ---------------------------------------------------
-(id) init
{
	if( (self=[super  init])) {

        self.anchorPoint = CGPointMake(0,0);
		
        label = [CCLabelTTF labelWithString:@"1" fontName:PIECE_FONT fontSize:50];
        label.anchorPoint = CGPointMake(0,0);
        label.position = CGPointMake(25,8);
        label.opacity = 225;
        	
	}
	return self;
} // end init

#pragma mark - 
#pragma mark setters

// setters
// ====================================================

// ---------------------------------------------------
-(void) setVal: (short) v {
    val = v;
    [label setString:[NSString stringWithFormat:@"%d", val]];
} // end setVal


// ---------------------------------------------------
-(void) setType: (short) t{
    type = t;
    if (type == HUMAN) {
        sprite = [CCSprite spriteWithTexture:[[CCTextureCache sharedTextureCache] addImage:PLAYER_PIECE_SPRITE]];
        sprite.anchorPoint = CGPointMake(0,0);
        sprite.opacity = 200;
        label.color = ccc3(0, 0, 0);
        [self addChild:sprite];
        [self addChild:label];
        
    }else if(type == AI){
        
        
        sprite = [CCSprite spriteWithTexture:[[CCTextureCache sharedTextureCache] addImage:AI_PIECE_SPRITE]];
        sprite.anchorPoint = CGPointMake(0,0);
        sprite.opacity = 225;
        label.color = ccc3(0, 0, 0);
        [self addChild:sprite];
        [self addChild:label];
    }

} // end setType

// ---------------------------------------------------
-(void) setGp: (CGPoint) gp{
    gPos = gp; 
    CCDirector *director = [CCDirector sharedDirector];
    self.position = CGPointMake(
                                gp.x*([director winSize].width/(float)GWIDTH),
                                gp.y*([director winSize].height/(float)GHEIGHT));
} // end setGp

#pragma mark - 
#pragma mark animations

// animation
// ====================================================

// ---------------------------------------------------
-(void) birth{
    
} // birth

// ---------------------------------------------------
-(void) death{
    
    
    //fade out:
    // this runs the fadeout action on the label
	// but then calls the second actions selector targeted to self

    id fade = [CCSequence actions: [CCFadeTo actionWithDuration:0.1 opacity:225], [CCFadeTo actionWithDuration:0.4 opacity:0],nil];
    
	id remove = [CCCallFunc actionWithTarget:self selector:@selector(removeFromParentAutoCleanup)];
    [label runAction:fade];
	[sprite  runAction:[CCSequence actions:fade, remove, nil]];
    
} // death

// ---------------------------------------------------
-(void) capture{
    
    [self removeAllChildrenWithCleanup:YES];
    
    label = [CCLabelTTF labelWithString:@"1" fontName:PIECE_FONT fontSize:50];
    label.anchorPoint = CGPointMake(0,0);
    label.position = CGPointMake(25,8);
    label.opacity = 225;
    [self setType:HUMAN];
    [self setVal:val];
    
 } // capture


#pragma mark - 
#pragma mark misc

// misc
// ====================================================

// ---------------------------------------------------
-(void) removeFromParentAutoCleanup
{
	[self removeFromParentAndCleanup:YES];
	
} // removeFromParentAutoCleanup

@end

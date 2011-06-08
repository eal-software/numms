
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
        sprite = [CCSprite spriteWithTexture:[[CCTextureCache sharedTextureCache] addImage:@"p_6a.png"]];
        sprite.anchorPoint = CGPointMake(0,0);
        sprite.opacity = 225;
        label.color = ccc3(0,0,0);
        [self addChild:sprite];
        [sprite addChild:label];
        
    }else if(type == AI){
        
        
        sprite = [CCSprite spriteWithTexture:[[CCTextureCache sharedTextureCache] addImage:@"p_6b.png"]];
        sprite.anchorPoint = CGPointMake(0,0);
        sprite.opacity = 225;
        label.color = ccc3(0,0,0);
        [self addChild:sprite];
        [sprite addChild:label];
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
	id a1;

    a1 = [CCFadeOut actionWithDuration: 0.5];
    
	id a2 = [CCCallFunc actionWithTarget:self selector:@selector(removeFromParentAutoCleanup)];
	[sprite  runAction:[CCSequence actions:a1, a2, nil]];
    
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
    
    // draw floating num
    NSString *numStr = [NSString stringWithFormat:@"+ %d", val];
    
    
    
    
   CCLabelTTF *num = [CCLabelTTF 
           labelWithString:numStr 
           dimensions:CGSizeMake(150, 40)
           alignment: UITextAlignmentLeft
           fontName:STATS_FONT 
           fontSize:40];
    num.opacity = 225;
    [self addChild:num];
    
    num.opacity = 225;
    num.anchorPoint = ccp(0,0);
    num.position    = ccp(0,0);
    num.color = ccc3(180, 180, 180);
    
    id a1 = [CCMoveBy  actionWithDuration:1 position:ccp(0,100)];
    id a2 = [CCFadeOut actionWithDuration:1];
    
    [num  runAction:a1];
    [num  runAction:a2];
    
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

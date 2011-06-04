
// Copyright (c) 2011 Ethan Levien

#import "Piece.h"


@implementation Piece

// ---------------------------------------------------
-(id) init
{
	
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super  init])) {

        self.anchorPoint = CGPointMake(0,0);
		// create and initialize a Label
        
		
		
   
		
        label = [CCLabelTTF labelWithString:@"1" fontName:PIECE_FONT fontSize:50];
        label.anchorPoint = CGPointMake(0,0);
        label.position = CGPointMake(25,8);
        label.opacity = 225;
        ///sprite = [CCSprite spriteWithFile:@"piece_a.png"];

        

	
	}
	return self;
} // end init


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

// ---------------------------------------------------
// animations

-(void) birth{
    
} // birth

-(void) death{
    // this runs the faceout action on the label
	// but then calls the second actions selector targeted to self
	id a1;

    a1 = [CCFadeOut actionWithDuration: 0.5];
    
	id a2 = [CCCallFunc actionWithTarget:self selector:@selector(removeFromParentAutoCleanup)];
	[sprite  runAction:[CCSequence actions:a1, a2, nil]];
    
} // death

-(void) capture{
    
} // capture


// house keeping ------------------------------------------------------------------------------------------------

-(void) removeFromParentAutoCleanup
{
	[self removeFromParentAndCleanup:YES];
	
} // removeFromParentAutoCleanup

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	
	[super dealloc];
}

@end

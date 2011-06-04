
// Copyright (c) 2011 Ethan Levien

#import "Hud.h"


@implementation Hud

// ----------------------------------------------------
-(id) init
{
	
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super  init])) {
                
       // pBar = [CCSprite spriteWithFile:@"progbar1.png"];
       // pBar.anchorPoint = ccp(0,0);
       // pBar.position = ccp(-320,400);
        //pBar.opacity = 200;
        
        CCDirector *director = [CCDirector sharedDirector];
        
        score = [CCLabelTTF labelWithString:@"  Score 0 " fontName:HUD_FONT fontSize:20];
        score.position = ccp([director winSize].width/2,440);
        score.color = ccc3(225, 225, 225);
        score.anchorPoint = CGPointMake(0, 0);
        score.opacity = 225;
        
        bonus = [CCLabelTTF labelWithString:@" + 0 " fontName:HUD_FONT fontSize:20];
        bonus.position = ccp([director winSize].width/2+90,440);
        bonus.color = ccc3(0, 225, 0);
        bonus.anchorPoint = CGPointMake(0, 0);
        bonus.opacity = 225;
        
        time = [CCLabelTTF labelWithString:@"  Time  0 " fontName:HUD_FONT fontSize:20];
        time.position = ccp([director winSize].width/2,420);
        time.color = ccc3(225, 225, 225);
        time.anchorPoint = CGPointMake(0, 0);
        time.opacity = 225;
        
        level = [CCLabelTTF labelWithString:@"  Goal   0 " fontName:HUD_FONT fontSize:20];
        level.position = ccp([director winSize].width/2,400);
        level.color = ccc3(225, 225, 225);
        level.anchorPoint = CGPointMake(0, 0);
        level.opacity = 225;
        



        [self addChild:score];
        [self addChild:bonus];
        [self addChild:level];
        [self addChild:time];
        //[self addChild:pBar];
        
	}
	return self;
}


// ----------------------------------------------------

-(void) setDispWithScore:(short) s Time:(short) t Level:(short) l Bonus:(short) b {
    if (s < l) {
        score.color = ccc3(225, 0, 0);
    }else{
        score.color = ccc3(225, 225, 225);
    }
    
    [score setString:[NSString stringWithFormat:@"  Score  %d ", s]];
    [bonus setString:[NSString stringWithFormat:@" + %d ", b]];
    [time setString:[NSString stringWithFormat:@"  Time   %d ", t]];
    [level setString:[NSString stringWithFormat:@"  Goal    %d ", l]];

    //pBar.position = ccp(s,400);
} // end setScoreDips

@end

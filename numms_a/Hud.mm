
// Copyright (c) 2011 Ethan Levien
// Hud.mm

#import "Hud.h"


@implementation Hud

// ----------------------------------------------------
-(id) init
{	

	if( (self=[super  init])) {
        [self labelSetup];        
	}
	return self;
    
} // end init

// ----------------------------------------------------
-(void) labelSetup{
    
    
    score = [CCLabelTTF labelWithString:@"  Score   0 " fontName:HUD_FONT fontSize:20];
    score.position = ccp(0,440);
    score.color = ccc3(225, 225, 225);
    score.anchorPoint = CGPointMake(0, 0);
    score.opacity = 225;
    
    bonus = [CCLabelTTF labelWithString:@" + 0 " fontName:HUD_FONT fontSize:20];
    bonus.position = ccp(100,440);
    bonus.color = ccc3(0, 225, 0);
    bonus.anchorPoint = CGPointMake(0, 0);
    bonus.opacity = 225;
    
    time = [CCLabelTTF labelWithString:@"  Time  0 " fontName:HUD_FONT fontSize:20];
    time.position = ccp(0,420);
    time.color = ccc3(225, 225, 225);
    time.anchorPoint = CGPointMake(0, 0);
    time.opacity = 225;
    
    level = [CCLabelTTF labelWithString:@"  Level  0 " fontName:HUD_FONT fontSize:20];
    level.position = ccp(0,400);
    level.color = ccc3(225, 225, 225);
    level.anchorPoint = CGPointMake(0, 0);
    level.opacity = 225;
    
    goal = [CCLabelTTF labelWithString:@"  Goal  0 " fontName:HUD_FONT fontSize:20];
    goal.position = ccp(100,400);
    goal.color = ccc3(225, 225, 225);
    goal.anchorPoint = CGPointMake(0, 0);
    goal.opacity = 225;
    
    
    
    
    [self addChild:score];
    [self addChild:goal];
    [self addChild:bonus];
    [self addChild:level];
    [self addChild:time];

} // end labelSetup

// ----------------------------------------------------
-(void) setDispWithScore:(short) s Time:(short) t Level:(short) l Bonus:(short) b Goal:(short)g {
   
    if (s < g) {
        score.color = ccc3(225, 0, 0);
    }else{
        score.color = ccc3(225, 225, 225);
    }
    
    [score setString:[NSString stringWithFormat:@"  Score   %d ", s,g]];
    [bonus setString:[NSString stringWithFormat:@" + %d ", b]];
    [time setString:[NSString stringWithFormat:@"  Time   %d ", t]];
    [level setString:[NSString stringWithFormat:@"  Level    %d ", l]];
    [goal setString:[NSString stringWithFormat:@"  Goal   %d ", g]];


} // end setScoreDips

@end

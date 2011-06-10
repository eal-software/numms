
// Copyright (c) 2011 Ethan Levien
// Hud.mm

#import "Hud.h"

// local consts
#define TBAR_Y 418
#define PBAR_Y 400


@implementation Hud

// ----------------------------------------------------
-(id) init
{	

	if( (self=[super  init])) {
   
        
        [self pBarSetup];
        [self labelSetup]; 
	}
	return self;
    
} // end init

// ----------------------------------------------------
-(void) labelSetup{
    
    
    score = [CCLabelTTF labelWithString:@" 0 " fontName:HUD_FONT fontSize:20];
    score.position = ccp(0,445);
    score.color = ccc3(225, 225, 225);
    score.anchorPoint = CGPointMake(0, 0);
    score.opacity = 0;
    
    bonus = [CCLabelTTF labelWithString:@" Bonus  0 " fontName:HUD_FONT fontSize:20];
    bonus.position = ccp(100,445);
    bonus.color = ccc3(225, 225, 225);
    bonus.anchorPoint = CGPointMake(0, 0);
    bonus.opacity = 225;

    
    level = [CCLabelTTF labelWithString:@"  Level  0 " fontName:HUD_FONT fontSize:20];
    level.position = ccp(0,445);
    level.color = ccc3(225, 225, 225);
    level.anchorPoint = CGPointMake(0, 0);
    level.opacity = 225;


    [self addChild:score];
   // [self addChild:bonus];
   // [self addChild:level];

} // end labelSetup


// ----------------------------------------------------
-(void) pBarSetup{
    
    CCDirector *director = [CCDirector sharedDirector];
    
    
    CCSprite *pBarBack1 = [CCSprite spriteWithFile:@"pBar1.png"];
    pBarBack1.anchorPoint = ccp(0,0);
    pBarBack1.position = ccp(0,PBAR_Y);
    [self addChild:pBarBack1];
    
    CCSprite *pBarBack2 = [CCSprite spriteWithFile:@"pBar1.png"];
    pBarBack2.anchorPoint = ccp(0,0);
    pBarBack2.position = ccp(0,TBAR_Y);
    [self addChild:pBarBack2];
    
    pBarTime = [CCSprite spriteWithFile:@"pBar_purple.png"];
    pBarTime.anchorPoint = ccp(0,0);
    pBarTime.position = ccp(-[director winSize].width,TBAR_Y);
    pBarTime.opacity = 70;
    [self addChild:pBarTime];
    
    pBarScore = [CCSprite spriteWithFile:@"pBar_green.png"];
    pBarScore.anchorPoint = ccp(0,0);
    pBarScore.position = ccp(-[director winSize].width,PBAR_Y);
    pBarScore.opacity = 40;
    [self addChild:pBarScore];
    
    pBarNegScore = [CCSprite spriteWithFile:@"pBar_red.png"];
    pBarNegScore.anchorPoint = ccp(0,0);
    pBarNegScore.position = ccp(-[director winSize].width,PBAR_Y);
    pBarNegScore.opacity = 0;
    [self addChild:pBarNegScore];
    
    CCSprite *pBarMask1 = [CCSprite spriteWithFile:@"pBar_mask1.png"];
    pBarMask1.anchorPoint = ccp(0,0);
    pBarMask1.position = ccp(0,PBAR_Y);
    [self addChild:pBarMask1];
    
    
    CCSprite *pBarMask2 = [CCSprite spriteWithFile:@"pBar_mask1.png"];
    pBarMask2.anchorPoint = ccp(0,0);
    pBarMask2.position = ccp(0,TBAR_Y);
    [self addChild:pBarMask2];

    
} // end pBarSetup

// ----------------------------------------------------
-(void) actionSetup{
    
} // end actionSetup

// ----------------------------------------------------
-(void) setScore:(short) s Level:(short) l Bonus:(short) b Goal:(short) g;{

    CCDirector *director = [CCDirector sharedDirector];
    float scoreDist = ((float)s)/((float)g);
    CGPoint scoreLoc;
    CGPoint barLoc;
    ccColor3B scoreColer;
    
    
    if (scoreDist > 1) { // have reached the goal
        scoreLoc = ccp(0.90*[director winSize].width,PBAR_Y);
        barLoc = ccp(0,PBAR_Y);
        scoreColer = ccc3(0, 225, 0);

    }else if (s < 0 ) { // handle negative scores
        scoreLoc = ccp(10,PBAR_Y);
        barLoc = ccp(-[director winSize].width,PBAR_Y);
        scoreColer = ccc3(225, 0, 0);

    }else{ // normal scores
        
        scoreLoc = ccp(scoreDist*[director winSize].width,PBAR_Y);
        barLoc = ccp(-[director winSize].width+scoreDist*[director winSize].width,PBAR_Y);
        scoreColer = ccc3(225, 225, 225);
    }
    
    // move progress bar
    id moveScoreBar = 
    [CCMoveTo actionWithDuration:1 position:barLoc];
    [pBarScore runAction:moveScoreBar];

    
   // draw score above bar
    [score setString:[NSString stringWithFormat:@" %d ", s]];
    score.color = scoreColer;
    id fadeInAndOut = [CCSequence actions:[CCFadeIn actionWithDuration:1], [CCFadeOut actionWithDuration:1], nil];
    score.position = scoreLoc;
    [score runAction:fadeInAndOut];
    
   // [bonus setString:[NSString stringWithFormat:@" Bonus  %d ", b]];
   // [level setString:[NSString stringWithFormat:@"  Level  %d ", l]];



} // end setScoreDips

// ----------------------------------------------------
-(void) setTime:(short) t{
    
    float timeDist = ((float)t)/((float)LVL_TIME);
    
    CCDirector *director = [CCDirector sharedDirector];
    id moveTimeBar = [CCMoveTo actionWithDuration:1 position:ccp(-[director winSize].width+timeDist*[director winSize].width,TBAR_Y)];
    
    
    [pBarTime runAction:moveTimeBar];


    
} // end setTime

@end

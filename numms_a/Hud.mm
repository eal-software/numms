
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
    
    
    score = [CCLabelTTF labelWithString:@" 0 " fontName:HUD_FONT fontSize:40];
    score.position = ccp(0,430);
    score.color = ccc3(225, 225, 225);
    score.anchorPoint = CGPointMake(0, 0);
    score.opacity = 100;

    [self addChild:score];

} // end labelSetup


// ----------------------------------------------------
-(void) pBarSetup{
    
    CCDirector *director = [CCDirector sharedDirector];
    
    
    CCSprite *pBarBack1 = [CCSprite spriteWithFile:@"pbar_greenback.png"];
    pBarBack1.anchorPoint = ccp(0,0);
    pBarBack1.position = ccp(0,PBAR_Y);
    [self addChild:pBarBack1];
    
    CCSprite *pBarBack2 = [CCSprite spriteWithFile:@"pbar_yellowback.png"];
    pBarBack2.anchorPoint = ccp(0,0);
    pBarBack2.position = ccp(0,TBAR_Y);
    [self addChild:pBarBack2];
    
    
    pBarScore = [CCSprite spriteWithFile:@"pbar_green.png"];
    pBarScore.anchorPoint = ccp(0,0);
    pBarScore.position = ccp(-[director winSize].width,PBAR_Y);
    pBarScore.opacity = 225;
    [self addChild:pBarScore];
    
    pBarTime = [CCSprite spriteWithFile:@"pbar_yellow.png"];
    pBarTime.anchorPoint = ccp(0,0);
    pBarTime.position = ccp(-[director winSize].width,TBAR_Y);
    pBarTime.opacity = 225;
    [self addChild:pBarTime];

    
    CCSprite *pBarMask1 = [CCSprite spriteWithFile:@"pbar_mask.png"];
    pBarMask1.anchorPoint = ccp(0,0);
    pBarMask1.position = ccp(0,PBAR_Y);
    [self addChild:pBarMask1];
    
    
    CCSprite *pBarMask2 = [CCSprite spriteWithFile:@"pbar_mask.png"];
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
    CGPoint barLoc;
    ccColor3B scoreColer;
    
    
    if (scoreDist > 1) { // have reached the goal

        barLoc = ccp(0,PBAR_Y);
        scoreColer = ccc3(74, 148, 52);
    


    }else if (s < 0 ) { // handle negative scores

        barLoc = ccp(-[director winSize].width,PBAR_Y);       
        scoreColer = ccc3(225, 0, 0);

    }else{ // normal scores
        
        barLoc = ccp(-[director winSize].width+scoreDist*[director winSize].width,PBAR_Y);

        scoreColer = ccc3(220, 196, 141);


    }
    
    // move progress bar
    id moveScoreBar = 
    [CCMoveTo actionWithDuration:1 position:barLoc];
    [pBarScore runAction:moveScoreBar];

    
   // draw score above bar
    [score setString:[NSString stringWithFormat:@" %d ", s]];
    score.color = scoreColer;
    id fadeInAndOut = [CCSequence actions:[CCFadeTo actionWithDuration:1 opacity:225], 
                       [CCFadeTo actionWithDuration:1 opacity:100], nil];
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

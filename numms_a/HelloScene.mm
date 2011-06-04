
// Copyright (c) 2011 Ethan Levien

#import "HelloScene.h"


@implementation HelloScene


// ----------------------------------------------------
+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloScene *layer = [HelloScene node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
} // end scene



// ----------------------------------------------------
-(id) init
{
	
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super  init])) {
        
        CCSprite* backsprite = [CCSprite spriteWithFile:@"bg_hello1.png"];
		[self addChild:backsprite];
		backsprite.anchorPoint = ccp(0,0);
		backsprite.position = ccp(0,0);
        
        
        [self menuSetup];
        self.isTouchEnabled = YES;
	}
	return self;
}

// ----------------------------------------------------
-(void) menuSetup{
    

    //CCDirector *director = [CCDirector sharedDirector];
    
    // setup buttons
    
    //CGPoint menuPos = CGPointMake(
    //                              ([director winSize].width/2),
    //                              ([director winSize].height/2));
    

    
    // labels
    CCLabelTTF *gameLabel = [CCLabelTTF labelWithString:@"Play" fontName:MENU_FONT fontSize:40];
    gameLabel.opacity = 170;
    gameLabel.color = ccc3(225, 225, 225);
    FadeTextButton *game = [FadeTextButton  itemWithLabel: gameLabel target:self  selector: @selector(goGame:)];
    game.anchorPoint = ccp(0,0);
    game.position = ccp(0,80);
    
    CCLabelTTF *statsLabel = [CCLabelTTF labelWithString:@"Scores" fontName:MENU_FONT fontSize:40];
    statsLabel.opacity = 170;
    statsLabel.color = ccc3(225, 225, 225);
    FadeTextButton *stats = [FadeTextButton  itemWithLabel: statsLabel target:self  selector: @selector(goStats:)];
    stats.anchorPoint = ccp(0,0);
    stats.position = ccp(0,40);
    
    CCLabelTTF *infoLabel = [CCLabelTTF labelWithString:@"?" fontName:MENU_FONT fontSize:40];
    infoLabel.opacity = 170;
    infoLabel.color = ccc3(225, 225, 225);
    FadeTextButton *info = [FadeTextButton  itemWithLabel: infoLabel target:self  selector: @selector(goInfo:)];
    info.anchorPoint = ccp(0,0);
    info.position = ccp(0,0);
    
    CCMenu *menu = [CCMenu menuWithItems: game, stats, info, nil];
   

    
    [menu setAnchorPoint:ccp(0,0)];
    [menu setPosition:ccp(100,150)];
    
   // [menu alignItemsVertically];
    [self addChild:menu];
    
    
    
} // end menuSetup

// navigation

// ----------------------------------------------------

-(void) goGame:(CCMenuItemLabel  *) menuItem {
    //[[CCDirector sharedDirector] replaceScene:[GameScene scene]];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:SCENE_TRANS_TIME scene:[GameScene scene]]];
} // end goPlay


// ----------------------------------------------------

-(void) goStats:(CCMenuItemLabel  *) menuItem {
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:SCENE_TRANS_TIME scene:[StatsScene scene]]];
} // end goStats

// ----------------------------------------------------

-(void) goInfo:(CCMenuItemLabel  *) menuItem {
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:SCENE_TRANS_TIME scene:[InfoScene scene]]];
} // end goInfo

@end

// Copyright (c) 2011 Ethan Levien

#import "InfoScene.h"


@implementation InfoScene


// ----------------------------------------------------
+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	InfoScene *layer = [InfoScene node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
} // end scene


// ----------------------------------------------------
-(id) init
{

	if( (self=[super  init])) {
        
        CCSprite* backsprite = [CCSprite spriteWithFile:@"rules1.png"];
		[self addChild:backsprite];
		backsprite.anchorPoint = ccp(0,0);
		backsprite.position = ccp(0,0);
        
        // setup back button
        CCLabelTTF *backLabel = [CCLabelTTF labelWithString:@"Back" fontName:MENU_FONT fontSize:40];
        backLabel.opacity = 100;
        FadeTextButton  *back = [FadeTextButton itemWithLabel:backLabel target:self selector:@selector(goBack:)];
        CCMenu *menu = [CCMenu menuWithItems: back,nil];
        [backLabel setAnchorPoint:CGPointMake(0, 0)];
        [backLabel setPosition:ccp(0,0)];
        [back setAnchorPoint:CGPointMake(0, 0)];
        [back setPosition:ccp(25,410)];        
        [menu setAnchorPoint:ccp(0,0)];
        [menu setPosition:ccp(0,0)];
        
        
        // add
        [self addChild:menu];
	}
	return self;
}

-(void) goBack:(CCMenuItemLabel  *) menuItem {
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:SCENE_TRANS_TIME scene:[HelloScene scene]]];
} // end goBack

@end

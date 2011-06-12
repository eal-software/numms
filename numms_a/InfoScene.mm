// Copyright (c) 2011 Ethan Levien
// InfoScene.mm

#import "InfoScene.h"


@implementation InfoScene

#pragma mark - 
#pragma mark setup

// setup
// ====================================================

// ----------------------------------------------------
+(id) scene
{

	CCScene *scene = [CCScene node];
	InfoScene *layer = [InfoScene node];
	[scene addChild: layer];
	return scene;
    
} // end scene

// ----------------------------------------------------
-(id) init
{

	if( (self=[super  init])) {
        
       // CCSprite* backsprite = [CCSprite spriteWithFile:RULES_SPRITE];
	   // [self addChild:backsprite];
       // [self buttonSetup];
       // backsprite.anchorPoint = ccp(0,0);
		//backsprite.position = ccp(0,0);

    }
	return self;
} // end init

// ----------------------------------------------------
-(void) buttonSetup{
    

    // back
    CCLabelTTF *backLabel = [CCLabelTTF labelWithString:BACK_TEXT fontName:MENU_FONT fontSize:NAV_BUTTON_SIZE];
    backLabel.opacity = BUTTON_OPACITY;
    backLabel.color = ccc3(225, 225, 225);
    FadeTextButton *back = [FadeTextButton  itemWithLabel: backLabel target:self  selector: @selector(goBack:)];
    back.anchorPoint = ccp(0,0);
    back.position = ccp(10,10);
    
    // add to menu and as child
    CCMenu *menu = [CCMenu menuWithItems: back,nil];
    [menu setAnchorPoint:ccp(0,0)];
    [menu setPosition:ccp(0,0)];
    [self addChild:menu];

} // end buttonSetup

#pragma mark - 
#pragma mark button_selectors

// button_selectors
// ====================================================

// ----------------------------------------------------
-(void) goBack:(CCMenuItemLabel  *) menuItem {
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:SCENE_TRANS_TIME scene:[HelloScene scene]]];
} // end goBack

@end

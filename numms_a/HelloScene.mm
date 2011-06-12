
// Copyright (c) 2011 Ethan Levien
// HelloScene.mm

#import "HelloScene.h"


@implementation HelloScene

#pragma mark - 
#pragma mark setup

// setup
// ====================================================

// ----------------------------------------------------
+(id) scene
{
    
	CCScene *scene = [CCScene node];
	HelloScene *layer = [HelloScene node];
	[scene addChild: layer];
	return scene;
    
} // end scene

// ----------------------------------------------------
-(id) init
{
	if( (self=[super  init])) {
        
   
        
         //add background sprite
        CCSprite* backsprite = [CCSprite spriteWithFile:BACKGROUND_HELLO];
		[self addChild:backsprite];
		backsprite.anchorPoint = ccp(0,0);
		backsprite.position = ccp(0,0);



        [self displayStats];
        // setup buttons and enable touch
        [self buttonSetup];
        self.isTouchEnabled = YES;
	}
	return self;
} // end init

// ----------------------------------------------------
-(void) buttonSetup{

    // 
    short buttonsY = 100;
    short buttonsX = 10;
    
    // three buttons:
    // play
    CCLabelTTF *gameLabel = [CCLabelTTF labelWithString:@"Play" fontName:MENU_FONT fontSize:150];
    gameLabel.opacity = BUTTON_OPACITY;
    gameLabel.color = ccc3(0, 0, 0);
    FadeTextButton *game = [FadeTextButton  itemWithLabel: gameLabel target:self  selector: @selector(goGame:)];
    game.anchorPoint = ccp(0,0);
    game.position = ccp(buttonsX,buttonsY+60);
    
    // ?(rules)
    CCLabelTTF *infoLabel = [CCLabelTTF labelWithString:@"Rules" fontName:MENU_FONT fontSize:75];
    infoLabel.opacity = BUTTON_OPACITY;
    infoLabel.color = ccc3(0, 0, 0);
    FadeTextButton *info = [FadeTextButton  itemWithLabel: infoLabel target:self  selector: @selector(goInfo:)];
    info.anchorPoint = ccp(0,0);
    info.position = ccp(buttonsX+7,buttonsY);
    
    CCMenu *menu = [CCMenu menuWithItems: game, info, nil];
   
    [menu setAnchorPoint:ccp(0,0)];
    // NOTE: here i set the position of each button explicitly because
    // aligning them vertically with the menu creates a ugly vertical gap between each button
    [menu setPosition:ccp(0,0)];
    
    [self addChild:menu];
    
} // end menuSetup


// ----------------------------------------------------
-(void) displayStats{
    
    
    DataIOManager *io = [DataIOManager dataIOManager];
    // sums
    CCLabelTTF *greatestLbl = 
    [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Best: %d ", [io readGreatest]]                   
                     dimensions:CGSizeMake(320,STATS_DISP_SIZE) 
                      alignment:UITextAlignmentLeft 
                       fontName:STATS_FONT 
                       fontSize:STATS_DISP_SIZE];
    
    greatestLbl.opacity = 225;
    greatestLbl.color = ccc3(220,196,148);
    greatestLbl.anchorPoint = ccp(0,0);
    greatestLbl.position = ccp(10,420);
    [self addChild:greatestLbl];
    
    
    // sums
    CCLabelTTF *lastLbl = 
    [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Last: %d ", [io readLast]]                   
                     dimensions:CGSizeMake(320,STATS_DISP_SIZE) 
                      alignment:UITextAlignmentLeft 
                       fontName:STATS_FONT 
                       fontSize:STATS_DISP_SIZE];
    
    lastLbl.opacity = 225;
    lastLbl.color = ccc3(220,196,148);
    lastLbl.anchorPoint = ccp(0,0);
    lastLbl.position = ccp(10,420-STATS_DISP_SIZE);
    [self addChild:lastLbl];
    
} // end dislayStats


#pragma mark - 
#pragma mark button_selectors

// button_selectors
// ====================================================

// ----------------------------------------------------
-(void) goGame:(CCMenuItemLabel  *) menuItem {
    [[CCDirector sharedDirector] replaceScene:
     [CCTransitionFade transitionWithDuration:SCENE_TRANS_TIME scene:[GameScene scene]]];
} // end goPlay


// ----------------------------------------------------
-(void) goInfo:(CCMenuItemLabel  *) menuItem {
    [[CCDirector sharedDirector] replaceScene:
     [CCTransitionFade transitionWithDuration:SCENE_TRANS_TIME scene:[InfoScene scene]]];
} // end goInfo

@end

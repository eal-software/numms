
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
        
   
        
        // add background sprite
       // CCSprite* backsprite = [CCSprite spriteWithFile:HELLO_BACKGROUND_SPRITE];
		//[self addChild:backsprite];
		//backsprite.anchorPoint = ccp(0,0);
		//backsprite.position = ccp(0,0);



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
    short buttonsY = 200;
    short buttonsX = 130;
    
    // three buttons:
    // play
    CCLabelTTF *gameLabel = [CCLabelTTF labelWithString:@"Play" fontName:MENU_FONT fontSize:NAV_BUTTON_SIZE];
    gameLabel.opacity = BUTTON_OPACITY;
    gameLabel.color = ccc3(225, 225, 225);
    FadeTextButton *game = [FadeTextButton  itemWithLabel: gameLabel target:self  selector: @selector(goGame:)];
    game.anchorPoint = ccp(0,0);
    game.position = ccp(buttonsX,buttonsY+2*(NAV_BUTTON_SIZE-10));
    
    // scores 
    /*CCLabelTTF *statsLabel = [CCLabelTTF labelWithString:@"Scores" fontName:MENU_FONT fontSize:NAV_BUTTON_SIZE];
    statsLabel.opacity = BUTTON_OPACITY;
    statsLabel.color = ccc3(225, 225, 225);
    FadeTextButton *stats = [FadeTextButton  itemWithLabel: statsLabel target:self  selector: @selector(goStats:)];
    stats.anchorPoint = ccp(0,0);
    stats.position = ccp(buttonsX,buttonsY+(NAV_BUTTON_SIZE-10));*/
    
    // ?(rules)
    CCLabelTTF *infoLabel = [CCLabelTTF labelWithString:@"?" fontName:MENU_FONT fontSize:NAV_BUTTON_SIZE];
    infoLabel.opacity = BUTTON_OPACITY;
    infoLabel.color = ccc3(225, 225, 225);
    FadeTextButton *info = [FadeTextButton  itemWithLabel: infoLabel target:self  selector: @selector(goInfo:)];
    info.anchorPoint = ccp(0,0);
    info.position = ccp(buttonsX,buttonsY+(NAV_BUTTON_SIZE-10));
    
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
    [CCLabelTTF labelWithString:[NSString stringWithFormat:@" Greatest: %d ", [io readGreatest]]                   
                     dimensions:CGSizeMake(320,STATS_DISP_SIZE) 
                      alignment:UITextAlignmentLeft 
                       fontName:STATS_FONT 
                       fontSize:STATS_DISP_SIZE];
    
    greatestLbl.opacity = BUTTON_OPACITY;
    greatestLbl.anchorPoint = ccp(0,0);
    greatestLbl.position = ccp(10,450);
    [self addChild:greatestLbl];
    
    
    // sums
    CCLabelTTF *lastLbl = 
    [CCLabelTTF labelWithString:[NSString stringWithFormat:@" Last: %d ", [io readLast]]                   
                     dimensions:CGSizeMake(320,STATS_DISP_SIZE) 
                      alignment:UITextAlignmentLeft 
                       fontName:STATS_FONT 
                       fontSize:STATS_DISP_SIZE];
    
    lastLbl.opacity = BUTTON_OPACITY;
    lastLbl.anchorPoint = ccp(0,0);
    lastLbl.position = ccp(10,450-STATS_DISP_SIZE);
    [self addChild:lastLbl];
    
} // end dislayStats


#pragma mark - 
#pragma mark button_selectors

// button_selectors
// ====================================================

// ----------------------------------------------------
-(void) goGame:(CCMenuItemLabel  *) menuItem {
    //[[CCDirector sharedDirector] replaceScene:[GameScene scene]];
    [[CCDirector sharedDirector] replaceScene:
     [CCTransitionFade transitionWithDuration:SCENE_TRANS_TIME scene:[GameScene scene]]];
} // end goPlay


// ----------------------------------------------------
-(void) goStats:(CCMenuItemLabel  *) menuItem {

   //
    
} // end goStats

// ----------------------------------------------------
-(void) goInfo:(CCMenuItemLabel  *) menuItem {
    //[[CCDirector sharedDirector] replaceScene:
     //[CCTransitionFade transitionWithDuration:SCENE_TRANS_TIME scene:[InfoScene scene]]];
} // end goInfo

@end

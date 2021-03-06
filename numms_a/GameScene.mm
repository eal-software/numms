// Copyright (c) 2011 Ethan Levien
// GameScene.mm

#import "GameScene.h"


@implementation GameScene

#pragma mark - 
#pragma mark setup

// setup
// ====================================================

// ----------------------------------------------------
+(id) scene
{

	CCScene *scene = [CCScene node];
	GameScene *layer = [GameScene node];
	[scene addChild: layer];
	return scene;
    
} // end scene



// ----------------------------------------------------
-(id) init
{
	

	if( (self=[super  init])) {
        
        //add background sprite
        CCSprite* backsprite = [CCSprite spriteWithFile:BACKGROUND_GAME];
		[self addChild:backsprite];
		backsprite.anchorPoint = ccp(0,0);
		backsprite.position = ccp(0,0);
                
        [self buttonSetup];
       
        board = [Board node];
        hud = [Hud node];
        
        [self addChild:hud];
        [self addChild:board];
        
        
        self.isTouchEnabled = YES;

        [self playLevel];


	}
	return self;
} // end init

// ----------------------------------------------------
-(void) buttonSetup{
    
    CCDirector *director = [CCDirector sharedDirector];
    
    // back
    CCLabelTTF *backLabel = [CCLabelTTF labelWithString:BACK_TEXT fontName:MENU_FONT fontSize:NAV_BUTTON_SIZE];
    backLabel.opacity = BUTTON_OPACITY;
    backLabel.color = ccc3(131, 93, 114);
    FadeTextButton *back = [FadeTextButton  itemWithLabel: backLabel target:self  selector: @selector(goBack:)];
    back.anchorPoint = ccp(0,0);
    back.position = ccp([director winSize].width/4*2+55,430);
    
    // add to menu and as child
    CCMenu *menu = [CCMenu menuWithItems: back,nil];
    [menu setAnchorPoint:ccp(0,0)];
    [menu setPosition:ccp(0,0)];
    [self addChild:menu];
    
} // end buttonSetup

#pragma mark - 
#pragma mark game_control

// game_control
// ====================================================

// ----------------------------------------------------
-(void) playLevel{
    lvlTime = LVL_TIME;
    goal = 2*[board level]*[board level] + [board score];
    [hud setScore:[board score] Level:[board level] Goal:goal];  // <--------- hud score updated
    [self schedule:@selector(timePlus) interval:LVL_SPEED];
    
} // end playLevel

// ----------------------------------------------------
-(void) timePlus{
    
    [hud setTime:lvlTime];
    if (lvlTime > 0) {
        lvlTime--;
    }else{
        if ([board score] >= goal) {
            [self unschedule:@selector(timePlus)];
            [board nextLevel];
            [self playLevel];
        }else{
            [self unschedule:@selector(timePlus)];     // <--------- hud time updated
            [board gameOver];
            [self gameEnd];
        }
    }
    
} // end timePlus

#pragma mark - 
#pragma mark button_selectors/nav

// button_selectors/nav
// ====================================================

// ----------------------------------------------------
-(void) goBack:(CCMenuItemLabel  *) menuItem {
    [[CCDirector sharedDirector] replaceScene:
     [CCTransitionFade transitionWithDuration:SCENE_TRANS_TIME scene:[HelloScene scene]]];
} // end goBack

// ----------------------------------------------------
-(void) gameEnd{
    [self saveStats];
    self.isTouchEnabled = NO;
    CCDirector *director = [CCDirector sharedDirector];
    
    CCLabelTTF *gameOver = [CCLabelTTF labelWithString:@"Game Over" fontName:MENU_FONT fontSize:50];
    gameOver.opacity = 0;
    gameOver.color =  ccc3(131, 93, 114);
    gameOver.position = ccp([director winSize].width/2,[director winSize].height/2);
    [self addChild:gameOver];
    
    id fade = [CCSequence actions:[CCFadeIn actionWithDuration:1],[CCFadeTo actionWithDuration:2 opacity:224],nil];
    id remove = [CCCallFunc actionWithTarget:self selector:@selector(gameExit)];
    
    [gameOver runAction:[CCSequence actions:fade, remove, nil]];
   
} // end gameEnd

-(void) gameExit{
     [[CCDirector sharedDirector] replaceScene:
      [CCTransitionFade transitionWithDuration:SCENE_TRANS_TIME scene:[HelloScene scene]]];
} // gameExit

#pragma mark - 
#pragma mark data

// data
// ====================================================

// ----------------------------------------------------
-(void) saveStats{
   
    DataIOManager *io = [DataIOManager dataIOManager];
    
    
    short greatest = [io readGreatest];
    if ([board score] > greatest) {
        [io writeGreatest:[board score]];
    }
    [io writeLast:[board score]];
   
    
} // end saveStats



#pragma mark - 
#pragma mark touch

// touch
// ====================================================

// ----------------------------------------------------
-(void) registerWithTouchDispatcher
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
} // registerWithTouchDispatcher

// ----------------------------------------------------
- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    return YES;
} // ccTouchBegan

// ----------------------------------------------------
- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
	
	
	self.isTouchEnabled = NO;
	
	CCDirector *director= [CCDirector sharedDirector];
    
	CGPoint location = [self convertTouchToNodeSpace: touch];
	CGPoint gp = CGPointMake(
                             (int)(location.x*((double)GWIDTH/[director winSize].width)),
                             (int)(location.y*((double)GHEIGHT/[director winSize].height))
                             ) ;
    if (gp.y < 5) {  // make sure we are on the board
        if ([board placePieceAtGp:gp]) {
            [board displayBoard];
            [board turn];
            [board displayBoard];
            
        }else{
            
           [board decrementScore];
           [board animateScoreChange:(-1) atGP:gp];
            
        } // end else
        [hud setScore:[board score] Level:[board level] Goal:goal];    // <--------- hud score updated


    } // end if
  		
    self.isTouchEnabled = YES;
	
} // ccTouchEnded



@end

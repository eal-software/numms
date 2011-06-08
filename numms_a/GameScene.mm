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
        
        // add background sprite
        CCSprite* backsprite = [CCSprite spriteWithFile:@"bg_grid4.png"];
		[self addChild:backsprite];
		backsprite.anchorPoint = ccp(0,0);
		backsprite.position = ccp(0,0);

                
        [self buttonSetup];
       
        board = [Board node];
        hud = [Hud node];
        
        [self addChild:board];
        [self addChild:hud];
        
        self.isTouchEnabled = YES;
        
        bonus = 0;
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
    backLabel.color = ccc3(225, 225, 225);
    FadeTextButton *back = [FadeTextButton  itemWithLabel: backLabel target:self  selector: @selector(goBack:)];
    back.anchorPoint = ccp(0,0);
    back.position = ccp([director winSize].width/4*2+35,415);
    
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
    goal = 5*[board level] + [board score];
    [self schedule:@selector(timePlus) interval:LVL_SPEED];
    
} // end playLevel

// ----------------------------------------------------
-(void) timePlus{
    
    [hud setDispWithScore:[board score] Time:lvlTime Level:[board level] Bonus:bonus Goal: goal];
    if (lvlTime >= 0) {
        lvlTime--;
    }else{
        if ([board score] >= goal) {
            bonus = bonus + ( [board score] - goal );
            [board nextLevel];
            [self playLevel];
        }else{
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
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:SCENE_TRANS_TIME scene:[HelloScene scene]]];
} // end goBack

// ----------------------------------------------------
-(void) gameEnd{
    [self saveStats];
    [[CCDirector sharedDirector] replaceScene:[StatsScene scene]];
} // end gameEnd


#pragma mark - 
#pragma mark data

// data
// ====================================================

// ----------------------------------------------------
-(void) saveStats{
   
    DataIOManager *io = [DataIOManager dataIOManager];
    
    NSMutableArray *data = [io readStats];
    
    NSComparator sort = ^(id d1, id d2){
        Score *s1 = [NSKeyedUnarchiver unarchiveObjectWithData:d1];
        Score *s2 = [NSKeyedUnarchiver unarchiveObjectWithData:d2];
        return [[NSNumber numberWithInt:[s2 level]] compare:[NSNumber numberWithInt:[s1 level]]];
    };

    [data addObject:[NSKeyedArchiver archivedDataWithRootObject:
                        [Score scoreWithLvl:[board level] Sum:[board score] Bonus:bonus History:0]]];
    [data sortUsingComparator:sort];
    
    // remove objects st. array is less then 21 elements
    while ([data count] > MAX_SCORES) {
        [data removeLastObject];
    }

    [io writeStats:data];
   
    
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
   
    if ([board placePieceAtGp:gp]) {
        [board displayBoard];
        [board turn];
        [board displayBoard];
        [hud setDispWithScore:[board score] Time:lvlTime Level:[board level] Bonus:bonus Goal: goal];
    }
		
    self.isTouchEnabled = YES;
	
} // ccTouchEnded



@end

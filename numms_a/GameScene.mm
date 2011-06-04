// Copyright (c) 2011 Ethan Levien

#import "GameScene.h"


@implementation GameScene

// ----------------------------------------------------
+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameScene *layer = [GameScene node];
	
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
        
       // CCSprite* backsprite = [CCSprite spriteWithFile:@"bg_grid3.png"];
		//[self addChild:backsprite];
       // backsprite.opacity = 225;
		//backsprite.anchorPoint = ccp(0,0);
		//backsprite.position = ccp(0,0);
       
        // setup back button
        CCLabelTTF *backLabel = [CCLabelTTF labelWithString:@"Back" fontName:MENU_FONT fontSize:40];
        backLabel.opacity = 100;
        FadeTextButton  *back = [FadeTextButton itemWithLabel:backLabel target:self selector:@selector(goBack:)];
        CCMenu *menu = [CCMenu menuWithItems: back,nil];
        [backLabel setAnchorPoint:CGPointMake(0, 0)];
        [backLabel setPosition:ccp(0,0)];
        [back setAnchorPoint:CGPointMake(0, 0)];
        [back setPosition:ccp(50,410)];        
        [menu setAnchorPoint:ccp(0,0)];
        [menu setPosition:ccp(0,0)];
        
        // add
    

        
        board = [Board node];
        hud = [Hud node];
        
        [self addChild:board];
        [self addChild:hud];
        [self addChild:menu];
        self.isTouchEnabled = YES;
        bonus = 0;
        [self playLevel];

        


	}
	return self;
}

# pragma mark -
# pragma mark game

// ----------------------------------------------------
-(void) playLevel{
    lvlTime = 0;
    goal = [board level]*[board level];
    [self schedule:@selector(timePlus) interval:0.1];
    
} // end playLevel

// ----------------------------------------------------
-(void) timePlus{
    [hud setDispWithScore:[board score] Time:lvlTime Level:goal Bonus:bonus];
    if (lvlTime < 50) {
        lvlTime++;
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

# pragma mark -
# pragma mark nav

// ----------------------------------------------------
-(void) goBack:(CCMenuItemLabel  *) menuItem {
    [self saveStats];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:SCENE_TRANS_TIME scene:[HelloScene scene]]];
} // end goBack

// ----------------------------------------------------
-(void) gameEnd{
    [self saveStats];
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:SCENE_TRANS_TIME scene:[StatsScene scene]]];
} // end gameEnd


# pragma mark -
# pragma mark data

// ----------------------------------------------------
-(void) saveStats{
    // get array of data
    NSString *err = nil;
    NSPropertyListFormat format;
    NSString *dataPath;
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                              NSUserDomainMask, YES) objectAtIndex:0];
    
    dataPath = [rootPath stringByAppendingPathComponent:@"StatsData.plist"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath]) {
        dataPath = [[NSBundle mainBundle] pathForResource:@"StatsData" ofType:@"plist"];
        
    }    
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:dataPath];
    NSDictionary *temp = (NSDictionary *)[NSPropertyListSerialization
                                          propertyListFromData:plistXML
                                          mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                          format:&format
                                          errorDescription:&err];
    
    NSMutableArray *dataArr = [NSMutableArray arrayWithArray:[temp objectForKey:@"Scores"]];   
    
    NSComparator sort = ^(id d1, id d2){
        Score *s1 = [NSKeyedUnarchiver unarchiveObjectWithData:d1];
        Score *s2 = [NSKeyedUnarchiver unarchiveObjectWithData:d2];
        return [[NSNumber numberWithInt:[s2 level]] compare:[NSNumber numberWithInt:[s1 level]]];
    };
    // empty array
    
   // Score *lowest = [NSKeyedUnarchiver unarchiveObjectWithData:[dataArr objectAtIndex:([dataArr count]-1)]];
    //if (([board level] > [lowest level]) || [dataArr count] < 21 ) {
        [dataArr addObject:[NSKeyedArchiver archivedDataWithRootObject:
                            [Score scoreWithLvl:goal Sum:[board score] Bonus: bonus]]];
        [dataArr sortUsingComparator:sort];
    //}
        
    
    // serialize and write empty array to statsData file
    dataPath = [rootPath stringByAppendingPathComponent:@"StatsData.plist"];
    NSDictionary *plistDict = [NSDictionary dictionaryWithObject:
                               [NSArray arrayWithArray:dataArr]
                                                          forKey:@"Scores"];
    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:plistDict
                                                                   format:NSPropertyListXMLFormat_v1_0
                                                         errorDescription:&err];
    
    if (![plistData writeToFile:dataPath atomically:YES]) {
        // error
    }
    
} // end saveStats


// user input ------------------------------------------------------------------------------------------------

# pragma mark -
# pragma mark input

//We need to tell the CCLayer code that we want the “targeted” set of touch events rather than the “standard” set:
-(void) registerWithTouchDispatcher
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
} // registerWithTouchDispatcher

// Return YES here to tell the touch dispatcher that you want to claim this touch:
- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    return YES;
} // ccTouchBegan

// move sprite to where touch ends
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
        [hud setDispWithScore:[board score] Time:lvlTime Level:goal Bonus:bonus];
    }
		
    self.isTouchEnabled = YES;
	
} // ccTouchEnded



@end

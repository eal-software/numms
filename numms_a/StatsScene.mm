

// Copyright (c) 2011 Ethan Levien

#import "StatsScene.h"


@implementation StatsScene


// ----------------------------------------------------
+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	StatsScene *layer = [StatsScene node];
	
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
        
        
        CCSprite* backsprite = [CCSprite spriteWithFile:@"bg_scores1.png"];
        backsprite.opacity = 225;
		backsprite.anchorPoint = ccp(0,0);
		backsprite.position = ccp(0,0);
        [self addChild:backsprite];
        
        
        CCLabelTTF *levelsLbl = [CCLabelTTF 
                                 labelWithString:[NSString stringWithString:@"Level "]
                                 dimensions:CGSizeMake(100,15) alignment:UITextAlignmentLeft fontName:STATS_FONT fontSize:15];
        levelsLbl.anchorPoint = ccp(0,0);
        levelsLbl.position = ccp(80,405);
        
        CCLabelTTF *sumsLbl = [CCLabelTTF 
                                 labelWithString:[NSString stringWithString:@"Sum "]
                                 dimensions:CGSizeMake(100,15) alignment:UITextAlignmentLeft fontName:STATS_FONT fontSize:15];
        sumsLbl.anchorPoint = ccp(0,0);
        sumsLbl.position = ccp(150,405);
        
        CCLabelTTF *bonusLbl = [CCLabelTTF 
                               labelWithString:[NSString stringWithString:@"Bonus "]
                               dimensions:CGSizeMake(100,15) alignment:UITextAlignmentLeft fontName:STATS_FONT fontSize:15];
        bonusLbl.anchorPoint = ccp(0,0);
        bonusLbl.position = ccp(220,405);

        
        levels = [CCLabelTTF 
                     labelWithString:[NSString stringWithString:@""]
                  dimensions:CGSizeMake(40,395) alignment:UITextAlignmentLeft fontName:STATS_FONT fontSize:15];
        levels.anchorPoint = ccp(0,0);
        levels.position = ccp(80,0);

        sums = [CCLabelTTF 
                     labelWithString:[NSString stringWithString:@""]
                dimensions:CGSizeMake(40,395) alignment:UITextAlignmentLeft fontName:STATS_FONT fontSize:15];
        sums.anchorPoint = ccp(0,0);
        sums.position = ccp(150,0);
        
        
        bonuses = [CCLabelTTF 
                  labelWithString:[NSString stringWithString:@""]
                  dimensions:CGSizeMake(40,395) alignment:UITextAlignmentLeft fontName:STATS_FONT fontSize:15];
        bonuses.anchorPoint = ccp(0,0);
        bonuses.position = ccp(220,0);
        
        [self addChild: levelsLbl];
        [self addChild: sumsLbl];
        [self addChild: bonusLbl];
        [self addChild: levels];
        [self addChild: sums];
        [self addChild: bonuses];
        [self menuSetup];
        [self displayStats:[self readStats]];
	}
	return self;
}


// ---------------------------------------------------
-(void) menuSetup{
   // CCDirector *director = [CCDirector sharedDirector];
    
    // setup back button        

    CCLabelTTF *backLabel = [CCLabelTTF labelWithString:@"Back" fontName:MENU_FONT fontSize:20];
    backLabel.opacity = 225;
    FadeTextButton  *back = [FadeTextButton  itemWithLabel: backLabel target:self  selector: @selector(goBack:)];
    [backLabel setAnchorPoint:CGPointMake(0, 0)];
    [backLabel setPosition:ccp(0,0)];
    [back setAnchorPoint:CGPointMake(0, 0)];
    [back setPosition:ccp(100, 100)];   
    [back setOpacity:100];
    
    CCLabelTTF *resetLabel = [CCLabelTTF labelWithString:@"Reset" fontName:MENU_FONT fontSize:20];
    resetLabel.opacity = 225;
    FadeTextButton  *reset = [FadeTextButton itemWithLabel: resetLabel  target:self  selector: @selector(resetData:)];
       [resetLabel setAnchorPoint:CGPointMake(0, 0)];
    [resetLabel setPosition:ccp(0,0)];
    [reset setAnchorPoint:CGPointMake(0, 0)];
    [reset setPosition:ccp(100, 300)];
    [reset setOpacity:100];
    
    CCMenu *menu = [CCMenu menuWithItems:back, reset,nil];
    [menu setAnchorPoint:ccp(0,0)];
    [menu setPosition:ccp(60,15)];        
    [menu alignItemsHorizontally];
    
    [self addChild:menu];

} // end menuSetup

// ---------------------------------------------------
-(void) resetData:(CCMenuItemLabel  *) menuItem{
    
   
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
   
    // empty array
    [dataArr removeAllObjects];
    
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
    
    [self displayStats: [self readStats]];
    
} // end resetData

// ---------------------------------------------------
-(void) goBack:(CCMenuItemLabel  *) menuItem {
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:SCENE_TRANS_TIME scene:[HelloScene scene]]];
} // end goBack

// ---------------------------------------------------
-(void) displayStats:(NSArray*) data{
   NSString *levelsStr = [NSString stringWithString:@""];
   NSString *sumsStr = [NSString stringWithString:@""];
   NSString *bonusesStr = [NSString stringWithString:@""];
    
    int i = 0;
    while ((i < [data count] ) && (i < 21 )) {
        
        // get score object from nsdata
        Score *temp = [NSKeyedUnarchiver unarchiveObjectWithData:[data objectAtIndex:i]];
        
        // update string
        levelsStr = [levelsStr stringByAppendingString:
                     [NSString stringWithFormat:@" %d                    ", [temp level]]];  
        sumsStr = [sumsStr stringByAppendingString: 
                   [NSString stringWithFormat:@" %d                    ", [temp sum]]]; 
        bonusesStr = [bonusesStr stringByAppendingString: 
                      [NSString stringWithFormat:@" %d                      ", [temp bonus]]]; 

        
        i++;
    }
    [levels setString:levelsStr];
    [sums setString:sumsStr];
    [bonuses setString:bonusesStr];
} // end displayStats

// ----------------------------------------------------

-(NSArray*) readStats{
    
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
    return  dataArr;
} // end readGreatest

@end

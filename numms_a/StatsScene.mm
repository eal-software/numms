

// Copyright (c) 2011 Ethan Levien
// StatsScene.mm

#import "StatsScene.h"


@implementation StatsScene

#define STATS_HEIGHT 200

#pragma mark - 
#pragma mark setup

// setup
// ====================================================

// ----------------------------------------------------
+(id) scene
{
    
	CCScene *scene = [CCScene node];
	StatsScene *layer = [StatsScene node];
	[scene addChild: layer];
	return scene;
    
} // end scene


// ----------------------------------------------------
-(id) init
{
	if( (self=[super  init])) {
        
       // CCSprite* backsprite = [CCSprite spriteWithFile:@"bg_motifs1.png"];
	   // [self addChild:backsprite];
       // [self buttonSetup];
       // backsprite.anchorPoint = ccp(0,0);
       // backsprite.position = ccp(0,0);

        //DataIOManager *io = [DataIOManager dataIOManager];
        [self labelsSetup];
        [self buttonSetup];
       // [self displayStats:[io readStats]];
	}
	return self;
} // end init


// ---------------------------------------------------
-(void) buttonSetup{

    // two buttons:
    // back
    CCLabelTTF *backLabel = [CCLabelTTF labelWithString:BACK_TEXT fontName:MENU_FONT fontSize:NAV_BUTTON_SIZE];
    backLabel.opacity = BUTTON_OPACITY;
    backLabel.color = ccc3(225, 225, 225);
    FadeTextButton *back = [FadeTextButton  itemWithLabel: backLabel target:self  selector: @selector(goBack:)];
    back.anchorPoint = ccp(0,0);
    back.position = ccp(0,0);

    // reset
    CCLabelTTF *resetLabel = [CCLabelTTF labelWithString:@"Reset" fontName:MENU_FONT fontSize:NAV_BUTTON_SIZE];
    resetLabel.opacity = BUTTON_OPACITY;
    resetLabel.color = ccc3(225, 225, 225);
    FadeTextButton *reset = [FadeTextButton  itemWithLabel: resetLabel target:self  selector: @selector(resetData:)];
    reset.anchorPoint = ccp(0,0);
    reset.position = ccp(0,0);
    
    // add to menu and as child to scene
    CCMenu *menu = [CCMenu menuWithItems: back, reset,nil];
    //[menu setAnchorPoint:ccp(0,0)];
    [menu setPosition:ccp(120,15)];        
    [menu alignItemsHorizontally];
    
    [self addChild:menu];

} // end menuSetup



// ---------------------------------------------------
-(void) labelsSetup{
    
    // three labels
   /* 
    // levels
   /CCLabelTTF *levelsLbl = 
    [CCLabelTTF labelWithString:[NSString stringWithString:@"Level "]
                             dimensions:CGSizeMake(100,15) 
                      alignment:UITextAlignmentLeft 
                       fontName:STATS_FONT 
                       fontSize:STATS_DISP_SIZE];
    
    levelsLbl.anchorPoint = ccp(0,0);
    levelsLbl.position = ccp(90,STATS_HEIGHT+STATS_DISP_SIZE);
    */
    
    DataIOManager *io = [DataIOManager dataIOManager];
    // sums
    CCLabelTTF *sumsLbl = 
    [CCLabelTTF labelWithString:[NSString stringWithFormat:@" Greatest: %d ", [io readGreatest]]
                           dimensions:CGSizeMake(100,STATS_DISP_SIZE) 
                      alignment:UITextAlignmentLeft 
                       fontName:STATS_FONT 
                       fontSize:STATS_DISP_SIZE];
    
    sumsLbl.anchorPoint = ccp(0,0);
    sumsLbl.position = ccp(20,STATS_HEIGHT);
    
    // sums
    CCLabelTTF *lastLbl = 
    [CCLabelTTF labelWithString:[NSString stringWithFormat:@" Last: %d ", [io readLast]]                   
                    dimensions:CGSizeMake(100,STATS_DISP_SIZE) 
                      alignment:UITextAlignmentLeft 
                       fontName:STATS_FONT 
                       fontSize:STATS_DISP_SIZE];
    
    lastLbl.anchorPoint = ccp(0,0);
    lastLbl.position = ccp(20,STATS_HEIGHT-STATS_DISP_SIZE);

    
    // bonuses
   /* CCLabelTTF *bonusLbl = 
    [CCLabelTTF labelWithString:[NSString stringWithString:@"Bonus "]
                            dimensions:CGSizeMake(100,15) 
                      alignment:UITextAlignmentLeft 
                       fontName:STATS_FONT 
                       fontSize:STATS_DISP_SIZE];
    
    bonusLbl.anchorPoint = ccp(0,0);
    bonusLbl.position = ccp(230,STATS_HEIGHT+STATS_DISP_SIZE);*/
    
    // add labels
   // [self addChild: levelsLbl];
    [self addChild: sumsLbl];
    [self addChild:lastLbl];
   // [self addChild: bonusLbl];
    
} // end labelsSetup


#pragma mark - 
#pragma mark button_selectors

// button_selectors
// ====================================================

// ---------------------------------------------------
-(void) resetData:(CCMenuItemLabel  *) menuItem{
    
    DataIOManager *io = [DataIOManager dataIOManager];
    [self clearLabels];
    NSMutableArray* data = [io readStats];
    [data removeAllObjects];
    [io writeStats:data];
    NSMutableArray *newData = [io readStats];
    [self displayStats:newData];

} // end resetData



// ---------------------------------------------------
-(void) goBack:(CCMenuItemLabel  *) menuItem {
    
    [[CCDirector sharedDirector] replaceScene:
     [CCTransitionFade transitionWithDuration:SCENE_TRANS_TIME scene:[HelloScene scene]]];
    
} // end goBack


#pragma mark - 
#pragma mark display

// display
// ====================================================

// ----------------------------------------------------
-(void) clearLabels{
    
    // remove the old labels
    for (int i = 0; i < 21; i++) {
        if (scores[i][0] != 0) {
            [self removeChild:scores[i][0] cleanup:YES];
        }
        if (scores[i][1] != 0) {
            [self removeChild:scores[i][1] cleanup:YES];
        }
        if (scores[i][2] != 0) {
            [self removeChild:scores[i][2] cleanup:YES];
        }
    }
    
} // end clearLabels

// ---------------------------------------------------
-(void) displayStats:(NSMutableArray*) data{
    
    
    int i = 0;
    while (i < [data count] ) {
        
        // get score object from nsdata
        Score *temp = [NSKeyedUnarchiver unarchiveObjectWithData:[data objectAtIndex:i]];
        
        
        // sum
        scores[i][1] = [CCLabelTTF labelWithString:[NSString stringWithString:@""]
                                        dimensions:CGSizeMake(100,STATS_DISP_SIZE) alignment:UITextAlignmentRight fontName:STATS_FONT 
                                          fontSize:STATS_DISP_SIZE];
        scores[i][1].anchorPoint = ccp(0,0);
        scores[i][1].position = ccp(50,STATS_HEIGHT-i*STATS_DISP_SIZE);
        
        [scores[i][1] setString: [NSString stringWithFormat:@" %d", [temp sum]]];
        
        [self addChild:scores[i][1]];
        

        
        if ([temp history] == 0) {
            
            // display this entry as green
           // scores[i][0].color = ccc3(0,225,0);
            scores[i][1].color = ccc3(0,225,0);
            //scores[i][2].color = ccc3(0,225,0);
           
            // increment history on element in array
            [data replaceObjectAtIndex: i withObject:
             [NSKeyedArchiver archivedDataWithRootObject:
              [Score scoreWithLvl:[temp level] Sum:[temp sum] Bonus:[temp bonus] History:1]]];
        } // end if
        
        i++;
        
    } // end for
    
    
    // write the updated array to file
    DataIOManager *io = [DataIOManager dataIOManager];
    [io writeStats:data];    

    
} // end displayStats

@end

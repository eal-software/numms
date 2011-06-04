
// Copyright (c) 2011 Ethan Levien

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameScene.h"
#import "StatsScene.h"
#import "InfoScene.h"
#import "Consts.h"
#import "FadeTextButton.h"

/*--------------------------------------------------------------
 Programmer: ethan levien
 
 SUMMARY: 
 
 REVISIONS: 
 05/29/2011 (eal) - wrote and implemented class basics
 
 ----------------------------------------------------------------*/


@interface HelloScene : CCLayer {
    
}

+(id) scene;
-(void) menuSetup;
-(void) goGame:(CCMenuItemLabel  *) menuItem ;
-(void) goStats:(CCMenuItemLabel  *) menuItem ;
-(void) goInfo:(CCMenuItemLabel  *) menuItem ;

@end
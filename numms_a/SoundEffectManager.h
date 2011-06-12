// Copyright (c) 2011 Ethan Levien
// SoundEffectManager.h

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

/*--------------------------------------------------------------
 Programmer: ethan levien
 
 SUMMARY:
 
 REVISIONS: 
 06/08/2011 (eal) - wrote and implemented class w/ only capture effect
 ----------------------------------------------------------------*/


@interface SoundEffectManager : NSObject {
        SystemSoundID capture_tone;
        SystemSoundID bad_tone;
        SystemSoundID place_tone;
        SystemSoundID level_tone;
}

// setup
// ====================================================
+(id) soundEffectManager;
-(id) initEffects;

// sounds
// ====================================================
-(void) playCapture;
-(void) playBad;
-(void) playPlace;
-(void) playLevel;

@end

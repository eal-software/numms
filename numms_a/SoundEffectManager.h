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
}

// setup
// ====================================================
+(id) soundEffectManager;
-(id) initEffects;

// sounds
// ====================================================
-(void) playCapture;

@end

// Copyright (c) 2011 Ethan Levien
// SoundEffectManager.mm

#import "SoundEffectManager.h"


@implementation SoundEffectManager

#pragma mark - 
#pragma mark setup

// setup
// ====================================================

+(id) soundEffectManager{    
    return [[[self alloc] initEffects] autorelease];
} // end soundEffectManager

// ---------------------------------------------------
-(id) initEffects{
    if( (self=[super init]) ) {
        
        
        NSString *toneFilename = [NSString stringWithString:@"wine"];
        
        NSURL *toneURLRef = [[NSBundle mainBundle] URLForResource:toneFilename
                                                    withExtension:@"aif"];
        
        
        AudioServicesCreateSystemSoundID(
                                         (CFURLRef) toneURLRef,
                                         &capture_tone
                                         );

    }
    return self;
    
} // end init

#pragma mark - 
#pragma mark sounds

// sounds
// ====================================================

// ---------------------------------------------------
-(void) playCapture{
    AudioServicesPlaySystemSound(capture_tone);
} // playCapture


@end

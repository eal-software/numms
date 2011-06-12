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
        
        NSString *toneFilename;
        NSURL *toneURLRef;

        
        // cache capture
        toneFilename = [NSString stringWithString:@"capture"];
        toneURLRef = [[NSBundle mainBundle] URLForResource:toneFilename
                                                    withExtension:@"aif"];
        AudioServicesCreateSystemSoundID((CFURLRef) toneURLRef,&capture_tone);
        
        
        // cache bad
        toneFilename = [NSString stringWithString:@"bad"];
        toneURLRef = [[NSBundle mainBundle] URLForResource:toneFilename
                                                    withExtension:@"aif"];      
        AudioServicesCreateSystemSoundID((CFURLRef) toneURLRef,&bad_tone );

        // cache place
        toneFilename = [NSString stringWithString:@"place"];
        toneURLRef = [[NSBundle mainBundle] URLForResource:toneFilename
                                             withExtension:@"aif"];      
        AudioServicesCreateSystemSoundID( (CFURLRef) toneURLRef,&place_tone);
        
        // cache place
        toneFilename = [NSString stringWithString:@"level"];
        toneURLRef = [[NSBundle mainBundle] URLForResource:toneFilename
                                             withExtension:@"aif"];      
        AudioServicesCreateSystemSoundID( (CFURLRef) toneURLRef,&level_tone);
        
        
        // cache gameover
        toneFilename = [NSString stringWithString:@"gameover"];
        toneURLRef = [[NSBundle mainBundle] URLForResource:toneFilename
                                             withExtension:@"aif"];      
        AudioServicesCreateSystemSoundID( (CFURLRef) toneURLRef,&gameover_tone);


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
} // end playCapture

// ---------------------------------------------------
-(void) playBad{
    AudioServicesPlaySystemSound(bad_tone);
} // end playBad

-(void) playPlace{
    AudioServicesPlaySystemSound(place_tone);
} // end playPlace

-(void) playLevel{
    AudioServicesPlaySystemSound(level_tone);
} // end playLevel

-(void) playGameover{
    AudioServicesPlaySystemSound(gameover_tone);
} // end playGameover


@end

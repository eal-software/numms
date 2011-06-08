
// Copyright (c) 2011 Ethan Levien
// FadeTextButton.m

#import "FadeTextButton.h"


// BUG: doesn't fade out when unselected if no scene transition

@implementation FadeTextButton

enum {
	kZoomActionTag = 0xc0c05002,
};


-(id) init
{
	
	if( (self=[super  init])) {

	}
	return self;
}



-(void) selected
{
	// subclass to change the default action
	if(isEnabled_) {	
		[super selected];
		[self stopActionByTag:kZoomActionTag];
		originalOpp = [self.label opacity];
		CCAction *zoomAction = [CCFadeTo actionWithDuration:0.1f opacity:225];
		zoomAction.tag = kZoomActionTag;
		[self runAction:zoomAction];
	}
}

-(void) unselected
{
	// subclass to change the default action
	if(isEnabled_) {
		[super unselected];
		[self stopActionByTag:kZoomActionTag];
		CCAction *zoomAction = [CCFadeTo actionWithDuration:0.1f opacity:originalOpp];
		zoomAction.tag = kZoomActionTag;
		[self runAction:zoomAction];
	}
}



@end


// Copyright (c) 2011 Ethan Levien
#import "FadeTextButton.h"


// BUG: doesn't fade out when unselected

@implementation FadeTextButton

enum {
	kZoomActionTag = 0xc0c05002,
};


-(id) init
{
	
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
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

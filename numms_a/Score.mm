
// Copyright (c) 2011 Ethan Levien

#import "Score.h"

#define LEVEL @"level"
#define SUM   @"sum"
#define BONUS @"bonus"

@implementation Score

// ---------------------------------------------------
+(id) scoreWithLvl:(short) l Sum:(short) s Bonus:(short) b{
   
    return [[[self alloc] initWithLvl:l Sum:s Bonus:b] autorelease];
} // end ScoreWithLvl:Bonus

// ---------------------------------------------------
+(id) scoreWithEncoder: (NSCoder*) coder{
      return [[[self alloc] initWithCoder:coder] autorelease];
} // end scoreWithEncoder

// ---------------------------------------------------
-(id) initWithLvl:(short) l Sum:(short) s Bonus:(short) b {
    if( (self=[super init]) ) {
        lvl = l;
        sm = s;
        bon = b;
    }
    return self;

} // end initWithLvl:Bonus

// ---------------------------------------------------
-(id) initWithCoder: (NSCoder*) coder {
    short l = [coder decodeIntegerForKey:LEVEL];
    short s = [coder decodeIntegerForKey:SUM];
    short b = [coder decodeIntegerForKey:BONUS];
    return [self initWithLvl:l Sum:s Bonus:b];
} // end initWithCoder

// ---------------------------------------------------
-(void) encodeWithCoder: (NSCoder*) coder {
    [coder encodeInteger: lvl forKey:LEVEL];
    [coder encodeInteger: sm forKey:SUM];
    [coder encodeInteger: bon forKey:BONUS];
} // end encodeWithCoder


// ---------------------------------------------------
-(short) level { return lvl;}
-(short) bonus { return bon;}
-(short) sum { return sm;}
// end getters

@end

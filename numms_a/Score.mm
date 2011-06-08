
// Copyright (c) 2011 Ethan Levien
// Score.mm

#import "Score.h"

#define LEVEL @"level"
#define SUM   @"sum"
#define BONUS @"bonus"
#define HISTORY @"history"

@implementation Score

// ---------------------------------------------------
+(id) scoreWithLvl:(short) l Sum:(short) s Bonus:(short) b History:(short) h{
   
    return [[[self alloc] initWithLvl:l Sum:s Bonus:b History: h] autorelease];
} // end ScoreWithLvl:Bonus

// ---------------------------------------------------
+(id) scoreWithEncoder: (NSCoder*) coder{
      return [[[self alloc] initWithCoder:coder] autorelease];
} // end scoreWithEncoder

// ---------------------------------------------------
-(id) initWithLvl:(short) l Sum:(short) s Bonus:(short) b History:(short) h{
    if( (self=[super init]) ) {
        lvl = l;
        sm = s;
        bon = b;
        hist = h;
    }
    return self;

} // end initWithLvl:Bonus

// ---------------------------------------------------
-(id) initWithCoder: (NSCoder*) coder {
    short l = [coder decodeIntegerForKey:LEVEL];
    short s = [coder decodeIntegerForKey:SUM];
    short b = [coder decodeIntegerForKey:BONUS];
    short h = [coder decodeIntegerForKey:HISTORY];
    return [self initWithLvl:l Sum:s Bonus:b History:h];
} // end initWithCoder

// ---------------------------------------------------
-(void) encodeWithCoder: (NSCoder*) coder {
    [coder encodeInteger: lvl forKey:LEVEL];
    [coder encodeInteger: sm forKey:SUM];
    [coder encodeInteger: bon forKey:BONUS];
    [coder encodeInteger: hist forKey:HISTORY];
} // end encodeWithCoder


// ---------------------------------------------------
-(short) level { return lvl;}
-(short) bonus { return bon;}
-(short) sum { return sm;}
-(short) history { return hist;}
// end getters

@end

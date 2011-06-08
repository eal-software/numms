
// Copyright (c) 2011 Ethan Levien
// Score.h

#import <Foundation/Foundation.h>


@interface Score : NSObject <NSCoding> {
    
    short lvl;
    short sm;
    short bon;
    short hist;
    
}

+(id) scoreWithLvl:(short) l Sum:(short) s Bonus:(short) b History:(short) h;
+(id) scoreWithEncoder: (NSCoder*) coder;
-(id) initWithLvl:(short) l Sum:(short) s Bonus:(short) b History:(short) h;
-(short) level;
-(short) bonus;
-(short) sum;
-(short) history;

@end

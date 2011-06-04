
// Copyright (c) 2011 Ethan Levien

#import <Foundation/Foundation.h>


@interface Score : NSObject <NSCoding> {
    
    short lvl;
    short sm;
    short bon;
    
}

+(id) scoreWithLvl:(short) l Sum:(short) s Bonus:(short) b;
+(id) scoreWithEncoder: (NSCoder*) coder;
-(id) initWithLvl:(short) l Sum:(short) s Bonus:(short) b;
-(short) level;
-(short) bonus;
-(short) sum;

@end

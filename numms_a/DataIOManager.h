// Copyright (c) 2011 Ethan Levien
// DataIOManager.h

#import <Foundation/Foundation.h>
#import "Consts.h"


/*--------------------------------------------------------------
 Programmer: ethan levien
 
 SUMMARY: class to used to read and write to StatsData.plist
 
 REVISIONS: 
 06/06/2011 (eal) - wrote and implemented class
 06/09/2011 (eal) - wrote read/writeGreatest and read/writeLast 
                  - no longer using array to store large history 
                    so i've commented out read/writeStats
 06/11/2011 (eal) - fixed bug saving scores

 
 ----------------------------------------------------------------*/

@interface DataIOManager : NSObject {
    
    NSString *err;               // used throughout to store any errors
    NSPropertyListFormat format; // used throughout to store format
    NSString *dataPath;          // path to file
    NSString *rootPath;          // path to user directory
    
} // end interface

// setup
// ====================================================
+(id) dataIOManager;

// data_io
// ====================================================
//-(NSMutableArray*) readStats;
// PRE:  StatsData.plist exists and data is formated correctly
// POST: reads Scores from StatsData.plist into array

//-(void) writeStats:(NSMutableArray*) data;
// PRE:  data(assigned) is an array of encoded Score obejects
// POST: data is written to StatsData.plist with key "Scores"

-(short) readLast;
-(short) readGreatest;


-(void) writeLast:(short) last;
-(void) writeGreatest:(short) great;



@end

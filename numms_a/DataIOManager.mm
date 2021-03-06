// Copyright (c) 2011 Ethan Levien
// DataIOManager.mm

#import "DataIOManager.h"


@implementation DataIOManager

#pragma mark - 
#pragma mark setup

// setup
// ====================================================

+(id) dataIOManager{    
    return [[[self alloc] init] autorelease];
} // end dataIOManager

#pragma mark - 
#pragma mark data_io

// data_io
// ====================================================

// ----------------------------------------------------
/*-(NSMutableArray*) readStats{
    
   rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                              NSUserDomainMask, YES) objectAtIndex:0];
    
    dataPath = [rootPath stringByAppendingPathComponent:@"StatsData.plist"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath]) {
        dataPath = [[NSBundle mainBundle] pathForResource:@"StatsData" ofType:@"plist"];
        
    }    
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:dataPath];
    NSDictionary *temp = (NSDictionary *)[NSPropertyListSerialization
                                          propertyListFromData:plistXML
                                          mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                          format:&format
                                          errorDescription:&err];
    
    NSMutableArray *data = [NSMutableArray arrayWithArray:[temp objectForKey:@"Scores"]];  
    
    return  data;
}*/ // end readStats

// ----------------------------------------------------
/*-(void) writeStats:(NSMutableArray*) data{
    
    
    
    rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                              NSUserDomainMask, YES) objectAtIndex:0];
    
    dataPath = [rootPath stringByAppendingPathComponent:STATSDATA_FILE];
    
    
    // serialize and write to statsData file
    dataPath = [rootPath stringByAppendingPathComponent:STATSDATA_FILE];
    NSDictionary *plistDict = [NSDictionary dictionaryWithObject:
                               [NSArray arrayWithArray:data]
                                                          forKey:@"Scores"];
    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:plistDict
                                                                   format:NSPropertyListXMLFormat_v1_0
                                                         errorDescription:&err];
    
    if (![plistData writeToFile:dataPath atomically:YES]) {
        // error
    }
    
    
}*/ // end writeStats

// ----------------------------------------------------
-(short) readLast{
    
    rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                    NSUserDomainMask, YES) objectAtIndex:0];
    
    dataPath = [rootPath stringByAppendingPathComponent:@"StatsData.plist"];
    
  /*  if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath]) {
        dataPath = [[NSBundle mainBundle] pathForResource:@"StatsData" ofType:@"plist"];
        
    }  */  
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:dataPath];
    NSDictionary *temp = (NSDictionary *)[NSPropertyListSerialization
                                          propertyListFromData:plistXML
                                          mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                          format:&format
                                          errorDescription:&err];
    
    NSNumber *data = [temp objectForKey:@"Last"];  
    
    if (data == NULL) {
        return 0;
    }else{
        return [data shortValue];
    }
    
} // readLast

// ----------------------------------------------------
-(short) readGreatest{
    
    rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                    NSUserDomainMask, YES) objectAtIndex:0];
    
    dataPath = [rootPath stringByAppendingPathComponent:STATSDATA_FILE];

    
   /* if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath]) {
        dataPath = [[NSBundle mainBundle] pathForResource:@"StatsData" ofType:@"plist"];
        
    } */   
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:dataPath];
    NSDictionary *temp = (NSDictionary *)[NSPropertyListSerialization
                                          propertyListFromData:plistXML
                                          mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                          format:&format
                                          errorDescription:&err];
    
    NSNumber *data = [temp objectForKey:@"Greatest"];  
    
    if (data == NULL) {
        return 0;
    }else{
        return [data shortValue];
    }
    
} // readGreatest


// ----------------------------------------------------
-(void) writeLast:(short) last{
   
    rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                    NSUserDomainMask, YES) objectAtIndex:0];
    
    dataPath = [rootPath stringByAppendingPathComponent:STATSDATA_FILE];
    
    
    // serialize and write to statsData file
    NSDictionary *plistDict = [NSDictionary dictionaryWithObjects:                                
                               [NSArray arrayWithObjects:[NSNumber numberWithInt:last],[NSNumber numberWithInt: [self readGreatest]] , nil]                                                         
                                        forKeys:[NSArray arrayWithObjects:@"Last", @"Greatest", nil] ];
    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:plistDict
                                                                   format:NSPropertyListXMLFormat_v1_0
                                                         errorDescription:&err];
    
    if (![plistData writeToFile:dataPath atomically:YES]) {
        // error
    }

    
    
} // writeLast

// ----------------------------------------------------
-(void) writeGreatest:(short) great{
    
    rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                    NSUserDomainMask, YES) objectAtIndex:0];
    
    dataPath = [rootPath stringByAppendingPathComponent:STATSDATA_FILE];
    
    // serialize and write to statsData file
    NSDictionary *plistDict = [NSDictionary dictionaryWithObjects:                                
                                [NSArray arrayWithObjects:[NSNumber numberWithInt:[self readLast]],[NSNumber numberWithInt: great] , nil]                                                         
                                               forKeys:[NSArray arrayWithObjects:@"Last", @"Greatest", nil] ];
    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:plistDict
                                                                   format:NSPropertyListXMLFormat_v1_0
                                                         errorDescription:&err];
    
    if (![plistData writeToFile:dataPath atomically:YES]) {
        // error
    }

    
} // writeGreatest



@end

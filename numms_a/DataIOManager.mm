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
-(NSMutableArray*) readStats{
    
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
} // end readStats

// ----------------------------------------------------
-(void) writeStats:(NSMutableArray*) data{
    
    
    
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
    
    
} // end writeStats


-(short) readGreatest{
    
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
    
    NSNumber *data = [temp objectForKey:@"Greatest"];  
    
    return [data integerValue];
    
} // readGreatest


-(short) readLast{
    
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
    
    NSNumber *data = [temp objectForKey:@"Last"];  
    
    return [data shortValue];
    
} // readLast

-(void) writeLast:(short) last{
   
    rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                    NSUserDomainMask, YES) objectAtIndex:0];
    
    dataPath = [rootPath stringByAppendingPathComponent:STATSDATA_FILE];
    
    
    // serialize and write to statsData file
    dataPath = [rootPath stringByAppendingPathComponent:STATSDATA_FILE];
    NSDictionary *plistDict = [NSDictionary dictionaryWithObject:
                               [NSNumber numberWithInt:last]
                                                          forKey:@"Last"];
    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:plistDict
                                                                   format:NSPropertyListXMLFormat_v1_0
                                                         errorDescription:&err];
    
    if (![plistData writeToFile:dataPath atomically:YES]) {
        // error
    }

    
    
} // writeLast

-(void) writeGreatest:(short) great{
    
    rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                    NSUserDomainMask, YES) objectAtIndex:0];
    
    dataPath = [rootPath stringByAppendingPathComponent:STATSDATA_FILE];
    
    
    // serialize and write to statsData file
    dataPath = [rootPath stringByAppendingPathComponent:STATSDATA_FILE];
    NSDictionary *plistDict = [NSDictionary dictionaryWithObject:
                               [NSNumber numberWithInt:great]
                                                          forKey:@"Greatest"];
    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:plistDict
                                                                   format:NSPropertyListXMLFormat_v1_0
                                                         errorDescription:&err];
    
    if (![plistData writeToFile:dataPath atomically:YES]) {
        // error
    }

    
} // writeGreatest



@end

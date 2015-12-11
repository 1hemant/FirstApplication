//
//  SharedManager.m
//  DemoAppChart
//
//  Created by anupam shrivastava on 9/2/15.
//  Copyright (c) 2015 NSSPL. All rights reserved.
//

#import "SharedManager.h"
#import "Reachability.h"
#import "Constant.h"
@implementation SharedManager

+ (id)sharedManager {
    static SharedManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {

    }
    return self;
}

- (void)setArrayMonth:(NSArray *)arr
{
    if (_arrMonth) {
        _arrMonth = nil;
    }
    
    _arrMonth = [[NSArray alloc] initWithArray:arr];
}

- (NSArray *)getArrayMonth
{
    return _arrMonth;
}

- (void)setArrayRegion:(NSArray *)arr
{
    if (_arrRegion) {
        _arrRegion = nil;
    }
    
    _arrRegion = [[NSArray alloc] initWithArray:arr];
}

- (NSArray *)getArrayRegion
{
    return _arrRegion;
}

- (void)setMonthRegionInfo:(NSArray *)arr withMetadata:(NSArray *)arrMetadata
{
    if (_arrRegionMonthInfo) {
        _arrRegionMonthInfo = nil;
    }
    
    _arrRegionMonthInfo  = [[NSArray alloc] initWithArray:arr];
    
    if (_arrRegionMonthMetadata) {
        _arrRegionMonthMetadata = nil;
    }
    
    _arrRegionMonthMetadata  = [[NSArray alloc] initWithArray:arrMetadata];
}

- (NSArray *)getMonthRegionInfo
{
    return _arrRegionMonthInfo;
}

- (NSArray *)getMonthRegionMetadata;
{
    return _arrRegionMonthMetadata;
}



- (void)saveGraphArray:(NSArray *)arr;
{
    [[NSUserDefaults standardUserDefaults] setObject:arr forKey:@"GRAPH_DATA"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSArray *)getArrayGraph;
{
    //NSArray *arr = [[NSUserDefaults standardUserDefaults] arrayForKey:@"GRAPH_DATA"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:NAME_PLIST_DATA_GRAPH];
    NSArray *arr = [NSArray arrayWithContentsOfFile:path];

    return arr;
}

- (BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}

- (void)saveData:(NSArray *)array toPlist:(NSString *)stringPlistName;
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:stringPlistName];
    [array writeToFile:path atomically:YES];
}

- (void)saveDataDict:(NSDictionary *)dict toPlist:(NSString *)stringPlistName;
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:stringPlistName];
    [dict writeToFile:path atomically:YES];
}

- (NSArray *)getArrayLogin
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:NAME_PLIST_LOGIN];
    NSArray *arr = [NSArray arrayWithContentsOfFile:path];
    
    return arr;
}

- (NSDictionary *)getConfigData
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:NAME_PLIST_USER_CONFIG];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    
    return dict;
}



- (NSDictionary *)getDataForBarChart:(NSString *)stringColumnNameMajor columnTwo:(NSString *)stringColumnNameMinor
{
    NSDictionary *dict = [self getDataDictionaryFromPlist:NAME_PLIST_DATA_GRAPH];
    
    NSArray *arrayMetadata = [dict objectForKey:@"metadata"];
    
    int columnMajor = -1;
    
    NSArray *filtered = [arrayMetadata filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(colName == %@)", stringColumnNameMajor]];
    if (filtered.count > 0)
    {
        columnMajor = [[[filtered objectAtIndex:0] objectForKey:@"colIndex"] intValue];
    }
    
    int columnMinor = -1;
    
    filtered = [arrayMetadata filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(colName == %@)", stringColumnNameMinor]];
    if (filtered.count > 0)
    {
        columnMinor = [[[filtered objectAtIndex:0] objectForKey:@"colIndex"] intValue];
    }
    
    NSArray *arrayData = [dict objectForKey:@"resultset"];
    
    NSMutableArray *arrayMinor = [NSMutableArray new];
    for (NSArray *arr in arrayData)
    {
        [arrayMinor addObject:[arr objectAtIndex:columnMinor]];
    }
    
    
    arrayMinor = (NSMutableArray *)[self getAllDistinctValuesFromArray:arrayMinor];
    NSLog(@"array minor : %@",arrayMinor);

    float val = 0.0;
    
    NSMutableDictionary *dictToReturn = [NSMutableDictionary new];
    for (NSString *str in arrayMinor)
    {
        for (int i = 0; i < arrayData.count; i++)
        {
            if ([[[arrayData objectAtIndex:i] objectAtIndex:columnMinor] isEqualToString:str])
            {
                val += [[[arrayData objectAtIndex:i] objectAtIndex:0] floatValue];
            }
        }
        
        [dictToReturn setValue:[NSNumber numberWithFloat:val] forKey:str];
    }
    
    return dictToReturn;
}

- (NSArray *)getAllDistinctValuesFromArray:(NSArray *)array
{
    NSMutableArray * unique = [NSMutableArray array];
    NSMutableSet * processed = [NSMutableSet set];
    for (NSString * string in array) {
        if ([processed containsObject:string] == NO) {
            [unique addObject:string];
            [processed addObject:string];
        }
    }

    return unique;
}
   
- (NSDictionary *)getDataDictionaryFromPlist:(NSString *)stringPlistName;
{
    NSArray*pListpaths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,  YES);
    NSString*pListdocumentsDirectory = [pListpaths objectAtIndex:0];
    NSString*pListpath = [pListdocumentsDirectory stringByAppendingPathComponent:stringPlistName];
    
    NSFileManager*pListfileMgr = [NSFileManager defaultManager];
    if (![pListfileMgr fileExistsAtPath: pListpath])
    {
        return nil;
    }
    
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:pListpath];
    
    return dict;
}

- (NSArray *)getDataFromPlist:(NSString *)stringPlistName;
{
    NSArray*pListpaths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,  YES);
    NSString*pListdocumentsDirectory = [pListpaths objectAtIndex:0];
    NSString*pListpath = [pListdocumentsDirectory stringByAppendingPathComponent:stringPlistName];
    
    NSFileManager*pListfileMgr = [NSFileManager defaultManager];
    if (![pListfileMgr fileExistsAtPath: pListpath])
    {
        return nil;
    }
    
    NSArray *arr = [NSArray arrayWithContentsOfFile:pListpath];
    
    return arr;
}

- (void)setLoginId:(NSString *)string;
{
    if (string && string.length > 0)
    {
        stringLoginId = string;
    }
}

- (NSString *)getLoginId;
{
    return stringLoginId;
}

- (NSArray *)getChartInfo
{
    NSDictionary *dictConfig = [self getConfigData];
    
    NSArray *array = [dictConfig objectForKey:@"resultset"];
    NSString *stringUser = [self getLoginId];
    
    //NSMutableString *stringGraph = [NSMutableString new];
    NSMutableDictionary *dictTemp = [NSMutableDictionary new];
    
    NSMutableArray *arrayToReturn = [NSMutableArray new];
    
    for (int i = 0; i < array.count; i++)
    {
        if ([[[array objectAtIndex:i] objectAtIndex:0] isEqualToString:stringUser])
        {
            //[stringGraph appendFormat:@",%@",[[array objectAtIndex:i] objectAtIndex:1]];
            [dictTemp setObject:[[array objectAtIndex:i] objectAtIndex:1] forKey:@"GRAPH"];
            [dictTemp setObject:[[array objectAtIndex:i] objectAtIndex:2] forKey:@"MAJOR_COLOUM"];
            [dictTemp setObject:[[array objectAtIndex:i] objectAtIndex:3] forKey:@"MINOR_COLUMN"];
            
            [arrayToReturn addObject:dictTemp];
            dictTemp = [NSMutableDictionary new];
        }
    }

    return arrayToReturn;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

@end

//
//  SharedManager.h
//  FirstApplication
//
//  Created by Hemant Rathore on 07/10/15.
//  Copyright © 2015 Hemant Rathore. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "Constant.h"
#import <UIKit/UIKit.h>

@interface SharedManager : NSObject
{
    NSArray *arrayDate;
    NSArray *arrayGraphData;
    NSString *stringLoginId;
    
    UIImage *image;
    
    NSString *stringDateSelected;
}

+ (id)sharedManager;

@property (nonatomic, retain) NSArray *arrRegion;

@property (nonatomic, retain) NSArray *arrMonth;

@property (nonatomic, retain) NSArray *arrRegionMonthInfo;

@property (nonatomic, retain) NSArray *arrRegionMonthMetadata;

- (void)setArrayMonth:(NSArray *)arr;
- (NSArray *)getArrayMonth;

- (void)setArrayRegion:(NSArray *)arr;
- (NSArray *)getArrayRegion;

- (void)setMonthRegionInfo:(NSArray *)arr withMetadata:(NSArray *)arrMetadata;
- (NSArray *)getMonthRegionInfo;
- (NSArray *)getMonthRegionMetadata;

//- (void)setArrayLocation:(NSArray *)arr;
//- (NSArray *)getArrayLocation;

- (void)saveGraphArray:(NSArray *)arr;
- (NSArray *)getArrayGraph;
- (NSArray *)getArrayLogin;

- (void)saveDataDict:(NSDictionary *)dict toPlist:(NSString *)stringPlistName;
- (NSDictionary *)getDataDictionaryFromPlist:(NSString *)stringPlistFileName;

- (void)saveData:(NSArray *)array toPlist:(NSString *)stringPlistName;
- (NSArray *)getDataFromPlist:(NSString *)stringPlistName;

- (BOOL)connected;

- (NSDictionary *)getDataForBarChart:(NSString *)stringColumnNameMajor columnTwo:(NSString *)stringColumnNameMinor;

- (void)setLoginId:(NSString *)string;
- (NSString *)getLoginId;

- (NSArray *)getChartInfo;

//- (void)setArrayDate:(NSArray *)array;
//- (NSArray *)getArrayDate;

//- (void)setSelectedDate:(NSString *)string;
//- (NSString *)getSelectedDate;

@end

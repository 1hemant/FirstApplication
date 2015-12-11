//
//  Constant.h
//  DemoAppChart
//
//  Created by anupam shrivastava on 9/1/15.
//  Copyright (c) 2015 NSSPL. All rights reserved.
//

#ifndef DemoAppChart_Constant_h
#define DemoAppChart_Constant_h


#endif

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define URL_LOGIN                           @"https://uat-analytics.thecarecloud.com/netlink/j_spring_security_check"

#define URL_GET_CHART_DATA                  @"https://uat-analytics.thecarecloud.com/netlink/plugin/cda/api/doQuery?path=/public/UAT/Landing Page/Axletech/Categories/Financial Metric.cda&dataAccessId=DPO"

#define URL_GET_REGION_DATA                 @"https://uat-analytics.thecarecloud.com/netlink/plugin/cda/api/doQuery?path=/public/UAT/Landing Page/theresultscompanies/Categories/Finance/Finance Dashboard.cda&dataAccessId=RegionDB"

#define URL_GET_MONTH_DATA                  @"https://uat-analytics.thecarecloud.com/netlink/plugin/cda/api/doQuery?path=/public/UAT/Landing Page/theresultscompanies/Categories/Finance/Finance Dashboard.cda&dataAccessId=YearMonthDB"

#define URL_GET_REGION_MONTH_DATA           @"https://uat-analytics.thecarecloud.com/netlink/plugin/cda/api/doQuery?path=/public/UAT/Landing Page/theresultscompanies/Categories/Finance/Finance Dashboard.cda&dataAccessId=Chart1_1DB&parampRegion=%@&parampMonth=%@"

#define URL_GET_DATE_DETAIL                 @"https://uat-analytics.thecarecloud.com/netlink/plugin/cda/api/doQuery?path=/home/test/IOS App/IOS1.0.cda&dataAccessId=qry_Date"

#define URL_GET_LOCATION_DETAIL             @"https://uat-analytics.thecarecloud.com/netlink/plugin/cda/api/doQuery?path=/home/test/IOS App/IOS1.0.cda&dataAccessId=qry_Location"

#define URL_GET_GRAPH_DATA                  @"https://uat-analytics.thecarecloud.com/netlink/plugin/cda/api/doQuery?path=/home/test/IOS App/IOS1.0.cda&dataAccessId=qry_TotalHoursBySupplierName&parampStartDate=%@&parampEndDate=%@&parampLocation=All"

#define URL_GET_USER_COFIG_INFO             @"https://uat-analytics.thecarecloud.com/netlink/plugin/cda/api/doQuery?path=/home/test/IOS App/IOS1.0.cda&dataAccessId=qry_Config"


#define STRING_LOGIN_SUCCESSFUL             @"Netlink User Console"


#define ALERT_MESSAGE_LOGIN_UNSUCCESSFUL    @"Unable to login. Please try again."
#define ALERT_TITLE_LOGIN_ERROR             @"Error"

#define ALERT_BUTTON_TITLE_OK               @"OK"

#define NOTIFICATION_GO_TO_LANDING_PAGE     @"goToLandingPage"



#define NAME_PLIST_LOGIN                                @"login.plist"

#define NAME_PLIST_DATA_GRAPH                           @"data.plist"

#define NAME_PLIST_USER_CONFIG                          @"config.plist"












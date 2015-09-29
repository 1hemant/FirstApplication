//
//  SecondViewController.h
//  FirstApplication
//
//  Created by Hemant Rathore on 28/09/15.
//  Copyright © 2015 Hemant Rathore. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYPieChart.h"
@interface SecondViewController : UIViewController <XYPieChartDataSource>
{
    XYPieChart *pieChart;
}

@end

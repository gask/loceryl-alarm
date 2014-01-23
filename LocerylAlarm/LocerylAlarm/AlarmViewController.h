//
//  AlarmViewController.h
//  LocerylAlarm
//
//  Created by Giovanni Barreira Ferraro on 12/24/13.
//  Copyright (c) 2013 Giovanni Barreira Ferraro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlarmViewController : UIViewController
{
    
}

- (IBAction) delayAlarmTenMinutes: (id)sender;
- (IBAction) delayAlarmThirtyMinutes: (id)sender;
- (IBAction) delayAlarmOneHour: (id)sender;
- (IBAction) delayAlarmFourHours: (id)sender;
- (IBAction) delayAlarmTwelveHours: (id)sender;
- (void) scheduleLocalNotificationWithDate: (NSDate *) fireDate;

@end

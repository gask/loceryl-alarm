//
//  AlarmViewController.h
//  LocerylAlarm
//
//  Created by Giovanni Barreira Ferraro on 12/24/13.
//  Copyright (c) 2013 Giovanni Barreira Ferraro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlarmViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>
{
    
    
}

@property (weak, nonatomic) IBOutlet UIPickerView *snoozePicker;

- (IBAction) setDelayToAlarm: (id)sender;

- (void) scheduleLocalNotificationWithDate: (NSDate *) fireDate;

@end

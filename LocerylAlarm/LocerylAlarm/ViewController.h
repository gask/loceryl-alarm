//
//  ViewController.h
//  LocerylAlarm
//
//  Created by Giovanni Barreira Ferraro on 12/5/13.
//  Copyright (c) 2013 Giovanni Barreira Ferraro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>
{
    //IBOutlet UIDatePicker *dateTimePicker;
    IBOutlet UITextField *dayField;
    //IBOutlet UITextField *monthField;
    //IBOutlet UITextField *yearField;
    //NSDateComponents *fieldDate;
    IBOutlet UIDatePicker *dateInput;
    IBOutlet UIToolbar *pickerToolbar;
    IBOutlet UIButton *dismissButton;
}

-(void) presentMessage: (NSString *) message;
-(void) scheduleLocalNotificationWithDate: (NSDate *) fireDate;
-(IBAction) alarmSetButtonTapped:(id)sender;
-(IBAction) alarmCancelButtonTapped:(id)sender;
-(IBAction) doneAction: (id) sender;

@end

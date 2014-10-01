//
//  QuizController.h
//  LocerylAlarm
//
//  Created by Giovanni Barreira Ferraro on 6/18/14.
//  Copyright (c) 2014 Giovanni Barreira Ferraro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuizController : UIViewController
{
    NSInteger selectedQuestion;
}

@property (retain, nonatomic) NSArray *questionArray;
@property (retain, nonatomic) NSArray *answerArray;
@property (retain, nonatomic) NSArray *tipArray;

@property (strong, nonatomic) IBOutlet UILabel *questionText;
@property (strong, nonatomic) IBOutlet UILabel *tipText;
@property (strong, nonatomic) IBOutlet UIButton *truthButton;
@property (strong, nonatomic) IBOutlet UIButton *lieButton;
@property (strong, nonatomic) IBOutlet UIImageView *lieConfirmation;
@property (strong, nonatomic) IBOutlet UIImageView *truthConfirmation;
@property (strong, nonatomic) IBOutlet UIButton *lastButton;
@property (strong, nonatomic) IBOutlet UIButton *nextButton;

- (IBAction)nextQuestion:(id)sender;
- (IBAction)lastQuestion:(id)sender;
- (IBAction)guess:(id)sender;
- (NSArray *) questionArray;
- (NSArray *) answerArray;
- (NSArray *) tipArray;

@end

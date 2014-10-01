//
//  QuizController.m
//  LocerylAlarm
//
//  Created by Giovanni Barreira Ferraro on 6/18/14.
//  Copyright (c) 2014 Giovanni Barreira Ferraro. All rights reserved.
//

#import "QuizController.h"

@interface QuizController ()

@end

@implementation QuizController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    selectedQuestion = [[NSUserDefaults standardUserDefaults] integerForKey:@"selectedQuestion"];
    
    if(selectedQuestion == 0)
    {
        self.lastButton.hidden = TRUE;
        self.nextButton.hidden = FALSE;
    }
    else if(selectedQuestion == self.questionArray.count-1)
    {
        self.lastButton.hidden = FALSE;
        self.nextButton.hidden = TRUE;
    }
    else
    {
        self.lastButton.hidden = FALSE;
        self.nextButton.hidden = FALSE;
    }
    
    self.lieConfirmation.hidden = TRUE;
    self.truthConfirmation.hidden = TRUE;
    self.tipText.hidden = TRUE;
    self.questionText.text = [self.questionArray objectAtIndex:selectedQuestion];
    self.tipText.text = [self.tipArray objectAtIndex:selectedQuestion];
    
    //NSLog(@"Caraca, o selectedQuestion é %i!!!!", selectedQuestion);
    
    // NSLog(@"Caraca, o first question é %@!!!!", [self.questionArray objectAtIndex:0]);
    
    self.questionText.numberOfLines = 0;
    self.tipText.numberOfLines = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)nextQuestion:(id)sender
{
    //NSLog(@"next! selected question before: %i", selectedQuestion);
    if(selectedQuestion == self.questionArray.count-2)
    {
        self.nextButton.hidden = TRUE;
    }
    if(selectedQuestion == 0)
    {
        self.lastButton.hidden = FALSE;
    }
    
    selectedQuestion++;
    [[NSUserDefaults standardUserDefaults] setInteger:selectedQuestion forKey:@"selectedQuestion"];
    
    self.lieButton.hidden = FALSE;
    self.truthButton.hidden = FALSE;
    self.lieConfirmation.hidden = TRUE;
    self.truthConfirmation.hidden = TRUE;
    self.tipText.text = [self.tipArray objectAtIndex:selectedQuestion];
    self.tipText.hidden = TRUE;
    self.questionText.text = [self.questionArray objectAtIndex:selectedQuestion];
    
}

- (IBAction)lastQuestion:(id)sender
{
    //NSLog(@"last! selected question before: %i", selectedQuestion);
    if(selectedQuestion == 1)
    {
        self.lastButton.hidden = TRUE;
    }
    if(selectedQuestion == self.questionArray.count-1)
    {
        self.nextButton.hidden = FALSE;
    }
    
    selectedQuestion--;
    [[NSUserDefaults standardUserDefaults] setInteger:selectedQuestion forKey:@"selectedQuestion"];
    
    self.lieButton.hidden = FALSE;
    self.truthButton.hidden = FALSE;
    self.lieConfirmation.hidden = TRUE;
    self.truthConfirmation.hidden = TRUE;
    self.tipText.text = [self.tipArray objectAtIndex:selectedQuestion];
    self.tipText.hidden = TRUE;
    self.questionText.text = [self.questionArray objectAtIndex:selectedQuestion];
}

- (IBAction)guess:(id)sender
{
    //NSLog(@"guessed to question: %i",selectedQuestion);
    
    if([[self.answerArray objectAtIndex:selectedQuestion] boolValue])
    {
        self.truthConfirmation.hidden = FALSE;
        self.lieConfirmation.hidden = TRUE;
        self.truthButton.hidden = TRUE;
        self.lieButton.hidden = FALSE;
    }
    else
    {
        self.truthConfirmation.hidden = TRUE;
        self.lieConfirmation.hidden = FALSE;
        self.truthButton.hidden = FALSE;
        self.lieButton.hidden = TRUE;
    }
    
    self.tipText.hidden = FALSE;
}

- (NSArray *) questionArray
{
    NSArray *theQuestionArray = [NSArray arrayWithObjects:
                                 @"Acidez do limão mata o fungo causador da micose da unha?",
                                 @"Passar alho nas unhas afetadas mata o fungo causador da micose de unha?",
                                 @"Lixa de unha e alicates transmitem micose de unha?",
                                 @"Micose passa de uma unha para a outra?",
                                 @"Álcool com cânfora cura micose de unha?",
                                 @"Atletas são mais sucetíveis a micose de unha devido ao uso de calçados fechados e maior probabilidade de traumas?",
                                 @"Micose de unha se cura sozinha, sem tratamento?", nil];
    
    return theQuestionArray;
}

- (NSArray *) tipArray
{
    NSArray *theTipArray = [NSArray arrayWithObjects:
                                 @"Mito! Deixe para usar limão na cozinha.",
                                 @"Mito! Use alho para temperar o almoço.",
                                 @"Verdade! Muito cuidado na manicure.",
                                 @"Verdade! Por isso é melhor tratar o quanto antes.",
                                 @"Mito! Esqueça essas receitas caseiras.",
                                 @"Verdade! Após a corrida, deixe os calçados em local arejado.",
                                 @"Mito! O tratamento é longo, cerca de 3 a 6 meses para as unhas das mãos e de 12 a 18 meses para as unhas dos pés. Este prazo se deve ao tempo de crescimento das unhas que não é rápido.", nil];
    
    return theTipArray;
}

- (NSArray *) answerArray
{
    NSNumber *falso = [NSNumber numberWithBool:FALSE];
    NSNumber *verdadeiro = [NSNumber numberWithBool:TRUE];
    
    NSArray *theAnswerArray = [NSArray arrayWithObjects:
                            falso,
                            falso,
                            verdadeiro,
                            verdadeiro,
                            falso,
                            verdadeiro,
                            falso, nil];
    
    return theAnswerArray;
}

@end

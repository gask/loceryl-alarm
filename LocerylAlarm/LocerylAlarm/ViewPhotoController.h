//
//  ViewPhotoController.h
//  LocerylAlarm
//
//  Created by Giovanni Barreira Ferraro on 6/5/14.
//  Copyright (c) 2014 Giovanni Barreira Ferraro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewPhotoController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *viewText;
@property (strong, nonatomic) IBOutlet UILabel *photoName;
@property (strong, nonatomic) IBOutlet UIButton *deleteButton;

- (IBAction)nextPhoto:(id)sender;
- (IBAction)previousPhoto:(id)sender;
- (IBAction)panned:(UIPanGestureRecognizer *)recognizer;
- (IBAction)pressedDelete:(id)sender;
- (IBAction)goBack:(id)sender;

@end

//
//  ViewPhotoController.m
//  LocerylAlarm
//
//  Created by Giovanni Barreira Ferraro on 6/5/14.
//  Copyright (c) 2014 Giovanni Barreira Ferraro. All rights reserved.
//

#import "ViewPhotoController.h"

@interface ViewPhotoController ()

@end

@implementation ViewPhotoController

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
    
    NSArray *picIDs = (NSArray *)[[NSUserDefaults standardUserDefaults] objectForKey:@"picIDs"];
    
    //int thisPicID = 1;
    if(picIDs.count <= 0)
    {
        //NSLog(@"sem fotos..");
        // Display notice saying no photos were taken.
        self.viewText.text = @"Sem fotos pra mostrar. Tire suas fotos!";
        self.deleteButton.hidden = YES;
    }
    else
    {
        //NSLog(@"com fotos..");
        
        self.deleteButton.hidden = NO;
        self.viewText.text = @"Acompanhe a evolução do tratamento.";
        
        // Show first photo
        NSInteger selectedIndex = [[NSUserDefaults standardUserDefaults] integerForKey:@"selectedIndex"];
        NSInteger selectedID = [(NSNumber *) [picIDs objectAtIndex:selectedIndex] integerValue];
        
        //NSLog(@"sel Ind %li", (long) selectedIndex);
        //NSLog(@"sel ID %li", (long) selectedID);
        
        //[[NSUserDefaults standardUserDefaults] setInteger: selectedIndex forKey:@"selectedIndex"];
        
        
        NSString *name = [NSString stringWithFormat: @"photoname%li", (long)selectedID];
        NSString *dateTimeString = [[NSUserDefaults standardUserDefaults] stringForKey:name];
        
        //NSLog(@"%@", name);
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
        NSString *filePath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"photoname%li.png", (long)selectedID]];
        
        //NSLog(@"%@", dateTimeString);
        
        //NSLog(@"%@", filePath);
        
        NSData *pngData = [NSData dataWithContentsOfFile:filePath];
        //UIImage *image = [[UIImage alloc] initWithContentsOfFile:filePath];
        UIImage *image = [UIImage imageWithData:pngData];

        //UIImage *fixedImage =
        //UIImage *cocofedo = [UIImage imageNamed:@"tela_1"];
        
        self.imageView.image = image;
        self.photoName.text = dateTimeString;
    }
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

- (IBAction)nextPhoto:(id)sender
{
    //NSLog(@"opa, btao next");
    NSInteger selectedIndex = [[NSUserDefaults standardUserDefaults] integerForKey:@"selectedIndex"];
    
    NSArray *picIDs = (NSArray *)[[NSUserDefaults standardUserDefaults] objectForKey:@"picIDs"];
   
    //NSLog(@"picsCount: %i", picIDs.count);
    
    if(picIDs.count != 0 && selectedIndex < picIDs.count-1)
    {
        NSInteger selectedID = [(NSNumber *) [picIDs objectAtIndex: selectedIndex] integerValue];
        //NSLog(@"ind %i e inte %i", selectedIndex, selectedID);
        //NSLog(@"opa, tem foto pra frente");
        selectedIndex++;
        selectedID = [(NSNumber *) [picIDs objectAtIndex: selectedIndex] integerValue];
        [[NSUserDefaults standardUserDefaults] setInteger:selectedIndex forKey:@"selectedIndex"];
        
        NSString *name = [NSString stringWithFormat: @"photoname%li", (long)selectedID];
        NSString *dateTimeString = [[NSUserDefaults standardUserDefaults] stringForKey:name];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
//        NSString *filePath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", dateTimeString]];
        
        NSString *filePath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"photoname%li.png", (long)selectedID]];
        
        //NSLog(@"opa, a foto é... %@", filePath);
        
        NSData *pngData = [NSData dataWithContentsOfFile:filePath];
        UIImage *image = [UIImage imageWithData:pngData];
        
        self.imageView.image = image;
        self.photoName.text = dateTimeString;
    }
}

- (IBAction)previousPhoto:(id)sender
{
   
    NSInteger selectedIndex = [[NSUserDefaults standardUserDefaults] integerForKey:@"selectedIndex"];
    //NSLog(@"opa, btao previous index:%i", selectedIndex);
    
    if(selectedIndex > 0)
    {
        
        NSArray *picIDs = (NSArray *)[[NSUserDefaults standardUserDefaults] objectForKey:@"picIDs"];
        NSInteger selectedID = [(NSNumber *) [picIDs objectAtIndex: selectedIndex] integerValue];
        //NSLog(@"ind %i e inte %i", selectedIndex, selectedID);
        //NSLog(@"opa, tem foto pra trás");
        
        selectedIndex--;
        selectedID = [(NSNumber *) [picIDs objectAtIndex: selectedIndex] integerValue];
        [[NSUserDefaults standardUserDefaults] setInteger:selectedIndex forKey:@"selectedIndex"];
        
        NSString *name = [NSString stringWithFormat: @"photoname%li", (long)selectedID];
        NSString *dateTimeString = [[NSUserDefaults standardUserDefaults] stringForKey:name];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
//        NSString *filePath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", dateTimeString]];
        
        NSString *filePath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"photoname%li.png", (long)selectedID]];
        
        //NSLog(@"opa, a foto é... %@", filePath);
        
        NSData *pngData = [NSData dataWithContentsOfFile:filePath];
        UIImage *image = [UIImage imageWithData:pngData];
        
        self.imageView.image = image;
        self.photoName.text = dateTimeString;
    }
}

- (IBAction)panned:(UIPanGestureRecognizer *)recognizer
{
    if(recognizer.state == UIGestureRecognizerStateEnded)
    {
        CGPoint velocity = [recognizer velocityInView: self.view];
        
        //NSLog(@"vel: %f", velocity.x);
        if(velocity.x > 500)
        {
            [self previousPhoto:nil];
        }
        else if(velocity.x < -500)
        {
            [self nextPhoto:nil];
        }
    }
}

- (IBAction)pressedDelete:(id)sender
{
    NSInteger selectedIndex = [[NSUserDefaults standardUserDefaults] integerForKey:@"selectedIndex"];
    
    NSMutableArray *mutablePicIDs = [NSMutableArray arrayWithArray: (NSArray *)[[NSUserDefaults standardUserDefaults] objectForKey:@"picIDs"]];
    
    NSInteger indexCount = mutablePicIDs.count;
    
    NSInteger selectedID = [(NSNumber *) [mutablePicIDs objectAtIndex: selectedIndex] integerValue];
    
    //NSLog(@"PEGOU O ID!!!!! e é: %i", selectedID);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"photoname%li.png", (long)selectedID]];
    
    [[NSFileManager defaultManager] removeItemAtPath:filePath error:NULL];
    
    [mutablePicIDs removeObjectAtIndex: selectedIndex];
    
    NSArray *picIDs = [NSArray arrayWithArray: mutablePicIDs];
    
    
    
    [[NSUserDefaults standardUserDefaults] setObject:picIDs forKey:@"picIDs"];
    
    //NSLog(@"array count: %i", indexCount);
    
    if(indexCount == 1)
    {
        //NSLog(@"count 1");
        // remove o botão delete, mostrar label dizendo que não tem mais fotos
        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"selectedIndex"];
        
        
        self.viewText.text = @"Sem fotos pra mostrar. Tire suas fotos!";
        self.deleteButton.hidden = YES;
        self.imageView.image = NULL;
        
    }
    else if(indexCount > 1 && selectedIndex == 0)
    {
        //NSLog(@"index 0");
        
        selectedID = [(NSNumber *) [picIDs objectAtIndex: selectedIndex] integerValue];
        
        NSString *name = [NSString stringWithFormat: @"photoname%li", (long)selectedID];
        NSString *dateTimeString = [[NSUserDefaults standardUserDefaults] stringForKey:name];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
        //        NSString *filePath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", dateTimeString]];
        
        NSString *filePath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"photoname%li.png", (long)selectedID]];
        
        //NSLog(@"opa, a foto é... %@", filePath);
        
        NSData *pngData = [NSData dataWithContentsOfFile:filePath];
        UIImage *image = [UIImage imageWithData:pngData];
        
        self.imageView.image = image;
        self.photoName.text = dateTimeString;

    }
    else
    {
        //NSLog(@"index qualquer");

        selectedIndex--;
        selectedID = [(NSNumber *) [picIDs objectAtIndex: selectedIndex] integerValue];
        [[NSUserDefaults standardUserDefaults] setInteger:selectedIndex forKey:@"selectedIndex"];
        
        NSString *name = [NSString stringWithFormat: @"photoname%li", (long)selectedID];
        NSString *dateTimeString = [[NSUserDefaults standardUserDefaults] stringForKey:name];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
        //        NSString *filePath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", dateTimeString]];
        
        NSString *filePath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"photoname%li.png", (long)selectedID]];
        
        //NSLog(@"opa, a foto é... %@", filePath);
        
        NSData *pngData = [NSData dataWithContentsOfFile:filePath];
        UIImage *image = [UIImage imageWithData:pngData];
        
        self.imageView.image = image;
        self.photoName.text = dateTimeString;
    }
    
    if(picIDs.count == 0) self.photoName.text = @"";
    
    
    //NSLog(@"deletooooooo :(");
}

- (IBAction)goBack:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

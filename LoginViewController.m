//
//  LoginViewController.m
//  OneThousand
//
//  Created by Xiomara on 7/12/14.
//  Copyright (c) 2014 CODE2040. All rights reserved.
//

#import "LoginViewController.h"
#import "PicturesViewController.h"
#import "PhotoDetailViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

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
    logintitle.font = [UIFont fontWithName:@"Franchise" size:40];
    gohome.titleLabel.font = [UIFont fontWithName:@"Franchise" size:70];
    
    username.backgroundColor = [UIColor whiteColor];
    username.layer.masksToBounds =  YES;
    username.bounds = CGRectMake(0, 0, 270, 50);
    
    password.backgroundColor = [UIColor whiteColor];
    password.layer.masksToBounds =  YES;
    password.bounds = CGRectMake(0, 0, 270, 50);
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    
    // prevents the scroll view from swallowing up the touch event of child buttons
    tapGesture.cancelsTouchesInView = NO;
    
    [scrollviewlogin addGestureRecognizer:tapGesture];
    
    UIBarButtonItem *signinButton = [[UIBarButtonItem alloc] initWithTitle:@"sign-in" style:UIBarButtonItemStyleBordered target:self action:@selector(nextlogin:)];
    self.navigationItem.rightBarButtonItem = signinButton;
    
    //UIBarButtonItem *imageButton = [[UIBarButtonItem alloc] initWithTitle:@"pictures" style:UIBarButtonItemStyleBordered target:self action:@selector(loadParseImage:forImageColumn:withProgressBar:andCompletionBlock:)];
    //self.navigationItem.leftBarButtonItem = imageButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)hideKeyboard{
    [username resignFirstResponder];
    [password resignFirstResponder];
}

- (IBAction)nextlogin:(id)sender {
    if(username.text.length == 0){
        UIAlertView *fillboxes = [[UIAlertView alloc] initWithTitle:@"Boxes are empty" message:@"Please fill the empty boxes" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [fillboxes show];
    }else
        
        if(password.text.length == 0){
            UIAlertView *fillboxes = [[UIAlertView alloc] initWithTitle:@"Boxes are empty" message:@"Please fill the empty boxes" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [fillboxes show];
        }else{
                // sign up
                NSLog(@"go next");
            [self.view endEditing:YES];
            NSString *user = [username text];
            NSString *pass = [password text];
            username.userInteractionEnabled = NO;
            password.userInteractionEnabled = NO;
            if ([user length] < 4 || [pass length] < 4) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Entry" message:@"Username and Password must both be at least 4 characters long." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
                [alert show];
                username.userInteractionEnabled = YES;
                password.userInteractionEnabled = YES;
            } else {
                [activityIndicator startAnimating];
                [PFUser logInWithUsernameInBackground:user password:pass block:^(PFUser *user, NSError *error) {
                    [activityIndicator stopAnimating];
                    if (user) {
                        [self performSegueWithIdentifier:@"loginToMain" sender:self];                    } else {
                        NSLog(@"%@",error);
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Failed." message:@"Invalid Username and/or Password." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
                        [alert show];
                        username.userInteractionEnabled = YES;
                        password.userInteractionEnabled = YES;
                    }
                }];
            }
            }

}

- (IBAction)showPictures:(id)sender{
    PhotoDetailViewController *controller = [[PhotoDetailViewController alloc]initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
    
}

@end

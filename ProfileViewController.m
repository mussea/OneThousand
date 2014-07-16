//
//  ProfileViewController.m
//  OneThousand
//
//  Created by Xiomara on 7/12/14.
//  Copyright (c) 2014 CODE2040. All rights reserved.
//

#import "ProfileViewController.h"
#import <Parse/Parse.h>


@interface ProfileViewController ()

@end

@implementation ProfileViewController

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
    UIGraphicsBeginImageContext(self.view.frame.size);
    
    PFUser *user = [PFUser currentUser];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Skills"];
    [query whereKey:@"email" equalTo:user.username];
    [query countObjectsInBackgroundWithBlock:^(int count, NSError *error) {
        if (!error) {
            if (count==0) {
                UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                [self.view addSubview:button];
                [button setTitle:@"Press Me" forState:UIControlStateNormal];
                [button sizeToFit];
                button.center = CGPointMake(100, 350);
                
                NSLog(@"Here is: %i", count);
            }
            else{
                 [self performSegueWithIdentifier:@"interest" sender:self];
                NSLog(@"Here is: %i", count);

                
            }
            //NSLog(@"Sean has played %d games", count);
        } else {
            // The request failed
        }
    }];

    
    
    
    
    /*
    [[UIImage imageNamed:@"bg.png"] drawInRect:CGRectMake(0, 0, self.view.frame.size.width, 360)];
    UIImage *imagee = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    recentimage.backgroundColor = [UIColor colorWithPatternImage:imagee];
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"bg.png"] drawInRect:CGRectMake(0, 0, 190, 290)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    img1.backgroundColor = [UIColor colorWithPatternImage:image];
    img1.center =  CGPointMake(67, 120);
    [imagesScroll addSubview:img1];
    
    img2.backgroundColor = [UIColor colorWithPatternImage:image];
    img2.center =  CGPointMake(67+img1.bounds.size.width*1+2, 120);
    [imagesScroll addSubview:img2];
    
    img3.backgroundColor = [UIColor colorWithPatternImage:image];
    img3.center =  CGPointMake(67+img1.bounds.size.width*2+2*2, 120);
    [imagesScroll addSubview:img3];
    
    img4.backgroundColor = [UIColor colorWithPatternImage:image];
    img4.center =  CGPointMake(67+img1.bounds.size.width*3+2*3, 120);
    [imagesScroll addSubview:img4];
    
    img5.backgroundColor = [UIColor colorWithPatternImage:image];
    img5.center =  CGPointMake(67+img1.bounds.size.width*4+2*4, 120);
    [imagesScroll addSubview:img5];
    
    img6.backgroundColor = [UIColor colorWithPatternImage:image];
    img6.center =  CGPointMake(67+img1.bounds.size.width*5+2*5, 120);
    [imagesScroll addSubview:img6];
    
    img7.backgroundColor = [UIColor colorWithPatternImage:image];
    img7.center =  CGPointMake(67+img1.bounds.size.width*6+2*6, 120);
    [imagesScroll addSubview:img7];
    
    img8.backgroundColor = [UIColor colorWithPatternImage:image];
    img8.center =  CGPointMake(67+img1.bounds.size.width*7+2*7, 120);
    [imagesScroll addSubview:img8];
    
    img9.backgroundColor = [UIColor colorWithPatternImage:image];
    img9.center =  CGPointMake(67+img1.bounds.size.width*8+2*8, 120);
    [imagesScroll addSubview:img9];
    
    img10.backgroundColor = [UIColor colorWithPatternImage:image];
    img10.center =  CGPointMake(67+img1.bounds.size.width*9+2*9, 120);
    [imagesScroll addSubview:img10];
    
    img11.backgroundColor = [UIColor colorWithPatternImage:image];
    img11.center =  CGPointMake(67+img1.bounds.size.width*10+2*10, 120);
    [imagesScroll addSubview:img11];
    
    img12.backgroundColor = [UIColor colorWithPatternImage:image];
    img12.center =  CGPointMake(67+img1.bounds.size.width*11+2*11, 120);
    [imagesScroll addSubview:img12];
    
    imagesScroll.contentSize = CGSizeMake(67+img1.bounds.size.width*11+90, 0);
     */
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end

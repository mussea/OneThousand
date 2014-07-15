//
//  ViewController.h
//  OneThousand
//
//  Created by Xiomara on 7/12/14.
//  Copyright (c) 2014 CODE2040. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    IBOutlet UILabel *mtitle;
    IBOutlet UIButton *loginbtn;
}
- (IBAction)linkedinSignup:(id)sender;
- (IBAction)emailSignup:(id)sender;
- (IBAction)login:(id)sender;
@end

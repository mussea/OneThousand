//
//  PicturesViewController.h
//  OneThousand
//
//  Created by Xiomara on 7/12/14.
//  Copyright (c) 2014 CODE2040. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "MBProgressHUD.h"
#import <stdlib.h>

@interface PicturesViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, MBProgressHUDDelegate> {
    
    IBOutlet UIScrollView *photoScrollView;
    
    
    MBProgressHUD *HUD;
    MBProgressHUD *refreshHUD;
}

+(void)loadParseImage:(PFObject *)parseObject forImageColumn:(NSString *)columnName withProgressBar:(UIProgressView *)progressBar andCompletionBlock:(void (^)(UIImage *imageFile, NSError *error))completionBlock;

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIProgressView *progressBar;
@property (nonatomic)  NSMutableArray *allImages;

- (IBAction)refresh:(id)sender;
- (IBAction)cameraButtonTapped:(id)sender;
- (void)uploadImage:(NSData *)imageData;
- (void)setUpImages:(NSMutableArray *)images;
- (void)buttonTouched:(id)sender;

@end


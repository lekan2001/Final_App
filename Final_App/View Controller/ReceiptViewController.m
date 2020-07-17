//
//  ReceiptViewController.m
//  Final_App
//
//  Created by Olalekan Abdurazaq Adisa on 7/17/20.
//  Copyright © 2020 Facebook University. All rights reserved.
//

#import "ReceiptViewController.h"
//#import "Receipt.h"
#import "AppDelegate.h"
#import <Parse/Parse.h>
//#import <Parse.PFTextField.h>
@interface ReceiptViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *receiptImageView;
//@property (weak, nonatomic) IBOutlet PFTextField *receiptComment;
@property(strong,nonatomic) UIImage *originalImage;
@property (weak, nonatomic) IBOutlet UIButton *saveReceipt;
@property (weak, nonatomic) IBOutlet UIButton *cameraOption;

@end

@implementation ReceiptViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)snapReceipt:(id)sender {
    
    NSLog(@"I am tapped");

    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    //imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePickerVC.delegate = self;
        imagePickerVC.allowsEditing = YES;
      
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    
    
    
    [self presentViewController:imagePickerVC animated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    
    
    // Get the image captured by the UIImagePickerController
    self.originalImage = info[UIImagePickerControllerOriginalImage];
    self.receiptImageView.image= self.originalImage;
    
  
    [self dismissViewControllerAnimated:YES completion:nil];
    
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

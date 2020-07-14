//
//  LoginViewController.m
//  Final_App
//
//  Created by Olalekan Abdurazaq Adisa on 7/14/20.
//  Copyright © 2020 Facebook University. All rights reserved.
//

#import "LoginViewController.h"
#import "Parse/Parse.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.passwordField.secureTextEntry = YES;
    // Do any additional setup after loading the view.
}


//SignUp Method
- (IBAction)signUp:(id)sender {
    PFUser *newUser = [PFUser user];
    newUser.username = self.usernameField.text;
    newUser.password = self.passwordField.text;
    
    [newUser signUpInBackgroundWithBlock: ^(BOOL succeeded, NSError * error) {
    
    
    
    if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                   message:@"Unable to Register... Please Try again"
            preferredStyle:(UIAlertControllerStyleAlert)];
            // create an OK action
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * _Nonnull action) {
                                                                     // handle response here.
                                                             }];
            // add the OK action to the alert controller
            [alert addAction:okAction];
            [self presentViewController:alert animated:YES completion:^{
                // optional code for what happens after the alert controller has finished presenting
            }];
            
        } else {
            NSLog(@"User sign up successfully");
            
            // display view controller that needs to shown after successful login
        }
    }];
    
    if ([self.usernameField.text isEqual:@""]){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Username Required"
               message:@"Please enter a username"
        preferredStyle:(UIAlertControllerStyleAlert)];
        
        // create an OK action
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                                 // handle response here.
           
        }];
        
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:^{
            // optional code for what happens after the alert controller has finished presenting
        }];
    }
    
    if ([self.passwordField.text isEqual:@""]){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Password Required"
               message:@"Please enter a username"
        preferredStyle:(UIAlertControllerStyleAlert)];
        
        // create an OK action
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                                 // handle response here.
           
        }];
        
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:^{
            // optional code for what happens after the alert controller has finished presenting
        }];
    }
    
    
    
    
    
    
}

//Login Method
- (IBAction)login:(id)sender {
    
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
        } else {
            NSLog(@"User logged in successfully");
            
        
            
           
            
            // display view controller that needs to shown after successful login
           // [self performSegueWithIdentifier:@"firstSegue" sender:nil];
        }
        
    }];
    
    
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

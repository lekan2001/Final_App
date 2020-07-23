//
//  ViewController.m
//  Final_App
//
//  Created by Olalekan Abdurazaq Adisa on 7/22/20.
//  Copyright © 2020 Facebook University. All rights reserved.
//

#import "ViewController.h"
#import "ViewController+PLKPlaidLinkViewDelegate.h"
#import "ViewController+CustomConfiguration.h"
#import "ViewController+SharedConfiguration.h"
#import "ViewController+UpdateMode.h"
#import "ViewController+ItemAddToken.h"
#import "ViewController+OAuthSupport.h"
#import "ViewController+PaymentInitiation.h"
@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *plaidButton;


@property (weak, nonatomic) IBOutlet UILabel *plaidLabel;

@end

@implementation ViewController

@synthesize oauthNonce = _oauthNonce;

- (void)awakeFromNib {
    [super awakeFromNib];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveNotification:)
                                                 name:@"PLDPlaidLinkSetupFinished"
                                               object:nil];
}







- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   

   
    
    
}


- (void)didReceiveNotification:(NSNotification*)notification {
    if ([@"PLDPlaidLinkSetupFinished" isEqualToString:notification.name]) {
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:notification.name
                                                      object:self];
        self.plaidButton.enabled = YES;
    }
}

- (NSURL*)oauthRedirectUri {
//    #warning Replace <#YOUR_OAUTH_REDIRECT_URI#> below with your oauthRedirectUri, which should be a universal link and must be configured in the Plaid developer dashboard
//    # warning Ensure to also replace YOUR_OAUTH_REDIRECT_URI in the Associated Domains Capability or in the LinkDemo-ObjC.entitlements
//    # warning Remember to change the application Bundle Identifier to match one you have configured for universal links
    return [NSURL URLWithString:@"<#YOUR_OAUTH_REDIRECT_URI#>"];
}

- (NSString*)oauthNonce {
    // When re-initializing Link to complete the OAuth flows ensure that the same oauthNonce is used per session.
    // This is a simplified example for demonstaration purposes only.
    if (_oauthNonce == nil) {
        _oauthNonce = [[NSUUID UUID] UUIDString];
    }
    return _oauthNonce;
}



- (IBAction)didTapPlaidBtn:(id)sender {
    typedef enum : NSUInteger {
        customConfiguration,
        sharedConfiguration,
        updateMode,
        itemAddToken,
        oauthSupport,
        paymentInitiation,
    } PlaidLinkSampleFlow;
    //#warning Select your desired Plaid Link sample flow
    PlaidLinkSampleFlow sampleFlow = customConfiguration;
    switch (sampleFlow) {
        case sharedConfiguration:
            [self presentPlaidLinkWithSharedConfiguration];
            break;
        case updateMode:
            [self presentPlaidLinkInUpdateMode];
            break;
        case itemAddToken:
            [self presentPlaidLinkUsingItemAddToken];
            break;
        case oauthSupport:
            [self presentPlaidLinkWithOAuthSupport:nil];
            break;
        case paymentInitiation:
            [self presentPlaidLinkWithPaymentInitation:nil];
            break;
        case customConfiguration:
            // Intentionally fallthrough
        default:
            [self presentPlaidLinkWithCustomConfiguration];
            break;
    }
    
    
    
    
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

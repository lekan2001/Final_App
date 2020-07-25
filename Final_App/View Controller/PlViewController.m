//
//  PlViewController.m
//  Final_App
//
//  Created by Olalekan Abdurazaq Adisa on 7/23/20.
//  Copyright © 2020 Facebook University. All rights reserved.
//

#import "PlViewController.h"
#import "ViewController+PLKPlaidLinkViewDelegate.h"
#import "ViewController+CustomCofiguration.h"
#import "ViewController+OAuthSupport.h"
#import "ViewController+SharedConfiguration.h"
#import "ViewController+LinkToken.h"
#import "AppDelegate.h"
@interface PlViewController ()

@property (weak, nonatomic) IBOutlet UILabel *PlaidInfo;
@property (weak, nonatomic) IBOutlet UIButton *PlaidButton;


@end

@implementation PlViewController
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

    NSBundle* linkKitBundle = [NSBundle bundleForClass:[PLKPlaidLinkViewController class]];
       NSString* linkName      = [linkKitBundle objectForInfoDictionaryKey:(NSString*)kCFBundleNameKey];
    self.PlaidInfo.text        = [NSString stringWithFormat:@"Objective-C — %@ %s+%.0f"
                                    , linkName, LinkKitVersionString, LinkKitVersionNumber];

}
- (void)didReceiveNotification:(NSNotification*)notification {
    if ([@"PLDPlaidLinkSetupFinished" isEqualToString:notification.name]) {
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:notification.name
                                                      object:self];
        self.PlaidButton.enabled = YES;
    }
}


- (NSURL*)oauthRedirectUri {
//    #warning Replace <#YOUR_OAUTH_REDIRECT_URI#> below with your oauthRedirectUri, which should be a universal link and must be configured in the Plaid developer dashboard
//    # warning Ensure to also replace YOUR_OAUTH_REDIRECT_URI in the Associated Domains Capability or in the LinkDemo-ObjC.entitlements
//    # warning Remember to change the application Bundle Identifier to match one you have configured for universal links
    return [NSURL URLWithString:@"com.adisaolalekan.Final-App://plaid-redirect"];
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
    
    NSLog(@"Plaid Btn");
    typedef enum : NSUInteger{
       customConfiguration,
        oauthSupport,
        linkToken,
        sharedConfiguration,
    }PlaidLinkSampleFlow;
    
PlaidLinkSampleFlow sampleFlow = linkToken;
    switch (sampleFlow) {
        case customConfiguration:
            //
            
            break;
            
        case oauthSupport:
            [self presentPlaidLinkWithOAuthSupport:nil];
            break;
            
//        case linkToken:
//            [self presentPlaidLinkUsingItemAddToken];
//             break;
            
         case sharedConfiguration:
            
            [self presentPlaidLinkWithSharedConfiguration];
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

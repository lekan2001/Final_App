//
//  ViewController+UpdateMode.m
//  Final_App
//
//  Created by Olalekan Abdurazaq Adisa on 7/22/20.
//  Copyright © 2020 Facebook University. All rights reserved.
//

#import <LinkKit/LinkKit.h>

#import "ViewController+UpdateMode.h"
#import "ViewController+PLKPlaidLinkViewDelegate.h"

@implementation ViewController (UpdateMode)

// MARK: Start Plaid Link in update mode
// For details about update mode please see https://plaid.com/docs/link/ios/#update-mode
- (void)presentPlaidLinkInUpdateMode {

    #warning Replace <#YOUR_PLAID_PUBLIC_KEY#> and <#GENERATED_PUBLIC_TOKEN#> below with your public_key and public_token
    // <!-- SMARTDOWN_UPDATE_MODE -->
    // With public_token for update mode
    PLKConfiguration* linkConfiguration = [[PLKConfiguration alloc] initWithKey:@"b492f87ed4b70e98bdf3a68e034368" env:PLKEnvironmentSandbox product:PLKProductAuth];
    linkConfiguration.clientName = @"Link Demo";
    id<PLKPlaidLinkViewDelegate> linkViewDelegate  = self;
    PLKPlaidLinkViewController* linkViewController = [[PLKPlaidLinkViewController alloc] initWithPublicToken:@"<#GENERATED_PUBLIC_TOKEN#>" configuration:linkConfiguration delegate:linkViewDelegate];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        linkViewController.modalPresentationStyle = UIModalPresentationFormSheet;
    }
    [self presentViewController:linkViewController animated:YES completion:nil];
    // <!-- SMARTDOWN_UPDATE_MODE -->

}

@end


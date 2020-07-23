//
//  ViewController+CustomConfiguration.m
//  Final_App
//
//  Created by Olalekan Abdurazaq Adisa on 7/22/20.
//  Copyright © 2020 Facebook University. All rights reserved.
//
#import <LinkKit/LinkKit.h>
#import "ViewController+CustomConfiguration.h"
#import "ViewController+PLKPlaidLinkViewDelegate.h"

@implementation ViewController (CustomConfiguration)

// MARK: Start Plaid Link with custom instance configuration
- (void)presentPlaidLinkWithCustomConfiguration {

    //#warning Replace <#YOUR_PLAID_PUBLIC_KEY#> below with your public_key
    // <!-- SMARTDOWN_PRESENT_CUSTOM -->
    // With custom configuration
    @try {
        PLKConfiguration* linkConfiguration = [[PLKConfiguration alloc] initWithKey:@"b492f87ed4b70e98bdf3a68e034368" env:PLKEnvironmentSandbox product:PLKProductAuth];
        linkConfiguration.clientName = @"Link Demo";
        id<PLKPlaidLinkViewDelegate> linkViewDelegate  = self;
        PLKPlaidLinkViewController* linkViewController = [[PLKPlaidLinkViewController alloc] initWithConfiguration:linkConfiguration delegate:linkViewDelegate];
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            linkViewController.modalPresentationStyle = UIModalPresentationFormSheet;
        }
        [self presentViewController:linkViewController animated:YES completion:nil];
    } @catch (NSException *exception) {
        NSLog(@"Invalid configuration: %@", exception);
    }
    // <!-- SMARTDOWN_PRESENT_CUSTOM -->

}

@end


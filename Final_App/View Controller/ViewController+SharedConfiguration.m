//
//  ViewController+SharedConfiguration.m
//  Final_App
//
//  Created by Olalekan Abdurazaq Adisa on 7/22/20.
//  Copyright © 2020 Facebook University. All rights reserved.
//
#import <LinkKit/LinkKit.h>

#import "ViewController+SharedConfiguration.h"
#import "ViewController+PLKPlaidLinkViewDelegate.h"

@implementation ViewController (SharedConfiguration)

// MARK: Start Plaid Link with shared configuration from Info.plist
- (void)presentPlaidLinkWithSharedConfiguration {

//    #warning Replace <#YOUR_PLAID_PUBLIC_KEY#> for the LINK_KEY with your public_key in the Build Settings or or set key directly in this application's Info.plist
    // <!-- SMARTDOWN_PRESENT_SHARED -->
    // With shared configuration from Info.plist
    id<PLKPlaidLinkViewDelegate> linkViewDelegate  = self;
    PLKPlaidLinkViewController* linkViewController = [[PLKPlaidLinkViewController alloc] initWithDelegate:linkViewDelegate];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        linkViewController.modalPresentationStyle = UIModalPresentationFormSheet;
    }
    [self presentViewController:linkViewController animated:YES completion:nil];
    // <!-- SMARTDOWN_PRESENT_SHARED -->

}

@end

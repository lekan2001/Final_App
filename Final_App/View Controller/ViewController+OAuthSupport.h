//
//  ViewController+OAuthSupport.h
//  Final_App
//
//  Created by Olalekan Abdurazaq Adisa on 7/24/20.
//  Copyright © 2020 Facebook University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlViewController (OAuthSupport)
- (void)presentPlaidLinkWithOAuthSupport:(NSString* _Nullable)oauthStateId;
@end

NS_ASSUME_NONNULL_END



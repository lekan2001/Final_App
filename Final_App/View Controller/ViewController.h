//
//  ViewController.h
//  Final_App
//
//  Created by Olalekan Abdurazaq Adisa on 7/22/20.
//  Copyright © 2020 Facebook University. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ViewController : UIViewController
@property (readonly) NSURL* oauthRedirectUri;
@property (readonly) NSString* oauthNonce;
@end

NS_ASSUME_NONNULL_END

//
//  ViewController+PLKPlaidLinkViewDelegate.m
//  Final_App
//
//  Created by Olalekan Abdurazaq Adisa on 7/23/20.
//  Copyright © 2020 Facebook University. All rights reserved.
//

#import "ViewController+PLKPlaidLinkViewDelegate.h"


@implementation PlViewController (PLKPlaidLinkViewDelegate)
// MARK: - PLKPlaidLinkViewDelegate Protocol

// <!-- SMARTDOWN_DELEGATE_SUCCESS -->


- (void)linkViewController:(PLKPlaidLinkViewController*)linkViewController
 didSucceedWithPublicToken:(NSString*)publicToken
                  metadata:(NSDictionary<NSString*,id>* _Nullable)metadata {
    [self dismissViewControllerAnimated:YES completion:^{
        // Handle success, e.g. by storing publicToken with your service
        NSLog(@"Successfully linked account!\npublicToken: %@\nmetadata: %@", publicToken, metadata);
        [self publicToken];
        [self access_Token];
        [self getBalance];
        [self handleSuccessWithToken:publicToken metadata:metadata];
    }];
}
// <!-- SMARTDOWN_DELEGATE_SUCCESS -->

// <!-- SMARTDOWN_DELEGATE_EXIT -->
- (void)linkViewController:(PLKPlaidLinkViewController*)linkViewController
          didExitWithError:(NSError* _Nullable)error
                  metadata:(NSDictionary<NSString*,id>* _Nullable)metadata {
    [self dismissViewControllerAnimated:YES completion:^{
        if (error) {
            NSLog(@"Failed to link account due to: %@\nmetadata: %@", [error localizedDescription], metadata);
            [self handleError:error metadata:metadata];
        }
        else {
            NSLog(@"Plaid link exited with metadata: %@", metadata);
            [self handleExitWithMetadata:metadata];
        }
    }];
}
// <!-- SMARTDOWN_DELEGATE_EXIT -->

// <!-- SMARTDOWN_DELEGATE_EVENT -->
- (void)linkViewController:(PLKPlaidLinkViewController*)linkViewController
            didHandleEvent:(NSString*)event
                  metadata:(NSDictionary<NSString*,id>* _Nullable)metadata {
    NSLog(@"Link event: %@\nmetadata: %@", event, metadata);
}
// <!-- SMARTDOWN_DELEGATE_EVENT -->


// MARK: -

- (void)handleSuccessWithToken:(NSString*)publicToken metadata:(NSDictionary<NSString*,id>*)metadata {
    NSString* message = [NSString stringWithFormat:@"token: %@\nmetadata: %@", publicToken, metadata];
    [self presentAlertViewWithTitle:@"Success" message:message];
}

- (void)handleError:(NSError*)error metadata:(NSDictionary<NSString*,id>*)metadata {
    NSString* message = [NSString stringWithFormat:@"error: %@\nmetadata: %@", [error localizedDescription], metadata];
    [self presentAlertViewWithTitle:@"Failure" message:message];
}

- (void)handleExitWithMetadata:(NSDictionary<NSString*,id>*)metadata {
    NSString* message = [NSString stringWithFormat:@"metadata: %@", metadata];
    [self presentAlertViewWithTitle:@"Exit" message:message];
}

- (void)presentAlertViewWithTitle:(NSString*)title message:(NSString*)message {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK"
                                                            style:UIAlertActionStyleDefault
                                                          handler:nil];

    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}



-(void)getBalance{
    
    
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://sandbox.plaid.com/accounts/balance/get"]
      cachePolicy:NSURLRequestUseProtocolCachePolicy
      timeoutInterval:10.0];
    NSDictionary *headers = @{
      @"Content-Type": @"application/json"
    };

    [request setAllHTTPHeaderFields:headers];
    NSData *postData = [[NSData alloc] initWithData:[@"{\n  \"client_id\": \"5f18a1d2b89a9900124d8b90\",\n  \"secret\": \"bd12e8976f94de46e0bc5c46be2e27\",\n  \"access_token\": \"access-sandbox-d1ec736a-98dc-4af4-9ca6-7dab907e5207\"\n}" dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:postData];

    [request setHTTPMethod:@"POST"];

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
      if (error) {
        NSLog(@"%@", error);
      } else {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        NSError *parseError = nil;
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
        NSLog(@"%@",responseDictionary);
        dispatch_semaphore_signal(sema);
      }
    }];
    [dataTask resume];
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);



}



-(void)access_Token{
    
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://sandbox.plaid.com/item/public_token/exchange"]
      cachePolicy:NSURLRequestUseProtocolCachePolicy
      timeoutInterval:10.0];
    NSDictionary *headers = @{
      @"Content-Type": @"application/json"
    };
    [request setAllHTTPHeaderFields:headers];
    NSData *postData = [[NSData alloc] initWithData:[@"{\n    \"client_id\": \"5f18a1d2b89a9900124d8b90\",\n    \"secret\": \"bd12e8976f94de46e0bc5c46be2e27\",\n    \"public_token\": \"public-sandbox-cb778ce5-fa70-4294-90b6-d2c37d49e2ec\"\n}" dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:postData];
    [request setHTTPMethod:@"POST"];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
      if (error) {
        NSLog(@"%@", error);
      } else {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        NSError *parseError = nil;
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
        NSLog(@"%@",responseDictionary);
        dispatch_semaphore_signal(sema);
      }
    }];
    [dataTask resume];
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    
    
}


-(void)publicToken{
    
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://sandbox.plaid.com/sandbox/public_token/create"]
      cachePolicy:NSURLRequestUseProtocolCachePolicy
      timeoutInterval:10.0];
    NSDictionary *headers = @{
      @"Content-Type": @"application/json",
      @"User-Agent": @"Plaid Postman"
    };
    [request setAllHTTPHeaderFields:headers];
    NSData *postData = [[NSData alloc] initWithData:[@"{\n  \"public_key\": \"b492f87ed4b70e98bdf3a68e034368\",\n  \"institution_id\": \"ins_3\",\n  \"initial_products\": [\"auth\"],\n  \"options\": {\n    \"webhook\": \"https://www.genericwebhookurl.com/webhook\"\n  }\n}" dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:postData];
    [request setHTTPMethod:@"POST"];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
      if (error) {
        NSLog(@"%@", error);
      } else {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        NSError *parseError = nil;
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
        NSLog(@"%@",responseDictionary);
        dispatch_semaphore_signal(sema);
      }
    }];
    [dataTask resume];
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
}

@end

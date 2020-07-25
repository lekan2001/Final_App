//
//  AppDelegate.m
//  Final_App
//
//  Created by Olalekan Abdurazaq Adisa on 7/8/20.
//  Copyright © 2020 Facebook University. All rights reserved.
//

#import "AppDelegate.h"
#import "Parse/Parse.h"
#import "AFNetworking.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];

    NSString *url = @"https://development.plaid.com/link/token/create";
    NSDictionary *params = @{
        @"client_id" : @"5f18a1d2b89a9900124d8b90",
        @"secret" : @"c1fcbbe2724b06f8e88670fb00c497",
        @"client_name" : @"Tim's Demo",
        @"language" : @"en",
        @"country_codes" : @[@"US"],
        @"user" : @{ @"client_user_id" : @"123" },
        @"products" : @[@"transactions"]
    };
    NSDictionary *headers = @{
        @"Content-Type" : @"application/json",
    };

    [manager POST:url parameters:params headers:headers progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error.description);
    }];
    
    
    
    
    
    
    // Override point for customization after application launch.
    ParseClientConfiguration *config = [ParseClientConfiguration   configurationWithBlock:^(id<ParseMutableClientConfiguration> configuration) {
        
        configuration.applicationId = @"myAppId";
        configuration.server = @"http://final-project-fbu.herokuapp.com/parse";
    }];
    
    [Parse initializeWithConfiguration:config];
    

    

    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end

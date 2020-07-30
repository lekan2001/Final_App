//
//  AccountInfo.m
//  Final_App
//
//  Created by Olalekan Abdurazaq Adisa on 7/28/20.
//  Copyright © 2020 Facebook University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountInfo.h"

@implementation AccountInfo


+ (AccountInfo *) initWithDictionary:(NSDictionary *) dictionary{
    AccountInfo *accountInfo = [[AccountInfo alloc]init];
    accountInfo.balances = dictionary[@"balances"];
    accountInfo.name = dictionary[@"name"];
    accountInfo.subtype = dictionary[@"subtype"];
    return accountInfo;
}

@end

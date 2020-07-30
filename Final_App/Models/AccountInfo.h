//
//  AccountInfo.h
//  Final_App
//
//  Created by Olalekan Abdurazaq Adisa on 7/28/20.
//  Copyright © 2020 Facebook University. All rights reserved.
//

#ifndef AccountInfo_h
#define AccountInfo_h
@interface AccountInfo :NSObject

@property (nonatomic, strong) NSDictionary *balances;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *subtype;

+ (AccountInfo *) initWithDictionary:(NSDictionary *) dictionary;
@end
#endif /* AccountInfo_h */

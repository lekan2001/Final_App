//
//  Receipt.h
//  Final_App
//
//  Created by Olalekan Abdurazaq Adisa on 7/17/20.
//  Copyright © 2020 Facebook University. All rights reserved.
//

#import <Parse/Parse.h>

NS_ASSUME_NONNULL_BEGIN

@interface Receipt : PFObject<PFSubclassing>

@property(nonatomic, strong) NSString *reciptID;
@property(nonatomic,strong) PFUser *author;
@property (nonatomic,strong)NSString *receiptCaption;
@property(nonatomic,strong)PFFileObject * receiptimage;


+ (void) postReceiptImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion;

@end

NS_ASSUME_NONNULL_END

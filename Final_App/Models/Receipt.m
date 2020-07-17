//
//  Receipt.m
//  Final_App
//
//  Created by Olalekan Abdurazaq Adisa on 7/17/20.
//  Copyright © 2020 Facebook University. All rights reserved.
//

#import "Receipt.h"


@implementation Receipt
@dynamic reciptID;
@dynamic author;
@dynamic receiptCaption;
@dynamic receiptimage;


+ (nonnull NSString *)parseClassName {
    return @"Receipt";
}


+ (void) postReceiptImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    Receipt *newReceipt = [Receipt new];
    newReceipt.receiptimage = [self getPFFileFromImage:image];
    newReceipt.author = [PFUser currentUser];
    newReceipt.receiptCaption = caption;
    
    [newReceipt saveInBackgroundWithBlock:completion];
    
}
+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
// check if image is not nil
if (!image) {
    return nil;
}
NSData *imageData = UIImageJPEGRepresentation(image, 0.6);
    if (!image) {
       return nil;
    }
    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
}



@end

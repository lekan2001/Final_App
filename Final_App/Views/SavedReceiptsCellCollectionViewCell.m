//
//  SavedReceiptsCellCollectionViewCell.m
//  Final_App
//
//  Created by Olalekan Abdurazaq Adisa on 8/5/20.
//  Copyright © 2020 Facebook University. All rights reserved.
//

#import "SavedReceiptsCellCollectionViewCell.h"
#import "Receipt.h"
@implementation SavedReceiptsCellCollectionViewCell




-(void)setupCell: (Receipt *) receipt{
//    Receipt *receipt = [Receipt new];
    self.receiptImage.file =receipt.receiptimage;
    NSLog(@"%@", self.receiptImage.file);
    [self.receiptImage loadInBackground];
  
}

@end

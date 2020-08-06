//
//  SavedReceiptsCellCollectionViewCell.h
//  Final_App
//
//  Created by Olalekan Abdurazaq Adisa on 8/5/20.
//  Copyright © 2020 Facebook University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
NS_ASSUME_NONNULL_BEGIN
@import Parse;
@interface SavedReceiptsCellCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet PFImageView *receiptImage;


@end

NS_ASSUME_NONNULL_END

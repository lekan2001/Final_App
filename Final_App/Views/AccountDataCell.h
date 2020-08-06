//
//  AccountDataCell.h
//  Final_App
//
//  Created by Olalekan Abdurazaq Adisa on 7/29/20.
//  Copyright © 2020 Facebook University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FoldingCell/FoldingCell-Swift.h>
NS_ASSUME_NONNULL_BEGIN

@interface AccountDataCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *accountNameType;

@property (weak, nonatomic) IBOutlet UILabel *AccountType;

@property (weak, nonatomic) IBOutlet UILabel *currentBalance;

@property (weak, nonatomic) IBOutlet UILabel *availableBalance;

@property (weak, nonatomic) IBOutlet UIButton *chartTestBtn;

- (void)setSelected:(BOOL)selected animated:(BOOL)animate;




@end

NS_ASSUME_NONNULL_END

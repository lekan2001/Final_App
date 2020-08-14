//
//  StockCell.h
//  Final_App
//
//  Created by Olalekan Abdurazaq Adisa on 7/16/20.
//  Copyright © 2020 Facebook University. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StockCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *stocknameLabel;

@property (weak, nonatomic) IBOutlet UILabel *regPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *percentChangeLabel;
@property (weak, nonatomic) IBOutlet UILabel *PrevCloseLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *InvestTimeControl;
@property (weak, nonatomic) IBOutlet UILabel *ReturnLabel;


@end

NS_ASSUME_NONNULL_END

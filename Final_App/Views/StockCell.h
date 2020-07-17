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
//@property (weak, nonatomic) IBOutlet UILabel *stockSymbolLabel;
@property (weak, nonatomic) IBOutlet UILabel *regPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *percentChangeLabel;
@property (weak, nonatomic) IBOutlet UILabel *PrevCloseLabel;

@end

NS_ASSUME_NONNULL_END

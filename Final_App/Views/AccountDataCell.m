//
//  AccountDataCell.m
//  Final_App
//
//  Created by Olalekan Abdurazaq Adisa on 7/29/20.
//  Copyright © 2020 Facebook University. All rights reserved.
//

#import "AccountDataCell.h"

@implementation AccountDataCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.availableBalance.alpha = 0;
    self.currentBalance.alpha = 0;
    
    [self setupGesture];
    

    // Configure the view for the selected state
}


-(void) viewDoubleTapped: (UILongPressGestureRecognizer*)recognizer{
    [UIView animateWithDuration:1 animations:^{
    self.availableBalance.alpha = 1;
    self.currentBalance.alpha = 1;
    }];
}
-(void)setupGesture{
    
   UILongPressGestureRecognizer *doubleTapRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(viewDoubleTapped:)];
    //doubleTapRecognizer.numberOfTapsRequired = 2;
    
    [self addGestureRecognizer:doubleTapRecognizer];
}




@end

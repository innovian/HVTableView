//
//  ExampleTableViewCell.m
//  HVTableView
//
//  Created by Parastoo Tabatabayi on 10/29/16.
//  Copyright © 2016 ParastooTb. All rights reserved.
//

#import "ExampleTableViewCell.h"

@implementation ExampleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state

}



+(NSString*)cellIdentifier{
    static NSString* cellIdentifier;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cellIdentifier = @"Content1";
    });
    return cellIdentifier;
}

- (IBAction)purchaseButtonDidTap:(id)sender {
    
    [_delegate ExampleTableViewCellDidTapPurchaseButton:self];

    
}
@end

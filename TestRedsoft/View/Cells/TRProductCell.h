//
//  TRProductCell.h
//  TestRedsoft
//
//  Created by Grigoriy Zherder on 06/08/2019.
//  Copyright © 2019 Grigoriy Zherder. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TRProductCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *productImageView;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *substanceTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *producerTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *rawPriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UIView *customContentView;
@property (strong, nonatomic) IBOutlet UIButton *saleButton;
@property (nonatomic) int sale;
@property (strong, nonatomic) IBOutlet UILabel *saleLabel;

- (void)configureWithObject:(id)object;

@end

NS_ASSUME_NONNULL_END

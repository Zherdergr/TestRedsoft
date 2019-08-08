//
//  TRProductCell.m
//  TestRedsoft
//
//  Created by Grigoriy Zherder on 06/08/2019.
//  Copyright © 2019 Grigoriy Zherder. All rights reserved.
//

#import "TRProductCell.h"
#import "TRProduct.h"

@implementation TRProductCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setupButtons];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setupButtons {
    self.saleButton.layer.cornerRadius = 5;
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.saleButton.bounds;
    UIColor *zeroColor = [UIColor clearColor];
    UIColor *sourceColor = [UIColor colorWithHue:0 saturation:0 brightness:24.f / 100.f alpha:0.30f];
    UIColor *destinationColor = [UIColor colorWithHue:0 saturation:0 brightness:24.f / 100.f alpha:0.30f];
    gradientLayer.startPoint = CGPointMake(0,0.5);
    gradientLayer.endPoint = CGPointMake(1,0.5);
    gradientLayer.colors = @[(id)zeroColor.CGColor, (id)sourceColor.CGColor, (id)destinationColor.CGColor, (id)zeroColor.CGColor];
    [self.saleButton.layer insertSublayer:gradientLayer atIndex:0];
}

- (void)configureWithObject:(id)object {
    self.productImageView.image = nil;
    TRProduct *product = object;
    self.titleLabel.text = product.productTitle;
    [self.titleLabel sizeToFit];
    self.substanceTitleLabel.text = product.substanceTitle;
    self.producerTitleLabel.text = product.producerTitle;
    [self.producerTitleLabel sizeToFit];
    self.rawPriceLabel.attributedText = nil;
  
    if (product.rawPrice > product.price) {
        NSString *rawPrice = [NSString stringWithFormat:@"%.2f р", product.rawPrice];
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:rawPrice];
        [attributeString addAttribute:NSStrikethroughStyleAttributeName
                            value:@1
                            range:NSMakeRange(0, [attributeString length])];
        self.rawPriceLabel.attributedText = attributeString;
       
    }
    self.priceLabel.text = [NSString stringWithFormat:@"%.2f р", product.price];
    [self loadImageWithUrlString:product.imageURL];
    self.customContentView.layer.cornerRadius = 15;
    self.customContentView.layer.borderColor = [self.rawPriceLabel.textColor CGColor];
    self.customContentView.layer.borderWidth = 1;
    self.sale = 100 - round(product.price / product.rawPrice * 100);
    if (self.sale > 0) {
         self.saleLabel.text = [NSString stringWithFormat:@"-%i%@", self.sale, @"%"];
         self.saleButton.hidden = NO;
     }
    else {
         self.saleLabel.text = @"";
         self.saleButton.hidden = YES;
    }
}

- (void)loadImageWithUrlString:(NSString *)urlString {
    __weak typeof (self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0), ^{
        UIImage *image;
        NSURL *url = [NSURL URLWithString:urlString];
        NSData *data = [NSData dataWithContentsOfURL:url];
        image = [UIImage imageWithData:data];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            __strong typeof (weakSelf) strongSelf = weakSelf;
           strongSelf.productImageView.image = image;
        });
    });
}

@end

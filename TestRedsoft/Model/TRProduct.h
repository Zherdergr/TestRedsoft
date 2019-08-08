//
//  TRProduct.h
//  TestRedsoft
//
//  Created by Grigoriy Zherder on 06/08/2019.
//  Copyright © 2019 Grigoriy Zherder. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TRProduct : NSObject

@property (nonatomic) long productId;
@property (strong, nonatomic) NSString *productTitle;
@property (strong, nonatomic) NSString *producerTitle;
@property (strong, nonatomic) NSString *substanceTitle;
@property (nonatomic) float price;
@property (nonatomic) float rawPrice;
@property (strong, nonatomic) NSString *imageURL;

- (instancetype)initWithDictionary:(NSDictionary *)product;

@end

NS_ASSUME_NONNULL_END

//
//  TRProduct.m
//  TestRedsoft
//
//  Created by Grigoriy Zherder on 06/08/2019.
//  Copyright © 2019 Grigoriy Zherder. All rights reserved.
//

#import "TRProduct.h"

@implementation TRProduct

- (instancetype)initWithDictionary:(NSDictionary *)product {
    self = [super init];
    if (self) {
        _productId = [product[@"id"] longValue];
        _productTitle = product[@"title"];
        _imageURL = product[@"image"];
        _producerTitle = product[@"producer_title"];
        _substanceTitle = product[@"substance_title"];
        _rawPrice = [product[@"raw_price"] floatValue];
        _price = [product[@"price"] floatValue];
    }
  
    return self;
}

@end

//
//  TRMoezdorovieDataProvider.h
//  TestRedsoft
//
//  Created by Grigoriy Zherder on 06/08/2019.
//  Copyright © 2019 Grigoriy Zherder. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TRMoezdorovieDataProvider : NSObject

+ (instancetype)sharedInstance;
- (void)obtainProducts:(NSInteger)page searchString:(NSString *)searchString withCompletion:(void (^)(NSArray *))completion;

@end

NS_ASSUME_NONNULL_END

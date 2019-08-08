//
//  Presenter.m
//  TestRedsoft
//
//  Created by Grigoriy Zherder on 06/08/2019.
//  Copyright © 2019 Grigoriy Zherder. All rights reserved.
//

#import "Presenter.h"
#import "TRMoezdorovieDataProvider.h"

@interface Presenter ()

@property (strong, nonatomic) TRMoezdorovieDataProvider *dataProvider;
@property (strong, nonatomic) NSMutableArray *productsArray;
@property (nonatomic) BOOL isNextPageLoading;
@property (nonatomic) NSInteger currentPage;
@property (strong, nonatomic) NSString *searchString;

@end

@implementation Presenter

- (void)didTriggerViewReadyEvent {
    self.currentPage = 1;
    self.searchString = @"";
    [self.view setupInitialState];
    self.dataProvider = [TRMoezdorovieDataProvider sharedInstance];
    [self firstPageLoad];
}

- (void)firstPageLoad {
    [self.dataProvider obtainProducts:self.currentPage searchString:self.searchString withCompletion:^(NSArray * products) {
        self.productsArray = [products mutableCopy];
        [self didObtainProducts];
    }];
}

- (void)didObtainProducts {
    [self.view setupProducts:self.productsArray];
}

- (void)didNoMoreData {
    [self.view lastPageLoaded];
}

- (void) didEndPageScroll {
    if (!self.isNextPageLoading) {
        self.isNextPageLoading = YES;
        self.currentPage++;
        [self.dataProvider obtainProducts:self.currentPage searchString:self.searchString withCompletion:^(NSArray * products) {
            [self.productsArray addObjectsFromArray:[products mutableCopy]];
            if (products.count > 0) {
                [self didObtainProducts];
            }
            else {
                [self didNoMoreData];
            }
            self.isNextPageLoading = NO;
        }];
    }
}

- (void)didSearchStringChange:(NSString *)newSearchString {
    self.searchString = newSearchString;
    self.currentPage = 1;
    [self firstPageLoad];
}

@end

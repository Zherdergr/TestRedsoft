//
//  TRMoezdorovieDataProvider.m
//  TestRedsoft
//
//  Created by Grigoriy Zherder on 06/08/2019.
//  Copyright © 2019 Grigoriy Zherder. All rights reserved.
//

#import "TRMoezdorovieDataProvider.h"
#import "TRProduct.h"

static const NSInteger TRPerPage = 10;

@interface TRMoezdorovieDataProvider ()

@property (strong, nonatomic) NSURLSessionDataTask *task;
@property (strong, nonatomic) NSMutableArray *productsArray;

@end

@implementation TRMoezdorovieDataProvider

+ (instancetype)sharedInstance {
    static TRMoezdorovieDataProvider *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[TRMoezdorovieDataProvider alloc] init];
        sharedInstance.productsArray = [[NSMutableArray alloc] init];
    });
    
    return sharedInstance;
}

- (void)obtainProducts:(NSInteger)page searchString:(NSString *)searchString withCompletion:(void (^)(NSArray *))completion {
    NSString *urlString = [NSString stringWithFormat:@"https://moezdorovie.ru/api/v2test/medicament/?token=95cc5d31-aca0-4206-b45f-f5480c332a93&params[page]=%ld&params[filter][perPage]=%ld&params[q]=%@", page, TRPerPage, searchString];
    
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:set];
    NSURL *url = [NSURL URLWithString:urlString];
    if (url) {
        NSURLSession *session = [NSURLSession sharedSession];
        if (self.task) {
            if (self.task.taskIdentifier > 0 && self.task.state == NSURLSessionTaskStateRunning) {
                [self.task cancel];
            }
        }
        __weak typeof (self) weakSelf = self;
        self.task = [session dataTaskWithURL:url completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
            if (!error) {
                [weakSelf.productsArray removeAllObjects];
                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                NSArray *products = json[@"result"][@"items"];
                for (NSDictionary *product in products) {
                    TRProduct *productFounded = [[TRProduct alloc] initWithDictionary:product];
                    [weakSelf.productsArray addObject:productFounded];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(weakSelf.productsArray);
                });
            }
        }];
        [self.task resume];
    }
}

@end

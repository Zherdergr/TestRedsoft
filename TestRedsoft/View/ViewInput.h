//
//  ViewControllerInput.h
//  TestRedsoft
//
//  Created by Grigoriy Zherder on 06/08/2019.
//  Copyright © 2019 Grigoriy Zherder. All rights reserved.
//

@protocol TRViewInput <NSObject>

- (void)setupInitialState;
- (void)setupProducts:(NSArray *)productsArray;
- (void)lastPageLoaded;

@end

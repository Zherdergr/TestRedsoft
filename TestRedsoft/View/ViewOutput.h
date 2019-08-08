//
//  ViewOutput.h
//  TestRedsoft
//
//  Created by Grigoriy Zherder on 07/08/2019.
//  Copyright © 2019 Grigoriy Zherder. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TRViewOutput <NSObject>

- (void)didTriggerViewReadyEvent;
- (void)didEndPageScroll;
- (void)didSearchStringChange:(NSString *)newSearchString;

@end


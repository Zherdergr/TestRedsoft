//
//  Presenter.h
//  TestRedsoft
//
//  Created by Grigoriy Zherder on 06/08/2019.
//  Copyright © 2019 Grigoriy Zherder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewInput.h"
#import "ViewOutput.h"

@interface Presenter : NSObject <TRViewOutput>

@property (nonatomic, weak) id<TRViewInput> view;

@end

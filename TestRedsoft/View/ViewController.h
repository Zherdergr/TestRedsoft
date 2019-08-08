//
//  ViewController.h
//  TestRedsoft
//
//  Created by Grigoriy Zherder on 06/08/2019.
//  Copyright © 2019 Grigoriy Zherder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewOutput.h"
#import "ViewInput.h"

@interface ViewController : UIViewController <TRViewInput>

@property (nonatomic, strong) id<TRViewOutput> output;

@end


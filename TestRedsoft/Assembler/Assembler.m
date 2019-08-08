//
//  Assembler.m
//  TestRedsoft
//
//  Created by Grigoriy on 07/08/2019.
//  Copyright © 2019 Grigoriy Zherder. All rights reserved.
//

#import "Assembler.h"
#import "Presenter.h"
#import "ViewController.h"

@implementation Assembler

+ (void)configureModulesWithView:(ViewController *)viewController {

    Presenter *presenter = [[Presenter alloc] init];
    presenter.view = (id)viewController;
    viewController.output = presenter;
    
}

@end

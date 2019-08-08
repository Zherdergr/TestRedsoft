//
//  ViewController.m
//  TestRedsoft
//
//  Created by Grigoriy Zherder on 06/08/2019.
//  Copyright © 2019 Grigoriy Zherder. All rights reserved.
//

#import "ViewController.h"
#import "Assembler.h"
#import "TRProductCell.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UIVisualEffectView *visualEffectView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) NSArray *products;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicatorView;
@property (strong, nonatomic) NSIndexPath *currentIndexPath;

@end

@implementation ViewController

- (void)loadView {
    [super loadView];
    if (!self.output) {
        [Assembler configureModulesWithView:self];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.output didTriggerViewReadyEvent];
}

- (void)setupInitialState {
    [self setupTableView];
    [self setupSearchBar];
 }

- (void)setupSearchBar {
    self.searchBar.delegate = self;
    self.searchBar.placeholder = @"Я ищу";
    self.searchBar.barTintColor = self.visualEffectView.tintColor;
    self.searchBar.layer.borderWidth = 1;
    self.searchBar.layer.borderColor = [self.visualEffectView.tintColor CGColor];
}

- (void)setupTableView {
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self registerCells];
}

- (void)registerCells {
    NSString *productCellClassName = NSStringFromClass([TRProductCell class]);
    UINib *productCellNib = [UINib nibWithNibName:productCellClassName bundle:nil];
    [self.tableView registerNib:productCellNib forCellReuseIdentifier:productCellClassName];
}

- (void)setupProducts:(NSArray *)productsArray {
    self.products = productsArray;
    [self.tableView reloadData];
    self.tableView.tableFooterView.hidden = YES;
}

- (void)lastPageLoaded {
     self.tableView.tableFooterView.hidden = YES;
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = NSStringFromClass([TRProductCell class]);
    TRProductCell *productCell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    [productCell configureWithObject:self.products[indexPath.row]];
    UITableViewCell *cell = productCell;

    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.products.count;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.products.count - 1) {
        UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] init];
        activityIndicator.frame = CGRectMake(0, 0, self.tableView.bounds.size.width, 44);
        [activityIndicator startAnimating];
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        self.tableView.tableFooterView = activityIndicator;
        self.tableView.tableFooterView.hidden = NO;
        [self.output didEndPageScroll];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [self.output didSearchStringChange:searchBar.text];
    if (self.products.count>0) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:NO];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end

//
//  ViewController.m
//  SpreadsheetViewDemo
//
//  Created by karos li on 2018/1/24.
//  Copyright © 2018年 karos. All rights reserved.
//

#import "ViewController.h"
#import <SpreadsheetView/SpreadsheetView-Swift.h>
#import "SpreadsheetViewDemo-Swift.h"

@interface ViewController () <SpreadsheetViewDataSource, SpreadsheetViewDelegate>

@property (nonatomic, strong) SpreadsheetView *spreadsheetView;

@property (nonatomic, strong) NSArray *header;
@property (nonatomic, strong) NSArray *data;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.spreadsheetView = [[SpreadsheetView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.spreadsheetView];
//    self.spreadsheetView.dataSource = nil;
    
    // 该库还不能再oc里使用，pod 导入和打成静态库都不行，因为 datasource 所属的类型并不能进行桥接
    // 改造了下源码，让其支持 oc 调用, 现在测试下
    CGFloat pxOfOne = 1.0 / [UIScreen mainScreen].scale;
    self.spreadsheetView.dataSource = self;
    self.spreadsheetView.delegate = self;
    self.spreadsheetView.bounces = NO;
    self.spreadsheetView.intercellSpacing = CGSizeMake(pxOfOne, pxOfOne);
    self.spreadsheetView.backgroundColor = [UIColor colorWithRed:229.0 / 255.0 green:229.0 / 255.0 blue:229.0 / 255.0 alpha:1];
    
    [self.spreadsheetView registerClass:HeaderCell.class forCellWithReuseIdentifier:NSStringFromClass(HeaderCell.class)];
    [self.spreadsheetView registerClass:TextCell.class forCellWithReuseIdentifier:NSStringFromClass(TextCell.class)];
    
    
    self.header = @[@"C1", @"C2", @"C3"];
    self.data = @[@[@"Row1_1", @"Row1_2", @"Row1_3"],
                  @[@"Row2_1", @"Row2_2", @"Row2_3"],
                  @[@"Row3_1", @"Row3_2", @"Row3_3"],
                  @[@"Row4_1", @"Row4_2", @"Row4_3"],
                  @[@"Row5_1", @"Row5_2", @"Row5_3"],];
    
    [self.spreadsheetView reloadData];
}

#pragma mark - SpreadsheetViewDataSource
- (NSInteger)numberOfColumnsIn:(SpreadsheetView * _Nonnull)spreadsheetView {
    return self.header.count;
}

- (NSInteger)numberOfRowsIn:(SpreadsheetView * _Nonnull)spreadsheetView {
    return 1 + self.data.count;
}

- (CGFloat)spreadsheetView:(SpreadsheetView * _Nonnull)spreadsheetView widthForColumn:(NSInteger)column {
    return ([UIScreen mainScreen].bounds.size.width - (self.header.count + 1) * spreadsheetView.intercellSpacing.width) / self.header.count;
}

- (CGFloat)spreadsheetView:(SpreadsheetView * _Nonnull)spreadsheetView heightForRow:(NSInteger)row {
    return 44;
}

- (Cell * _Nullable)spreadsheetView:(SpreadsheetView * _Nonnull)spreadsheetView cellForItemAt:(NSIndexPath * _Nonnull)indexPath {
    if (indexPath.row == 0) {
        Cell *cell = [spreadsheetView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(HeaderCell.class) for:indexPath];
        if ([cell isKindOfClass:HeaderCell.class]) {
            HeaderCell *headerCell = (HeaderCell *)cell;
            headerCell.label.text = self.header[indexPath.section];
        }
        
        return cell;
    } else {
        Cell *cell = [spreadsheetView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(TextCell.class) for:indexPath];
        if ([cell isKindOfClass:TextCell.class]) {
            TextCell *textCell = (TextCell *)cell;
            textCell.label.text = self.data[indexPath.row-1][indexPath.section];
        }
        
        return cell;
    }
}

- (NSArray<CellRange *> * _Nonnull)mergedCellsIn:(SpreadsheetView * _Nonnull)spreadsheetView {
    CellRange *range = [[CellRange alloc] initFrom:[NSIndexPath indexPathForRow:1 inSection:1] to:[NSIndexPath indexPathForRow:5 inSection:1]];
    
    
    return @[range];
}

- (NSInteger)frozenColumnsIn:(SpreadsheetView * _Nonnull)spreadsheetView {
    return 0;
}

- (NSInteger)frozenRowsIn:(SpreadsheetView * _Nonnull)spreadsheetView {
    return 0;
}

#pragma mark - SpreadsheetViewDelegate
- (void)spreadsheetView:(SpreadsheetView * _Nonnull)spreadsheetView didSelectItemAt:(NSIndexPath * _Nonnull)indexPath {
    
}
- (BOOL)spreadsheetView:(SpreadsheetView * _Nonnull)spreadsheetView shouldHighlightItemAt:(NSIndexPath * _Nonnull)indexPath {return YES;}
- (void)spreadsheetView:(SpreadsheetView * _Nonnull)spreadsheetView didHighlightItemAt:(NSIndexPath * _Nonnull)indexPath {}
- (void)spreadsheetView:(SpreadsheetView * _Nonnull)spreadsheetView didUnhighlightItemAt:(NSIndexPath * _Nonnull)indexPath {}
- (BOOL)spreadsheetView:(SpreadsheetView * _Nonnull)spreadsheetView shouldSelectItemAt:(NSIndexPath * _Nonnull)indexPath {return YES;}
- (BOOL)spreadsheetView:(SpreadsheetView * _Nonnull)spreadsheetView shouldDeselectItemAt:(NSIndexPath * _Nonnull)indexPath {return YES;}
- (void)spreadsheetView:(SpreadsheetView * _Nonnull)spreadsheetView didDeselectItemAt:(NSIndexPath * _Nonnull)indexPath {}

@end

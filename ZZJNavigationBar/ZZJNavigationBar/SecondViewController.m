//
//  SecondViewController.m
//  透明导航栏
//
//  Created by chefuzzj on 17/3/20.
//  Copyright © 2017年 chefuzzj. All rights reserved.
//

#import "SecondViewController.h"
#define maxOffsetY 200   //导航栏渐变的最大Y轴偏移量
#define minOffsetY 50   //导航栏渐变的最小Y轴偏移量
@interface SecondViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property(nonatomic,weak)UILabel * titleLabel;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationController.navigationBar.barTintColor = [UIColor yellowColor];
    self.navigationController.navigationBar.translucent = YES;
    
    NSLog(@"%@",self.navigationController.navigationBar.subviews);
    [[[self.navigationController.navigationBar subviews]objectAtIndex:0] setAlpha:0];
    
    [self setupBackButton];
}

-(void)setupBackButton
{
    UILabel * titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"这是一个标题";
    [titleLabel sizeToFit];
    self.titleLabel = titleLabel;
    self.navigationItem.titleView = self.titleLabel;
}



#pragma mark - <UIScrollViewDelegate> 监听tableView的滚动
// 渐变导航栏   范围 50-200
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat alpha = 0;
    if (offsetY <= minOffsetY) {
        
        self.titleLabel.textColor = [UIColor blackColor];
        //设置navigationBar整体的透明度
        [[[self.navigationController.navigationBar subviews]objectAtIndex:0] setAlpha:alpha];

    } else if(offsetY > minOffsetY && offsetY <= maxOffsetY){
        
        alpha = offsetY / (maxOffsetY - minOffsetY);
         self.titleLabel.textColor = [UIColor redColor];
        [[[self.navigationController.navigationBar subviews]objectAtIndex:0] setAlpha:alpha];

    }else{
        [[[self.navigationController.navigationBar subviews]objectAtIndex:0] setAlpha:1];
    }
    
}




#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"test --- %zd",indexPath.row];
    if (indexPath.row>3) {
        cell.backgroundColor = [UIColor blueColor];
    }else{
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    return cell;
}



@end

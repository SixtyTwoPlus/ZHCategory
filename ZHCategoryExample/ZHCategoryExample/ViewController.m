//
//  ViewController.m
//  ZHCategoryExample
//
//  Created by 周海林 on 2023/4/11.
//

#import "ViewController.h"
#import "ZHCategory.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGFloat width = 70;
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake((self.view.zh_width - width )/ 2, 100, width, 80)];
    [button setImage:[UIImage imageNamed:@"top_arrow"] forState:UIControlStateNormal];
    [button setTitle:@"历史记录" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:10];
    [button setTitleColor:UIColor.redColor forState:UIControlStateNormal];
    [button zh_layoutWithType:ZHButtonLayoutTypeImgTop margin:5];
    button.zh_center_y = self.view.center.y;
    button.backgroundColor = UIColor.greenColor;
    [self.view addSubview:button];
    
    
}


@end

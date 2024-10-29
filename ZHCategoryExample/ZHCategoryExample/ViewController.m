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
    [button setImage:[UIImage zh_gradientImage:@[UIColor.redColor,UIColor.blueColor,UIColor.blackColor,UIColor.redColor,UIColor.greenColor] directionType:ZHGradientDirectionVertical] forState:UIControlStateNormal];
    button.zh_center_y = self.view.center.y;
    button.zh_center_x = self.view.center.x;
    [self.view addSubview:button];
}


@end

//
//  ViewController.m
//  shareP
//
//  Created by wagn on 2018/5/2.
//  Copyright © 2018年 wagn. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+WebCache.h"

@interface ViewController ()
@property (nonatomic,strong) NSArray *jsonArray;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor yellowColor];
    
//    NSDictionary *dic = [NSDictionary dictionary];
//    dic = [self readLocalFileWithName:@"cook"];
//    NSLog(@"%@",dic);
//    
//    NSData *data= [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
//    NSLog(@"%@",data);
    
    _imageView = [[UIImageView alloc]init];
    _imageView.frame = CGRectMake(0, 0, 300, 400);
    [self.view addSubview:_imageView];
   
    
}

-(void)viewWillAppear:(BOOL)animated{
    NSString *tempString = [[NSUserDefaults standardUserDefaults]objectForKey:@"imageUrl"];
    tempString = @"http://github.com/wang22290/share-Extension/raw/master/1804600.png";
    [_imageView sd_setImageWithURL:[NSURL URLWithString:tempString] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
}

-(void)viewDidAppear:(BOOL)animated{
    
}

-(NSString *)setNumber{
    NSLog(@"99");
    NSString *temp = @"99999";
    return temp;
}

-(NSDictionary *)readLocalFileWithName:(NSString *)name {
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    // 对数据进行JSON格式化并返回字典形式
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

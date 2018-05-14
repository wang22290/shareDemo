//
//  CustomShareViewController.m
//  ShareExtensionDemo
//

//

#import "CustomShareViewController.h"

@interface CustomShareViewController ()

@end

@implementation CustomShareViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //定义一个容器视图来存放分享内容和两个操作按钮
    UIView *container = [[UIView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 300) / 2, (self.view.frame.size.height - 175) / 2, 300, 175)];
    container.layer.cornerRadius = 7;
    container.layer.borderColor = [UIColor lightGrayColor].CGColor;
    container.layer.borderWidth = 1;
    container.layer.masksToBounds = YES;
    container.backgroundColor = [UIColor whiteColor];
    container.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:container];
    
    //定义Post和Cancel按钮
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    cancelBtn.frame = CGRectMake(8, 8, 65, 40);
    [cancelBtn addTarget:self action:@selector(cancelBtnClickHandler:) forControlEvents:UIControlEventTouchUpInside];
    [container addSubview:cancelBtn];
    
    UIButton *postBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [postBtn setTitle:@"Post" forState:UIControlStateNormal];
    postBtn.frame = CGRectMake(container.frame.size.width - 8 - 65, 8, 65, 40);
    [postBtn addTarget:self action:@selector(postBtnClickHandler:) forControlEvents:UIControlEventTouchUpInside];
    [container addSubview:postBtn];
    
    //定义一个分享链接标签
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(8,
                                                               cancelBtn.frame.origin.y + cancelBtn.frame.size.height + 8,
                                                               container.frame.size.width - 16,
                                                               container.frame.size.height - 16 - cancelBtn.frame.origin.y - cancelBtn.frame.size.height)];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    [container addSubview:label];
    
    //获取分享链接
    __block BOOL hasGetUrl = NO;
    [self.extensionContext.inputItems enumerateObjectsUsingBlock:^(NSExtensionItem *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        [obj.attachments enumerateObjectsUsingBlock:^(NSItemProvider *  _Nonnull itemProvider, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([itemProvider hasItemConformingToTypeIdentifier:@"public.url"])
            {
                [itemProvider loadItemForTypeIdentifier:@"public.url" options:nil completionHandler:^(id<NSSecureCoding>  _Nullable item, NSError * _Null_unspecified error) {
                   
                    if ([(NSObject *)item isKindOfClass:[NSURL class]])
                    {
                        dispatch_async(dispatch_get_main_queue(), ^{
                           
                            label.text = ((NSURL *)item).absoluteString;
                            
                        });
                    }
                    
                }];
                
                hasGetUrl = YES;
                *stop = YES;
            }
            
            *stop = hasGetUrl;
            
        }];
        
    }];
}

- (void)cancelBtnClickHandler:(id)sender
{
    [self.extensionContext cancelRequestWithError:[NSError errorWithDomain:@"CustomShareError" code:NSUserCancelledError userInfo:nil]];
}

- (void)postBtnClickHandler:(id)sender
{
    //执行分享内容处理
    [self.extensionContext completeRequestReturningItems:@[] completionHandler:nil];
}

@end

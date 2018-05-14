//
//  ShareActViewController.h
//  ShareP
//
、
//

#import <UIKit/UIKit.h>

@interface ShareActViewController : UIViewController

/**
 *  选中时触发
 *
 *  @param handler 事件处理器
 */
- (void)onSelected:(void(^)(NSIndexPath *indexPath))handler;

@end

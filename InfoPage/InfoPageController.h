//
//  InfoPageController.h
//  VKMessenger
//
//  Created by Vitaly Shurin on 3/1/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InfoPageController : UIViewController
@property (strong, nonatomic) NSString * status;
@property (strong, nonatomic) NSString * bdata;
- (instancetype) init;

- (instancetype)initWithStatus: (NSString *)status
                  bdata:(NSString *)bdata;
@end

NS_ASSUME_NONNULL_END

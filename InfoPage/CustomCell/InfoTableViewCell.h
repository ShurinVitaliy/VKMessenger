//
//  TableViewCell.h
//  VKMessenger
//
//  Created by Vitaly Shurin on 3/4/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InfoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *bodyLabel;

@end

NS_ASSUME_NONNULL_END

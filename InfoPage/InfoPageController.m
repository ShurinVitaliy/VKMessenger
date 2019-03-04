//
//  InfoPageController.m
//  VKMessenger
//
//  Created by Vitaly Shurin on 3/1/19.
//  Copyright © 2019 Vitaly Shurin. All rights reserved.
//

#import "InfoPageController.h"
#import "InfoTableViewCell.h"

@interface InfoPageController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation InfoPageController

- (instancetype)init {
    self = [self initWithStatus:@""
                          bdata:@""];
    return self;
}

- (instancetype)initWithStatus :(NSString *)status bdata:(NSString *)bdata {
    self = [super init];
    if (self) {
        _status = status;
        _bdata = bdata;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Info";
    self.tableView.allowsSelection = false;
    self.tableView.separatorColor = UIColor.clearColor;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"infoCell";
    InfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    if (cell == nil) {
        [tableView registerNib: [UINib nibWithNibName: @"InfoTableViewCell" bundle: nil] forCellReuseIdentifier:cellIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier: cellIdentifier];
    }
    if (indexPath.row == 0) {
        cell.titleLabel.text = @"Status";
        cell.bodyLabel.text = _status;
    } else {
        cell.titleLabel.text = @"Date of Birth";
        cell.bodyLabel.text = _bdata;
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

@end



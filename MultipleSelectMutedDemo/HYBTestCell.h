//
//  HYBTestCell.h
//  MultipleSelectMutedDemo
//
//  Created by huangyibiao on 16/3/3.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HYBOptionalAnswerModel;

@interface HYBTestCell : UITableViewCell

- (void)configCellWithModel:(HYBOptionalAnswerModel *)model atIndexPath:(NSIndexPath *)indexPath;

- (void)setCellSelected:(BOOL)selected;

@end

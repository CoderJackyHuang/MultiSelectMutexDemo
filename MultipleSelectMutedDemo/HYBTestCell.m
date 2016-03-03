//
//  HYBTestCell.m
//  MultipleSelectMutedDemo
//
//  Created by huangyibiao on 16/3/3.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "HYBTestCell.h"
#import "HYBTestModel.h"

@interface HYBTestCell ()

@property (nonatomic, strong) UILabel  *optionalAnswerLabel;
@property (nonatomic, strong) UIButton *radioButton;
@property (nonatomic, copy) NSIndexPath *indexPath;

@end

@implementation HYBTestCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    self.radioButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.radioButton setImage:[UIImage imageNamed:@"unselect"] forState:UIControlStateNormal];
    [self.radioButton setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateSelected];
    [self.radioButton sizeToFit];
    self.radioButton.center = CGPointMake(self.radioButton.frame.size.width / 2 + 15,
                                          self.contentView.center.y);
    [self.contentView addSubview:self.radioButton];
    self.radioButton.userInteractionEnabled = NO;
    
    self.optionalAnswerLabel = [[UILabel alloc] init];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat x = self.radioButton.frame.size.width + self.radioButton.frame.origin.x + 20;
    self.optionalAnswerLabel.frame = CGRectMake(x,
                                                0,
                                                screenWidth - x - 15,
                                                self.contentView.frame.size.height);
    self.optionalAnswerLabel.numberOfLines = 0;
    [self.contentView addSubview:self.optionalAnswerLabel];
  }
  
  return self;
}


- (void)configCellWithModel:(HYBOptionalAnswerModel *)model atIndexPath:(NSIndexPath *)indexPath {
  self.indexPath = [indexPath copy];
  
  self.radioButton.selected = model.isSelected;
  self.optionalAnswerLabel.text = model.optionalAnswerSummary;
}

- (void)setCellSelected:(BOOL)selected {
  self.radioButton.selected = selected;
}

@end

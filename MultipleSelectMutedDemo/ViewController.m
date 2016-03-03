//
//  ViewController.m
//  MultipleSelectMutedDemo
//
//  Created by huangyibiao on 16/3/3.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "ViewController.h"
#import "HYBTestModel.h"
#import "HYBTestCell.h"

static NSString *kCellIdentifier = @"identifier";

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datasource;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.tableView = [[UITableView alloc] init];
  self.tableView.frame = self.view.bounds;
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
  [self.tableView registerClass:[HYBTestCell class] forCellReuseIdentifier:kCellIdentifier];
  [self.view addSubview:self.tableView];
  
  for (NSUInteger section = 0; section < 20; ++section) {
    HYBTestModel *model = [[HYBTestModel alloc] init];
    model.questionSummary = [NSString stringWithFormat:@"问题：这是第%ld题？", section];
    model.qid = [NSString stringWithFormat:@"%ld", section + 1];
    
    for (NSUInteger answers = 0; answers < 4; ++ answers) {
      HYBOptionalAnswerModel *answerModel = [[HYBOptionalAnswerModel alloc] init];
      answerModel.aid = [NSString stringWithFormat:@"%ld", answers + 1];
      answerModel.optionalAnswerSummary = [NSString stringWithFormat:@"%c. 可选答案%ld", (char)('A' + answers), answers];
      [model.optionalAnswers addObject:answerModel];
    }
    
//    // 分配互斥A/B/C与D互斥的情况
//    for (NSUInteger answers = 0; answers < 4; ++ answers) {
//      HYBOptionalAnswerModel *answerModel = [model.optionalAnswers objectAtIndex:answers];
//      // 模拟前三个答案与最后一个互斥
//      if (answers < 3) {
//        answerModel.strMutex_id = @"4";
//      } else {
//        answerModel.strMutex_id = @"1,2,3";
//      }
//    }
    
    // 分配互斥A与B互斥、C与D互斥的情况
    HYBOptionalAnswerModel *modelA = [model.optionalAnswers objectAtIndex:0];
    modelA.strMutex_id = @"2";
    HYBOptionalAnswerModel *modelB = [model.optionalAnswers objectAtIndex:1];
    modelB.strMutex_id = @"1";
    HYBOptionalAnswerModel *modelC = [model.optionalAnswers objectAtIndex:2];
    modelC.strMutex_id = @"4";
    HYBOptionalAnswerModel *modelD = [model.optionalAnswers objectAtIndex:3];
    modelD.strMutex_id = @"3";
    
    [self.datasource addObject:model];
  }
}

- (NSMutableArray *)datasource {
  if (_datasource == nil) {
    _datasource = [[NSMutableArray alloc] init];
  }
  
  return _datasource;
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  HYBTestCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
  
  HYBTestModel *model = [self.datasource objectAtIndex:indexPath.section];
  HYBOptionalAnswerModel *answerModel = [model.optionalAnswers objectAtIndex:indexPath.row];
  
  [cell configCellWithModel:answerModel atIndexPath:indexPath];
  
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  HYBTestModel *model = [self.datasource objectAtIndex:indexPath.section];
  HYBOptionalAnswerModel *answerModel = [model.optionalAnswers objectAtIndex:indexPath.row];
  
  answerModel.isSelected = !answerModel.isSelected;
  
  // 这里假设的是互斥是单一的，也就是说不存在多个相互互斥的状态。这里只考虑A/B/C/D中A/B/C都到D互斥的情况
  if (answerModel.isSelected) {
    for (HYBOptionalAnswerModel *otherAnswerModel in model.optionalAnswers) {
      if (otherAnswerModel != answerModel && [answerModel.mutexIds containsObject:otherAnswerModel.aid]) {
        // 互斥
        otherAnswerModel.isSelected = !answerModel.isSelected;
      }
    }
  }
  
  [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]
           withRowAnimation:UITableViewRowAnimationFade];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
  UIView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerIdentifeir"];
  UILabel *questionLabel = nil;
  if (view == nil) {
    view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    view.backgroundColor = [UIColor lightGrayColor];
    
    questionLabel = [[UILabel alloc] init];
    questionLabel.frame = CGRectMake(15, 0, view.frame.size.width - 30, 44);
    questionLabel.numberOfLines = 0;
    [view addSubview:questionLabel];
    questionLabel.tag = 100;
  }
  
  if (questionLabel == nil) {
    questionLabel = [view viewWithTag:100];
  }
  
  HYBTestModel *model = [self.datasource objectAtIndex:section];
  questionLabel.text = model.questionSummary;
  
  return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return self.datasource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  HYBTestModel *model = [self.datasource objectAtIndex:section];
  return model.optionalAnswers.count;
}

@end

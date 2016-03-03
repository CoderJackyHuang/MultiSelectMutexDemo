//
//  HYBTestModel.m
//  MultipleSelectMutedDemo
//
//  Created by huangyibiao on 16/3/3.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "HYBTestModel.h"

@implementation HYBTestModel

- (NSMutableArray *)optionalAnswers {
  if (_optionalAnswers == nil) {
    _optionalAnswers = [[NSMutableArray alloc] init];
  }
  
  return _optionalAnswers;
}

@end

@implementation HYBOptionalAnswerModel

- (NSArray *)mutexIds {
  if (self.strMutex_id == nil || self.strMutex_id.length == 0) {
    return nil;
  }
  
  NSArray *array = [self.strMutex_id componentsSeparatedByString:@","];
  return array;
}

@end

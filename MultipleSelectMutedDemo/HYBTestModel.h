//
//  HYBTestModel.h
//  MultipleSelectMutedDemo
//
//  Created by huangyibiao on 16/3/3.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYBTestModel : NSObject

// 问题id
@property (nonatomic, copy) NSString *qid;
@property (nonatomic, copy) NSString *questionSummary;
@property (nonatomic, copy) NSMutableArray *optionalAnswers;

@end

@interface HYBOptionalAnswerModel : NSObject

// 选项答案id
@property (nonatomic, copy) NSString *aid;
// 选项答案内容描述
@property (nonatomic, copy) NSString *optionalAnswerSummary;

// 辅助字段，标识是否选中
@property (nonatomic, assign) BOOL isSelected;

// 互斥的选项，以英文逗号分割
@property (nonatomic, copy) NSString *strMutex_id;

- (NSArray *)mutexIds;

@end

//
//  JFPickerView.h
//  JFKit
//
//  Created by MAC on 2018/1/17.
//  Copyright © 2018年 JoyFate. All rights reserved.
//

/**
    picker 的选择视图
 */

#import <UIKit/UIKit.h>

#import "JFPickerModel.h"

typedef NS_ENUM(NSInteger) {
    JFPickerType_Picker,
    JFPickerType_DatePicker
}JFPickerType;

typedef void(^JFPickerViewSelectBlock)(JFPickerModel *model);

@interface JFPickerView : UIView

@property (nonatomic, strong) NSArray<JFPickerModel *> *dataArray;              // pickerView 的数据源

@property (nonatomic, assign) UIDatePickerMode dateMode;                        // datePicker 的样式
@property (nonatomic, copy) NSString *formatString;                             // block 中 model 的时间格式
@property (nonatomic, strong) NSDate *minDate;                                  // 最小时间
@property (nonatomic, strong) NSDate *maxDate;                                  // 最大时间

@property (nonatomic, copy) JFPickerViewSelectBlock selectBlock;                // 确定按钮点击的 block


/**
 推荐初始化方法

 @param type  picker 的类型
 @return 实例化对象
 */
- (instancetype)initWithPickerType:(JFPickerType)type;

@end

//
//  TreeModel.h
//  weatherReport
//
//  Created by lanou3g on 16/3/3.
//  Copyright © 2016年 刘斌. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum : NSUInteger {
    NodeTypeSectionHead,
    NodeTypeRow,
}NodeType;
@interface TreeModel : NSObject
@property (nonatomic) NodeType type; //节点类型
@property (nonatomic) id nodeData;//节点数据
@property (nonatomic) BOOL isExpanded;//节点是否展开
@property (strong,nonatomic) NSMutableArray *sonNodes;//子节点
@end

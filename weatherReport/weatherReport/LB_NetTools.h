//
//  LB_NetTools.h
//  UILesson17_NetWorking2
//
//  Created by lanou3g on 15/12/29.
//  Copyright © 2015年 刘斌. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void(^DataBlock)(NSData *data);
typedef void (^ImageSolveBlock)(UIImage *image);

@interface LB_NetTools : NSObject
//封装旧方法
+(void)SolveDataWithUrl:(NSString *)StringUrl HttpMethod:(NSString *)method HttpBody:(NSString *)StringBody revokeBlock:(DataBlock)block;
//封装新方法
//如果是解析的话


+(void)SessionDataWithUrl:(NSString *)StringUrl HttpMethod:(NSString *)method HttpBody:(NSString *)StringBody revokeBlock:(DataBlock)block;


//自己写
//如果是下载图片  单纯的下载图片
+(void)SessionDownloadWithUrl:(NSString *)stringUrl revokeBlock:(ImageSolveBlock)block;

@end

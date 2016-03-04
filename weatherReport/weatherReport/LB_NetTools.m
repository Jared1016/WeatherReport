//
//  LB_NetTools.m
//  UILesson17_NetWorking2
//
//  Created by lanou3g on 15/12/29.
//  Copyright © 2015年 刘斌. All rights reserved.
//

#import "LB_NetTools.h"

@implementation LB_NetTools
//旧方法
+(void)SolveDataWithUrl:(NSString *)StringUrl HttpMethod:(NSString *)method HttpBody:(NSString *)StringBody revokeBlock:(DataBlock)block{
    NSURL *url = [NSURL URLWithString:StringUrl];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    //将所有的字母转换成大写
    NSString *Smethod = [method uppercaseString];
    if ([@"POST" isEqualToString:Smethod]) {
        [request setHTTPMethod:Smethod];
        NSData *bodyData = [StringBody dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:bodyData];
    }else if ([@"GET" isEqualToString:Smethod]){
        
    }else{
        @throw [NSException exceptionWithName:@"Param Error" reason:@"方法类型参数错误" userInfo:nil];
        return;
    }
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        block(data);
    }];
}
//新方法
+(void)SessionDataWithUrl:(NSString *)StringUrl HttpMethod:(NSString *)method HttpBody:(NSString *)StringBody revokeBlock:(DataBlock)block{
    NSURL *url = [NSURL URLWithString:StringUrl];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    NSString *Smethod = [method uppercaseString];
    if ([@"POST" isEqualToString:Smethod]) {
        [request setHTTPMethod:Smethod];
        NSData *bodyData = [StringBody dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:bodyData];
    }else if([@"GET" isEqualToString:Smethod]){
    }
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            block(data);
        });
    }];
    [task resume];
}



//新方法 搞图片
+(void)SessionDownloadWithUrl:(NSString *)stringUrl revokeBlock:(ImageSolveBlock)block{
    //1.创建url
    NSURL *url = [NSURL URLWithString:stringUrl];
    //2.创建请求对象
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    //3.创建会话
    NSURLSession *session = [NSURLSession sharedSession];
    //4.创建任务
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSData *ImageData = [NSData dataWithContentsOfURL:location];
        UIImage *image = [UIImage imageWithData:ImageData];
        //从子线程回到主线程进行界面更新    新方法是多线程
        dispatch_async(dispatch_get_main_queue(), ^{
            block(image);
        });
    }];
    [task resume];
    
    
    
    
    
}
@end
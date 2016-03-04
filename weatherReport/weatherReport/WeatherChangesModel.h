//
//  weatherChangesModel.h
//  weatherReport
//
//  Created by lanou3g on 16/3/2.
//  Copyright © 2016年 刘斌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherChangesModel : NSObject
/*天气标识ID*/
@property (nonatomic,strong)NSString *weatherid;
/*天气*/
@property (nonatomic,strong)NSString *weather;
/*低温*/
@property (nonatomic,strong)NSString *temp1;
/*高温*/
@property (nonatomic,strong)NSString *temp2;
/*开始小时*/
@property (nonatomic,strong)NSString *sh;
/*结束小时*/
@property (nonatomic,strong)NSString *eh;





@end

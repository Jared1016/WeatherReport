//
//  CityModel.h
//  weatherReport
//
//  Created by lanou3g on 16/3/3.
//  Copyright © 2016年 刘斌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityModel : NSObject


/*城市*/
@property (nonatomic,strong)NSString *city;
/*城市/区名称*/
@property (nonatomic,strong)NSString *district;
/*省份名称*/
@property (nonatomic,strong)NSString *province;


@end

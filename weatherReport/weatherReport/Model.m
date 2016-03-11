//
//  Model.m
//  weatherReport
//
//  Created by lanou3g on 16/2/29.
//  Copyright © 2016年 刘斌. All rights reserved.
//

#import "Model.h"

@implementation Model


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

//归档
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.date        forKey:@"date"];
    [aCoder encodeObject:self.chuanyi     forKey:@"chuanyi"];
    [aCoder encodeObject:self.ganmao      forKey:@"ganmao"];
    [aCoder encodeObject:self.kongtiao    forKey:@"kongtiao"];
    [aCoder encodeObject:self.wuran       forKey:@"wuran"];
    [aCoder encodeObject:self.xiche       forKey:@"xiche"];
    [aCoder encodeObject:self.yundong     forKey:@"yundong"];
    [aCoder encodeObject:self.ziwaixian   forKey:@"ziwaixian"];
    [aCoder encodeObject:self.cityName    forKey:@"cityName"];
    [aCoder encodeObject:self.dateTime    forKey:@"dateTime"];
    [aCoder encodeObject:self.pm25        forKey:@"pm25"];
    [aCoder encodeObject:self.quality     forKey:@"quality"];
    [aCoder encodeObject:self.des         forKey:@"des"];
    [aCoder encodeObject:self.time        forKey:@"time"];
    [aCoder encodeObject:self.humidity    forKey:@"humidity"];
    [aCoder encodeObject:self.img         forKey:@"img"];
    [aCoder encodeObject:self.info        forKey:@"info"];
    [aCoder encodeObject:self.direct      forKey:@"direct"];
    [aCoder encodeObject:self.power       forKey:@"power"];
    [aCoder encodeObject:self.windspeed   forKey:@"windspeed"];
    [aCoder encodeObject:self.temperature forKey:@"temperature"];
    [aCoder encodeObject:self.week        forKey:@"week"];
    [aCoder encodeObject:self.nongli      forKey:@"nongli"];
    [aCoder encodeObject:self.nowCity      forKey:@"nowCity"];
    
}
//反归档
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.date        = [aDecoder decodeObjectForKey:@"date"];
        self.chuanyi     = [aDecoder decodeObjectForKey:@"chuanyi"];
        self.ganmao      = [aDecoder decodeObjectForKey:@"ganmao"];
        self.kongtiao    = [aDecoder decodeObjectForKey:@"kongtiao"];
        self.wuran       = [aDecoder decodeObjectForKey:@"wuran"];
        self.xiche       = [aDecoder decodeObjectForKey:@"xiche"];
        self.yundong     = [aDecoder decodeObjectForKey:@"yundong"];
        self.ziwaixian   = [aDecoder decodeObjectForKey:@"ziwaixian"];
        self.cityName    = [aDecoder decodeObjectForKey:@"cityName"];
        self.dateTime    = [aDecoder decodeObjectForKey:@"dateTime"];
        self.pm25        = [aDecoder decodeObjectForKey:@"pm25"];
        self.quality     = [aDecoder decodeObjectForKey:@"quality"];
        self.des         = [aDecoder decodeObjectForKey:@"des"];
        self.time        = [aDecoder decodeObjectForKey:@"time"];
        self.humidity    = [aDecoder decodeObjectForKey:@"humidity"];
        self.img         = [aDecoder decodeObjectForKey:@"img"];
        self.info        = [aDecoder decodeObjectForKey:@"info"];
        self.direct      = [aDecoder decodeObjectForKey:@"direct"];
        self.power       = [aDecoder decodeObjectForKey:@"power"];
        self.windspeed   = [aDecoder decodeObjectForKey:@"windspeed"];
        self.temperature = [aDecoder decodeObjectForKey:@"temperature"];
        self.week        = [aDecoder decodeObjectForKey:@"week"];
        self.nongli      = [aDecoder decodeObjectForKey:@"nongli"];
        self.nowCity      = [aDecoder decodeObjectForKey:@"nowCity"];
    }
    return self;
}


@end

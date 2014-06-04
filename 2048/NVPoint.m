//
//  NVPoint.m
//  2048
//
//  Created by damon.zhu on 14-5-13.
//  Copyright (c) 2014年 HZCreative. All rights reserved.
//

#import "NVPoint.h"

@implementation NVPoint

-(id)initWithX:(int)x withY:(int)y{
    NVPoint *point = [self init];
    
    if (point) {
        point.x = x;
        point.y = y;
    }
    
    return point;
}


@end

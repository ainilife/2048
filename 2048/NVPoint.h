//
//  NVPoint.h
//  2048
//
//  Created by damon.zhu on 14-5-13.
//  Copyright (c) 2014年 HZCreative. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NVPoint : NSObject
@property (nonatomic) int x;
@property (nonatomic) int y;
@property (nonatomic) int num;

-(id)initWithX:(int)x withY:(int)y;

@end

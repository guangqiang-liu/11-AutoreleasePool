//
//  Person.m
//  10.4-ARC局部对象释放时机
//
//  Created by 刘光强 on 2020/2/16.
//  Copyright © 2020 guangqiang.liu. All rights reserved.
//

#import "Person.h"

@implementation Person

- (void)dealloc {    
    NSLog(@"%s", __func__);
}
@end

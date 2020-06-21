//
//  ViewController.m
//  10.4-ARC局部对象释放时机
//
//  Created by 刘光强 on 2020/2/16.
//  Copyright © 2020 guangqiang.liu. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"111");
    
    // 在ARC环境下，我们没有办法使用NSAutoreleasePool类，也不能使用autorelease函数，但是我们可以使用@autoreleasepool{}，和__autorelease
    
    /**
     通过打印可以发现：
        在ARC环境下，对于局部的对象，当对象出了局部作用域，就会立即释放
        但是在MRC环境下，局部对象调用了`autorelease`方法，将对象添加到自动释放池中，当局部对象出了作用域后，并没有立即被释放（因为自动释放池释放对象具有延缓释放的特点），而是由runloop的运行循环来控制这些局部对象的释放时机，在循环中当runloop即将进入休眠状态时，这时就会调用autoreleasePool的Pop方法来销毁自动释放池，释放池中的对象
     
        那么在ARC环境下，局部对象出了作用域就立即释放，又是怎么做到的尼？
            这是因为在ARC环境下，所有的对象都是由编译器来进行内存管理的，在局部对象出作用域前，编译器可能会在执行作用域的结束大括号时，直接调用对象的`release`方法，类似调用[person release];
     
     从上面的ARC和MRC的差异中，我们也可以看出，一个对象调用`autorelease`和调用`release`，这个对象的释放流程是不一样的：
        调用了`autorelease`，这个对象放入到自动释放池中，就由runloop来控制释放时机
        调用了`release`，那么就是直接调用objc_msgSend(obj, @selecte("release"))，立即释放对象
     
     */
    Person *person = [[Person alloc] init];
    
    NSLog(@"222");
    
    NSLog(@"%s", __func__);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog(@"%s", __func__);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSLog(@"%s", __func__);
}
@end

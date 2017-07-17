//
//  ViewController.m
//  CodeMixUp
//
//  Created by 何伟东 on 2017/7/17.
//  Copyright © 2017年 章鱼彩票. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSError *error = nil;
    
    NSString *func_h = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"func_h" ofType:@"txt"] encoding:NSUTF8StringEncoding error:&error];
    NSString *func_m = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"func_m" ofType:@"txt"] encoding:NSUTF8StringEncoding error:&error];
    NSString *class_h = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"class_h" ofType:@"txt"] encoding:NSUTF8StringEncoding error:&error];
    NSString *class_m = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"class_m" ofType:@"txt"] encoding:NSUTF8StringEncoding error:&error];
    
    
    //生成用户名
    int x = arc4random() % 5+1;
    NSString *createPeson = [self randomStringWithLength:x];
    func_h = [func_h stringByReplacingOccurrencesOfString:@"CreatePeson" withString:createPeson];
    func_m = [func_m stringByReplacingOccurrencesOfString:@"CreatePeson" withString:createPeson];
    class_h = [class_h stringByReplacingOccurrencesOfString:@"CreatePeson" withString:createPeson];
    class_m = [class_m stringByReplacingOccurrencesOfString:@"CreatePeson" withString:createPeson];
    
    //年
    //2012~2017
    NSString *year = @"2012";
    year = [NSString stringWithFormat:@"%d",[year intValue]+x-1];
    func_h = [func_h stringByReplacingOccurrencesOfString:@"Year" withString:year];
    func_m = [func_m stringByReplacingOccurrencesOfString:@"Year" withString:year];
    class_h = [class_h stringByReplacingOccurrencesOfString:@"Year" withString:year];
    class_m = [class_m stringByReplacingOccurrencesOfString:@"Year" withString:year];
    //年月日
    //1-12
    NSString *month = [NSString stringWithFormat:@"%d",arc4random() % 11+1];
    //1-28
    NSString *day = [NSString stringWithFormat:@"%d",arc4random() % 27+1];
    NSString *createTime = [NSString stringWithFormat:@"%@/%@/%@",year,month,day];
    func_h = [func_h stringByReplacingOccurrencesOfString:@"CreateTime" withString:createTime];
    func_m = [func_m stringByReplacingOccurrencesOfString:@"CreateTime" withString:createTime];
    class_h = [class_h stringByReplacingOccurrencesOfString:@"CreateTime" withString:createTime];
    class_m = [class_m stringByReplacingOccurrencesOfString:@"CreateTime" withString:createTime];
    
    //类名
    x = arc4random() % 100+3;
    NSString *className = [self randomStringWithLength:x];
    NSString *first = [className substringToIndex:1];
    first = [first uppercaseString];
    NSString *last = [className substringFromIndex:1];
    last = [last lowercaseString];
    className = [first stringByAppendingString:last];
    class_h = [class_h stringByReplacingOccurrencesOfString:@"ClassName" withString:className];
    class_m = [class_m stringByReplacingOccurrencesOfString:@"ClassName" withString:className];
    
    //继承类名
    NSString *extensionClass = [self randomExtensionClass];
    class_h = [class_h stringByReplacingOccurrencesOfString:@"ExtensionClass" withString:extensionClass];
    class_m = [class_m stringByReplacingOccurrencesOfString:@"ExtensionClass" withString:extensionClass];
    
    //参数
    NSString *parameter = @""
    x = arc4random() % 10+1;
    for (int i = 0; i <= x; i++) {
        //.h的参数
        NSString *name = [self randomStringWithLength:arc4random() % 100+3];
        NSString *class = [self randomExtensionClass];
        NSString *string = @"\\@property (strong, nonatomic) Class *name;\n";
        string = [string stringByReplacingOccurrencesOfString:@"Class" withString:class];
        string = [string stringByReplacingOccurrencesOfString:@"name" withString:name];
        
    }
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (NSString *)randomStringWithLength:(int)length{
    NSString *sourceStr = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < length; i++) {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}


-(NSString*)randomExtensionClass{
    int x = arc4random() % 10;
    NSArray *array = @[@"NSString",@"UIView",@"UILabel",@"UIImageView",@"NSObject",@"NSDictionary",@"NSArray",@"UIViewController",@"NSMutableDictionary",@"UITableView"];
    return array[x];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

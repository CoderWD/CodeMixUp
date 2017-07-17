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
    NSMutableArray *fileNameArray = [NSMutableArray array];
    NSMutableArray *funcNameArray = [NSMutableArray array];
    NSMutableArray *parameterNameArray = [NSMutableArray array];
    
    NSMutableArray *dicArray = [NSMutableArray array];
    //生成100-150个文件夹
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSString *pathDocuments = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    for (int i = 0; i <= arc4random() % 50+100; i++) {
        NSString *createDir = [NSString stringWithFormat:@"%@/MixUp/%@", pathDocuments,[self randomStringWithLength:arc4random() % 100+3]];
        [fileManager createDirectoryAtPath:createDir withIntermediateDirectories:YES attributes:nil error:nil];
        [dicArray addObject:createDir];
    }
    
    
    //生成1万份随机文件
    for (int i = 0; i <= 10000/3; i++) {
        
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
        NSString *parameter = @"";
        for (int i = 0; i <= arc4random() % 50+1; i++) {
            //.h的参数
            NSString *name = [self randomStringWithLength:arc4random() % 100+3];
            __block BOOL isExsit = NO;
            [parameterNameArray enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj isEqualToString:name]) {
                    *stop = YES;
                    isExsit = YES;
                }
            }];
            if (!isExsit) {
                NSString *className = [self randomExtensionClass];
                
                NSString *first = [name substringToIndex:1];
                first = [first uppercaseString];
                NSString *last = [name substringFromIndex:1];
                last = [last lowercaseString];
                name = [first stringByAppendingString:last];
                
                NSString *string = @"@property (strong, nonatomic) Class *name;";
                string = [string stringByReplacingOccurrencesOfString:@"Class" withString:className];
                string = [string stringByReplacingOccurrencesOfString:@"name" withString:name];
                //随机3换行符
                NSString *s = @"";
                for (int i = 0; i <= arc4random() % 2+1; i++) {
                    s = [s stringByAppendingString:@"\n"];
                }
                string = [string stringByAppendingString:s];
                parameter = [parameter stringByAppendingString:string];
                [parameterNameArray addObject:name];
            }
            
        }
        class_h = [class_h stringByReplacingOccurrencesOfString:@"Parameter" withString:parameter];
        
        //函数
        NSString *func_header = @"";
        NSString *func_m_content = @"";
        for (int i = 0; i <= arc4random() % 50+1; i++) {
            //.h
            __block BOOL isExsit = NO;
            NSString *funcName = [self randomStringWithLength:arc4random() % 100+3];
            [funcNameArray enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj isEqualToString:funcName]) {
                    *stop = YES;
                    isExsit = YES;
                }
            }];
            if (!isExsit) {
                //函数的参数个数
                NSString *parameter = @"";
                for (int i = 0; i <= arc4random() % 10+1; i++) {
                    NSString *name = [self randomStringWithLength:arc4random() % 100+3];
                    parameter = [NSString stringWithFormat:@"%@%@:(%@*)%@ ",parameter,name,[self randomExtensionClass],name];
                }
                NSString *h_funcName = [NSString stringWithFormat:@"-(void)%@%@;",funcName,parameter];
                h_funcName = [h_funcName stringByReplacingOccurrencesOfString:@" ;" withString:@";"];
                //随机3换行符
                NSString *s = @"";
                for (int i = 0; i <= arc4random() % 2+1; i++) {
                    s = [s stringByAppendingString:@"\n"];
                }
                h_funcName = [h_funcName stringByAppendingString:s];
                func_header = [func_header stringByAppendingString:h_funcName];
                
                s = @"";
                for (int i = 0; i <= arc4random() % 2+1; i++) {
                    s = [s stringByAppendingString:@"\n"];
                }
                NSString *s1 = @"";
                for (int i = 0; i <= arc4random() % 2+1; i++) {
                    s1 = [s1 stringByAppendingString:@"\n"];
                }
                //.m
                NSString *m_funcName = [NSString stringWithFormat:@"-(void)%@%@{%@}%@",funcName,parameter,s,s1];
                func_m_content = [func_m_content stringByAppendingString:m_funcName];
                [funcNameArray addObject:funcName];
            }
            
        }
        class_h = [class_h stringByReplacingOccurrencesOfString:@"Function" withString:func_header];
        class_m = [class_m stringByReplacingOccurrencesOfString:@"Function" withString:func_m_content];
        
        //去处相同的文件名
        __block BOOL isExsit = NO;
        [fileNameArray enumerateObjectsUsingBlock:^(NSString  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isEqualToString:className]) {
                isExsit = YES;
                *stop = YES;
            }
        }];
        if (!isExsit) {
            NSString *dic = dicArray[arc4random() % ([dicArray count]-1)];
            NSString *h_path = [dic stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.h",className]];
            NSString *m_path = [dic stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.m",className]];
            [class_h writeToFile:h_path atomically:YES encoding:NSUTF8StringEncoding error:&error];
            [class_m writeToFile:m_path atomically:YES encoding:NSUTF8StringEncoding error:&error];
            [fileNameArray addObject:className];
        }
    }
    
    
    // Do any additional setup after loading the view, typically from a nib.
}





- (NSString *)randomStringWithLength:(int)length{
    NSString *string = [[NSString alloc]init];
    for (int i = 0; i < length; i++) {
//        int number = arc4random() % 36;
//        if (number < 10) {
//            int figure = arc4random() % 10;
//            NSString *tempString = [NSString stringWithFormat:@"%d", figure];
//            string = [string stringByAppendingString:tempString];
//        }else {
            int figure = (arc4random() % 26) + 97;
            char character = figure;
            NSString *tempString = [NSString stringWithFormat:@"%c", character];
            string = [string stringByAppendingString:tempString];
//        }
    }
    return string;
//    
//    NSString *sourceStr = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
//    NSMutableString *resultStr = [[NSMutableString alloc] init];
//    srand((unsigned)time(0));
//    for (int i = 0; i < length; i++) {
//        unsigned index = rand() % [sourceStr length];
//        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
//        [resultStr appendString:oneStr];
//    }
//    return resultStr;
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

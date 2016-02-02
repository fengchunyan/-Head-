//
//  ViewController.m
//  Head请求
//
//  Created by 冯春燕 on 16/2/2.
//  Copyright © 2016年 冯春燕. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"




@interface ViewController (){
    
    AFURLSessionManager *manager ;

}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    manager = [[AFURLSessionManager alloc] init];

    NSString *stringURL = @"https://www.baidu.com";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:stringURL]];
    request.HTTPMethod = @"HEAD";
   NSURLSessionDataTask *task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
       
       
       [self loadDataWithURLResponse:response];
        
    }];
    
    [task resume];
    
}


//解析数据
- (void)loadDataWithURLResponse:(NSURLResponse *)response{
    
    NSHTTPURLResponse * r = (NSHTTPURLResponse *)response;
    NSDictionary *dic = r.allHeaderFields;
    
    //获取响应的时间
    NSString *dateString = dic[@"Date"];
    NSLog(@"%@",dateString);  //Tue, 02 Feb 2016 02:15:22 GMT

    //将字符串转换成时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"E,dd MM yyyy HH:mm:ss Z"];

    NSDate *date = [formatter dateFromString:dateString];
    NSLog(@"%@",date);//2016-02-02 02:50:22 +0000
    
//    获取当前时间
    NSDate *dateNow = [[NSDate alloc] init];
    NSLog(@"%@----",dateNow.description);  //2016-02-02 02:15:25 +0000----
    
    
    NSTimeInterval time1 =  [dateNow timeIntervalSinceNow];
    NSTimeInterval time2 = [date timeIntervalSinceNow];
    NSLog(@"%f***%f***", time1,time2);  //-0.000246***-3.609602***
    NSTimeInterval subTime = time1 - time2;
    NSLog(@"时间差值是:%f",subTime);

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

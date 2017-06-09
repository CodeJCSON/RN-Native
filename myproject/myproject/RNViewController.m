//
//  RNViewController.m
//  myproject
//
//  Created by 云媒 on 2017/6/8.
//  Copyright © 2017年 yunmei. All rights reserved.
//

#import "RNViewController.h"
#import <React/RCTBridge.h>
#import <React/RCTEventDispatcher.h>
@interface RNViewController ()

@end

@implementation RNViewController

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE();

//RN传参数调用原生OC,并且返回数据给RN  通过CallBack
RCT_EXPORT_METHOD(RNInvokeOCCallBack:(NSDictionary *)dictionary callback:(RCTResponseSenderBlock)callback){
    NSLog(@"接收到RN传过来的数据为:%@",dictionary);
    NSArray *events = [[NSArray alloc] initWithObjects:@"hahaha",@"lalalala", nil];
    callback(@[[NSNull null], events]);
}
//RN传参数调用原生OC,并且返回数据给RN  通过Promise
RCT_EXPORT_METHOD(RNInvokeOCPromise:(NSDictionary *)dictionary resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject){
    NSLog(@"接收到RN传过来的数据为:%@",dictionary);
    NSString *value=[dictionary objectForKey:@"name"];
    if([value isEqualToString:@"nihao"]){
        resolve(@"Promise:回调成功");
    }else{
        NSError *error=[NSError errorWithDomain:@"传入的name不符合要求,回调失败啦,Promise..." code:100 userInfo:nil];
        reject(@"100",@"Promise:失败",error);
    }
}
//RN跳转原生界面
//RCT_EXPORT_METHOD(RNOpenVC:(NSDictionary *)dictionary){
//   NSLog(@"RN传入原生界面的数据为:%@",[dictionary objectForKey:@"name"]);
//  [[NSNotificationCenter defaultCenter]postNotificationName:@"RNOpenVC" object:@{@"name":[NSString stringWithFormat:@"你好"],@"errorCode":@"0",@"msg":@"成功"}];
//}

//OC调用RN
RCT_EXPORT_METHOD(VCOpenRN:(NSDictionary *)dictionary){
    NSString *value=[dictionary objectForKey:@"name"];
    if([value isEqualToString:@"nihao"]){
        [self.bridge.eventDispatcher sendAppEventWithName:@"EventReminder" body:@{@"name":[NSString stringWithFormat:@"%@",value],@"errorCode":@"0",@"msg":@"成功"}];
    }else{
        [self.bridge.eventDispatcher sendAppEventWithName:@"EventReminder" body:@{@"name":[NSString stringWithFormat:@"%@",value],@"errorCode":@"0",@"msg":@"输入的name不是nihao"}];
    }
}
@end

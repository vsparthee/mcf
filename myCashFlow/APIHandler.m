//
//  APIHandler.m
//  OpenCart
//
//  Created by Parthiban on 03/08/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import "APIHandler.h"
#import <AFNetworking/AFNetworking.h>
@implementation APIHandler

#pragma mark CATAEGORY
-(void)userLogin: (NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
         failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure
{
    
    NSString * url = [NSString stringWithFormat:LOGIN,BASE_URL];
    NSLog(@"%@",url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSError *error;
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
         NSLog(@"JSON %@",JSON);
         success(JSON);     } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         failure(operation, error);
     }];
    
}


-(void)userRegister: (NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
         failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure
{
    
    NSString * url = [NSString stringWithFormat:REGISTER,BASE_URL];
    NSLog(@"%@",url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSError *error;
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
         NSLog(@"JSON %@",JSON);
         success(JSON);
     } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         failure(operation, error);
     }];
    
}



 -(void)api_financeFolder:(void (^)(id result))success
 failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure
{
    
    NSDictionary *userInfo = (NSDictionary*)[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:[userInfo valueForKey:@"CustomerID"] forKey:@"CustomerID"];
    NSString * url = [NSString stringWithFormat:API_FINANCE_FOLDER,BASE_URL];
    NSLog(@"%@",url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSError *error;
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
         
         //NSLog(@"JSON %@",JSON);
         success(JSON);     } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         failure(operation, error);
     }];
    
}


-(void)api_taxFolder:(void (^)(id result))success
                 failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure
{
    
    NSDictionary *userInfo = (NSDictionary*)[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:[userInfo valueForKey:@"CustomerID"] forKey:@"CustomerID"];
    NSString * url = [NSString stringWithFormat:API_TAX_FOLDER,BASE_URL];
    NSLog(@"%@",url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSError *error;
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
         
         //NSLog(@"JSON %@",JSON);
         success(JSON);     } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         failure(operation, error);
     }];
    
}


-(void)api_taxAppoinment:(void (^)(id result))success
             failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure
{
    
    NSDictionary *userInfo = (NSDictionary*)[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:[userInfo valueForKey:@"CustomerID"] forKey:@"CustomerID"];
    NSString * url = [NSString stringWithFormat:API_TAX_APPOINMENT,BASE_URL];
    NSLog(@"%@",url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSError *error;
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
         
         //NSLog(@"JSON %@",JSON);
         success(JSON);
     } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         failure(operation, error);
     }];
    
}


-(void)api_Message_Notifcation:(void (^)(id result))success
                 failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure
{
    
    NSDictionary *userInfo = (NSDictionary*)[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:[userInfo valueForKey:@"CustomerID"] forKey:@"CustomerID"];
    NSString * url = [NSString stringWithFormat:API_Message_Notifcation,BASE_URL];
    NSLog(@"%@",url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSError *error;
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
         
         //NSLog(@"JSON %@",JSON);
         success(JSON);     } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         failure(operation, error);
     }];
    
}


-(void)api_ConsulterDetails:(void (^)(id result))success
                       failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure
{
    
    NSDictionary *userInfo = (NSDictionary*)[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:[userInfo valueForKey:@"CustomerID"] forKey:@"CustomerID"];
    NSString * url = [NSString stringWithFormat:API_ConsulterDetails,BASE_URL];
    NSLog(@"%@",url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSError *error;
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
         
         //NSLog(@"JSON %@",JSON);
         success(JSON);     } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         failure(operation, error);
     }];
    
}

-(void)api_Recommendation: (NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
            failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure
{
    
    NSString * url = [NSString stringWithFormat:API_Recommendation,BASE_URL];
    NSLog(@"%@",url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSError *error;
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
         NSLog(@"JSON %@",JSON);
         success(JSON);     } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         failure(operation, error);
     }];
    
}


-(void)api_ContractAppoinmentList :(void (^)(id result))success
                    failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure
{
    
    NSDictionary *userInfo = (NSDictionary*)[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:[userInfo valueForKey:@"CustomerID"] forKey:@"CustomerID"];
    NSString * url = [NSString stringWithFormat:API_ContractAppoinmentList ,BASE_URL];
    NSLog(@"%@",url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSError *error;
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
         
         //NSLog(@"JSON %@",JSON);
         success(JSON);     } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         failure(operation, error);
     }];
    
}


-(void)api_BookContractAppoinmentList: (NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
                  failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure
{
    
    NSString * url = [NSString stringWithFormat:API_BookContractAppoinmentList,BASE_URL];
    NSLog(@"%@",url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSError *error;
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
         NSLog(@"JSON %@",JSON);
         success(JSON);     } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         failure(operation, error);
     }];
    
}

-(void)api_VideosList :(void (^)(id result))success
                           failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure
{
    
    NSDictionary *userInfo = (NSDictionary*)[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:[userInfo valueForKey:@"CustomerID"] forKey:@"CustomerID"];
    NSString * url = [NSString stringWithFormat:API_VideosList,BASE_URL];
    NSLog(@"%@",url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSError *error;
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
         
         //NSLog(@"JSON %@",JSON);
         success(JSON);     } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         failure(operation, error);
     }];
    
}


-(void)api_ContactList :(void (^)(id result))success
               failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure
{
    
    NSDictionary *userInfo = (NSDictionary*)[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:[userInfo valueForKey:@"CustomerID"] forKey:@"CustomerID"];
    NSString * url = [NSString stringWithFormat:API_ContactList,BASE_URL];
    NSLog(@"%@",url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSError *error;
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
         
         //NSLog(@"JSON %@",JSON);
         success(JSON);     } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         failure(operation, error);
     }];
    
}

-(void)api_Discount :(void (^)(id result))success
                failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure
{
    
    NSDictionary *userInfo = (NSDictionary*)[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:[userInfo valueForKey:@"CustomerID"] forKey:@"CustomerID"];
    NSString * url = [NSString stringWithFormat:API_Discount,BASE_URL];
    NSLog(@"%@",url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSError *error;
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
         
         //NSLog(@"JSON %@",JSON);
         success(JSON);     } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         failure(operation, error);
     }];
    
}

-(void)api_Documents :(void (^)(id result))success
                failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure
{
    
    NSDictionary *userInfo = (NSDictionary*)[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:[userInfo valueForKey:@"CustomerID"] forKey:@"CustomerID"];
    NSString * url = [NSString stringWithFormat:API_Documents,BASE_URL];
    NSLog(@"%@",url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic // Here you can pass array or dictionary
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    NSString *jsonString;
    if (jsonData) {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        //This is your JSON String
        //NSUTF8StringEncoding encodes special characters using an escaping scheme
    } else {
        NSLog(@"Got an error: %@", error);
        jsonString = @"";
    }
    NSLog(@"Your JSON String is %@", jsonString);
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSError *error;
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
         
         //NSLog(@"JSON %@",JSON);
         success(JSON);     } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         failure(operation, error);
     }];
    
}

-(void)api_ProductSolution :(void (^)(id result))success
                failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure
{
    
    NSDictionary *userInfo = (NSDictionary*)[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:[userInfo valueForKey:@"CustomerID"] forKey:@"CustomerID"];
    NSString * url = [NSString stringWithFormat:API_ProductSolution,BASE_URL];
    NSLog(@"%@",url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSError *error;
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
         
         //NSLog(@"JSON %@",JSON);
         success(JSON);     } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         failure(operation, error);
     }];
    
}

-(void)api_MyBudgetSetting :(void (^)(id result))success
                failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure
{
    
    NSDictionary *userInfo = (NSDictionary*)[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:[userInfo valueForKey:@"CustomerID"] forKey:@"CustomerID"];
    NSString * url = [NSString stringWithFormat:API_MyBudgetSetting,BASE_URL];
    NSLog(@"%@",url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSError *error;
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
         
         //NSLog(@"JSON %@",JSON);
         success(JSON);     } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         failure(operation, error);
     }];
    
}

-(void)api_MyBudgetSettingUpdate: (NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
                              failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure
{
    
    NSString * url = [NSString stringWithFormat:API_MyBudgetSettingUpdate,BASE_URL];
    NSLog(@"%@",url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic // Here you can pass array or dictionary
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    NSString *jsonString;
    if (jsonData) {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        //This is your JSON String
        //NSUTF8StringEncoding encodes special characters using an escaping scheme
    } else {
        NSLog(@"Got an error: %@", error);
        jsonString = @"";
    }
    NSLog(@"Your JSON String is %@", jsonString);

    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSError *error;
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
         NSLog(@"JSON %@",JSON);
         success(JSON);     } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         failure(operation, error);
     }];
    
}

-(void)api_MyBudgetDailyExpense: (NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
                              failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure
{
    
    NSString * url = [NSString stringWithFormat:API_MyBudgetDailyExpense,BASE_URL];
    NSLog(@"%@",url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSError *error;
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
         NSLog(@"JSON %@",JSON);
         success(JSON);     } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         failure(operation, error);
     }];
    
}

-(void)api_MyBudgetDailyExpenseCreate: (NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
                              failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure
{
    
    NSString * url = [NSString stringWithFormat:API_MyBudgetDailyExpenseCreate,BASE_URL];
    NSLog(@"%@",url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSError *error;
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
         NSLog(@"JSON %@",JSON);
         success(JSON);     } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         failure(operation, error);
     }];
    
}

-(void)api_MyBudget: (NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
                              failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure
{
    
    NSString * url = [NSString stringWithFormat:API_MyBudget,BASE_URL];
    NSLog(@"%@",url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSError *error;
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
         NSLog(@"JSON %@",JSON);
         success(JSON);     } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         failure(operation, error);
     }];
    
}

-(void)api_ChangePassword: (NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
            failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure
{
    NSString * url = [NSString stringWithFormat:API_ChangePassword,BASE_URL];
    NSLog(@"%@",url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSError *error;
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
         NSLog(@"JSON %@",JSON);
         success(JSON);     } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         failure(operation, error);
     }];
    
}

-(void)api_ForgetPassword: (NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
                  failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure
{
    NSString * url = [NSString stringWithFormat:API_ForgetPassword,BASE_URL];
    NSLog(@"%@",url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSError *error;
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
         NSLog(@"JSON %@",JSON);
         success(JSON);     } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         failure(operation, error);
     }];
    
}

-(void)api_ProfileUpdate: (NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
                  failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure
{
    NSString * url = [NSString stringWithFormat:API_ProfileUpdate,BASE_URL];
    NSLog(@"%@",url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSError *error;
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
         NSLog(@"JSON %@",JSON);
         success(JSON);     } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         failure(operation, error);
     }];
    
}

-(void)api_GetCarAccidentReport:(void (^)(id result))success
                    failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure
{
    
    NSDictionary *userInfo = (NSDictionary*)[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:[userInfo valueForKey:@"CustomerID"] forKey:@"CustomerID"];
    NSString * url = [NSString stringWithFormat:API_GetCarAccidentReport ,BASE_URL];
    NSLog(@"%@",url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSError *error;
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
         
         //NSLog(@"JSON %@",JSON);
         success(JSON);     } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         failure(operation, error);
     }];
    
}

-(void)api_GetHomeAccidentReport:(void (^)(id result))success
                    failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure
{
    
    NSDictionary *userInfo = (NSDictionary*)[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:[userInfo valueForKey:@"CustomerID"] forKey:@"CustomerID"];
    NSString * url = [NSString stringWithFormat:API_GetHomeAccidentReport,BASE_URL];
    NSLog(@"%@",url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSError *error;
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
         
         //NSLog(@"JSON %@",JSON);
         success(JSON);     } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         failure(operation, error);
     }];
    
}

-(void)api_GetHealthAccidentReport:(void (^)(id result))success
                    failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure
{
    
    NSDictionary *userInfo = (NSDictionary*)[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:[userInfo valueForKey:@"CustomerID"] forKey:@"CustomerID"];
    NSString * url = [NSString stringWithFormat:API_GetHealthAccidentReport,BASE_URL];
    NSLog(@"%@",url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSError *error;
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
         
         //NSLog(@"JSON %@",JSON);
         success(JSON);     } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         failure(operation, error);
     }];
    
}

-(void)api_CreateCarAccident: (NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
                 failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure
{
    NSString * url = [NSString stringWithFormat:API_CreateCarAccident,BASE_URL];
    NSLog(@"%@",url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSError *error;
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
         NSLog(@"JSON %@",JSON);
         success(JSON);     } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         failure(operation, error);
     }];
    
}

-(void)api_CreateHomeAccident: (NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
                 failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure
{
    NSString * url = [NSString stringWithFormat:API_CreateHomeAccident,BASE_URL];
    NSLog(@"%@",url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSError *error;
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
         NSLog(@"JSON %@",JSON);
         success(JSON);     } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         failure(operation, error);
     }];
    
}

-(void)api_CreateHealthAccident: (NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
                 failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure
{
    NSString * url = [NSString stringWithFormat:API_CreateHealthAccident,BASE_URL];
    NSLog(@"%@",url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSError *error;
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
         NSLog(@"JSON %@",JSON);
         success(JSON);     } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         failure(operation, error);
     }];
    
}


-(void)api_GetNotification:(void (^)(id result))success
                           failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure
{
    
    NSDictionary *userInfo = (NSDictionary*)[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:[userInfo valueForKey:@"CustomerID"] forKey:@"cusomerID"];
    NSString * url = [NSString stringWithFormat:API_GetNotification,BASE_URL];
    NSLog(@"%@",url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSError *error;
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
                  success(JSON);
     } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         failure(operation, error);
     }];
    
}

-(void)api_GetPolicyType:(void (^)(id result))success
                   failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure
{
    
    NSString * url = [NSString stringWithFormat:API_GetPolicyType,BASE_URL];
    NSLog(@"%@",url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager POST:url parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSError *error;
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
         success(JSON);
     } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         failure(operation, error);
     }];
    
}


-(void)api_GetOfferFieldByPolicyType: (NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
                        failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure
{
    NSString * url = [NSString stringWithFormat:API_GetOfferFieldByPolicyType,BASE_URL];
    NSLog(@"%@",url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSError *error;
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
         NSLog(@"JSON %@",JSON);
         success(JSON);     } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         failure(operation, error);
     }];
    
}


-(void)api_NewOfferRequest: (NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
                        failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure
{
    NSString * url = [NSString stringWithFormat:API_NewOfferRequest,BASE_URL];
    NSLog(@"%@",url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSError *error;
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
         NSLog(@"JSON %@",JSON);
         success(JSON);     } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         failure(operation, error);
     }];
    
}

-(void)api_ConsultantComments: (NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
                        failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure
{
    NSString * url = [NSString stringWithFormat:API_ConsultantComments,BASE_URL];
    NSLog(@"%@",url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSError *error;
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
         NSLog(@"JSON %@",JSON);
         success(JSON);     } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         failure(operation, error);
     }];
    
}

-(void)api_MyBudgetDeleteEntity: (NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
                      failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure
{
    NSString * url = [NSString stringWithFormat:API_MyBudgetDeleteEntity,BASE_URL];
    NSLog(@"%@",url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         NSError *error;
         NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
         NSLog(@"JSON %@",JSON);
         success(JSON);     } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         failure(operation, error);
     }];
    
}
@end

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
@end

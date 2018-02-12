//
//  APIHandler.h
//  OpenCart
//
//  Created by Parthiban on 03/08/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIHandler : NSObject

-(void)userLogin: (NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
         failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

-(void)userRegister: (NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
            failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

-(void)api_financeFolder:(void (^)(id result))success
                 failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;
-(void)api_taxFolder:(void (^)(id result))success
             failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;
-(void)api_taxAppoinment:(void (^)(id result))success
                 failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;
-(void)api_Message_Notifcation:(void (^)(id result))success
                       failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;
-(void)api_ConsulterDetails:(void (^)(id result))success
                    failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;
-(void)api_Recommendation: (NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
                  failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

-(void)api_ContractAppoinmentList :(void (^)(id result))success
                           failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

-(void)api_BookContractAppoinmentList: (NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
                              failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

-(void)api_VideosList :(void (^)(id result))success
               failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

-(void)api_ContactList :(void (^)(id result))success
                failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;
-(void)api_Discount :(void (^)(id result))success
             failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;
-(void)api_Documents :(void (^)(id result))success
              failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;
-(void)api_ProductSolution :(void (^)(id result))success
                    failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;
-(void)api_MyBudgetSetting :(void (^)(id result))success
                    failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;
-(void)api_MyBudgetSettingUpdate: (NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
                         failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;
-(void)api_MyBudgetDailyExpense: (NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
                        failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;
-(void)api_MyBudgetDailyExpenseCreate: (NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
                              failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;
-(void)api_MyBudget: (NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
            failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;
-(void)api_ChangePassword: (NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
                  failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;
-(void)api_ForgetPassword: (NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
                  failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;
-(void)api_ProfileUpdate: (NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
                 failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;
-(void)api_GetCarAccidentReport:(void (^)(id result))success
                          failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;
-(void)api_GetHomeAccidentReport:(void (^)(id result))success
                          failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;
-(void)api_GetHealthAccidentReport:(void (^)(id result))success
                            failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

-(void)api_CreateCarAccident: (NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
                     failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

-(void)api_CreateHomeAccident: (NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
                      failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;
-(void)api_CreateHealthAccident: (NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
                        failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;
-(void)api_GetNotification:(void (^)(id result))success
                   failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

-(void)api_GetPolicyType:(void (^)(id result))success
                 failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;


-(void)api_GetOfferFieldByPolicyType: (NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
                             failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

-(void)api_NewOfferRequest: (NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
                   failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

-(void)api_ConsultantComments: (NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
                      failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;

-(void)api_MyBudgetDeleteEntity: (NSMutableDictionary *)dic  withSuccess: (void (^)(id result))success
                        failure:(void (^)(NSURLSessionTask *operation, NSError *error))failure;
@end

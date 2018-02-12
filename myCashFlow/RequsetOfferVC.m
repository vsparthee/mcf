//
//  RequsetOfferVC.m
//  myCashflow
//
//  Created by Rishi on 10/15/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import "RequsetOfferVC.h"
#import "ReqOfferCell.h"
@interface RequsetOfferVC ()<UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
{
    float height;
    NSString *rowid;
    NSMutableArray *masterArr,*resultpickerArr;
    BOOL isCarInsurance;
    int cameraTag;
    NSString *imgdocfrontPath,*imgdocbackPath,*imglicFrontPath,*imglicBackPath,*imgcarPolicyPath,*imgPolicyPath,*selectedID;
    NSData *frontdoc,*backdoc,*frontLic,*backLic,*docPolicy,*docCarpolicy;

}
@end

@implementation RequsetOfferVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lblTitle.text=[TSLanguageManager localizedString:@"Offers"];
    self.typelbl.text=[TSLanguageManager localizedString:@"Select Policy Type"];

    [General startLoader:self.view];
    masterArr=[[NSMutableArray alloc]init];
    if ([UIScreen mainScreen].bounds.size.width>[UIScreen mainScreen].bounds.size.height)
    {
        height=[UIScreen mainScreen].bounds.size.width;
    }
    else
    {
        height=[UIScreen mainScreen].bounds.size.height;
    }
    self.tblOffer.estimatedRowHeight = 2500;
    self.tblOffer.rowHeight = 200;
    self.tblOffer.rowHeight = UITableViewAutomaticDimension;
    self.tblOffer.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.tblOffer setScrollEnabled:NO];
     
    
    
    

    APIHandler *api=[[APIHandler alloc]init];
    [api api_GetPolicyType:^(id result)
    {
        @try
        {
            self.pickerArr=[[NSMutableArray alloc]init];
            self.pickerArr=[result valueForKey:@"data"];
            NSDictionary *temp=[_pickerArr objectAtIndex:0];
            rowid=[NSString stringWithFormat:@"%@",[temp valueForKey:@"Id"]];
            self.picker = [[UIPickerView alloc]init];
            self.picker.delegate = self;
            self.picker.dataSource = self;
            self.picker.hidden = NO;
            self.picker.showsSelectionIndicator = YES;
            self.picker.tag = 100;
            self.txtPolicytype.inputView = self.picker;
            self.txtPolicytype.inputView.backgroundColor =[UIColor whiteColor];
            self.txtPolicytype.delegate = self;
            self.txtPolicytype.delegate = self;
        }
        @catch (NSException *exception)
        {
            [General makeToast:[TSLanguageManager localizedString:@"Something went wrong. Please try again later"] withToastView:self.view];
            
        }
        [General stopLoader];

        


    }
    failure:^(NSURLSessionTask *operation, NSError *error)
    {
        [General stopLoader];
    }];
        self.viewHeight.constant=height-64;
}

- (IBAction)action_Menu:(UIButton *)sender
{
    [self.sideMenuController showLeftViewAnimated:YES completionHandler:nil];
}

- (IBAction)action_Back:(UIButton *)sender
{
    if( [self navigationController])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self.parent home];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getOfferApi:(NSString*)val
{
    [General startLoader:self.view];

    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:[NSString stringWithFormat:@"%@",val] forKey:@"PolicyTypeID"];
    
    APIHandler *api=[[APIHandler alloc]init];
    [api api_GetOfferFieldByPolicyType:dic withSuccess:^(id result)
    {
        @try
        {
            resultpickerArr=[[NSMutableArray alloc]init];

            resultpickerArr=[[result valueForKey:@"data"] mutableCopy];
            masterArr= [[NSMutableArray alloc]init];
            for (NSDictionary *tempdic in resultpickerArr)
            {
                [masterArr addObject:[tempdic valueForKey:@"FieldOptions"]];
            }
            if (resultpickerArr.count > 0)
            {
                if (isCarInsurance)
                    self.viewHeight.constant = resultpickerArr.count*100+400;
                else
                    self.viewHeight.constant = resultpickerArr.count*100+250;

            }
            else
            {
                if (isCarInsurance)
                    self.viewHeight.constant = 400;
                else
                    self.viewHeight.constant = 250;
            }

            [self.tblOffer reloadData];

        }
        @catch (NSException *exception)
        {
            [General makeToast:[TSLanguageManager localizedString:@"Something went wrong. Please try again later"] withToastView:self.view];
            
        }
        [General stopLoader];
    }
    failure:^(NSURLSessionTask *operation, NSError *error)
    {
        [General stopLoader];
    }];

}

- (IBAction)action_Submit:(UIButton *)sender
{
    NSMutableArray *tempArr=[[NSMutableArray alloc]init];
    BOOL isError=NO;
    for (int i=0; i<resultpickerArr.count; i++)
    {
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        ReqOfferCell *cell = (ReqOfferCell *)[self.tblOffer cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [dic setObject:[NSString stringWithFormat:@"%@",cell.lblTitle.text] forKey:@"Name"];
        NSUInteger newLength = [cell.txtInput.text length];
        if (newLength>0)
        {
            [dic setObject:[NSString stringWithFormat:@"%@",cell.txtInput.text] forKey:@"Value"];
            [tempArr addObject:dic];
        }
        else
        {
            [General makeToast:@"Fill all values before submit" withToastView:self.view];
            isError=YES;
            break;
        }

    }
    NSLog(@"tempArr:%@",tempArr);
    if (isError==NO)
    {
        [General startLoader:self.view];

        NSDictionary *userInfo = (NSDictionary*)[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
        NSMutableDictionary *apidic=[[NSMutableDictionary alloc]init];
        
        [apidic setValue:[NSNumber numberWithInt:[[userInfo valueForKey:@"CustomerID"] intValue]] forKey:@"customerID"];
        [apidic setObject:[NSNumber numberWithInt:[rowid intValue]] forKey:@"PolicyType"];
        [apidic setObject:tempArr forKey:@"FieldList"];

        NSLog(@"Json:%@",[General json:apidic]);
      
       
        
        NSString * url = [NSString stringWithFormat:API_NewOfferRequest,BASE_URL];

        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
        {
            if (isCarInsurance)
            {
                if(frontdoc!=nil)
                {
                    [formData appendPartWithFileData:frontdoc
                                                name:@"CardocImgFront"
                                            fileName:@"CardocImgFront.jpeg" mimeType:@"image/jpeg"];
                }
                if(backdoc!=nil)
                {
                    [formData appendPartWithFileData:backdoc
                                                name:@"CardocImgBack"
                                            fileName:@"CardocImgBack.jpeg" mimeType:@"image/jpeg"];
                }
                if(frontLic!=nil)
                {
                    [formData appendPartWithFileData:frontLic
                                                name:@"DrivingLicImgFront"
                                            fileName:@"DrivingLicImgFront.jpeg" mimeType:@"image/jpeg"];
                }
                if(backLic!=nil)
                {
                    [formData appendPartWithFileData:backLic
                                                name:@"DrivingLicImgBack"
                                            fileName:@"DrivingLicImgBack.jpeg" mimeType:@"image/jpeg"];
                }
                if(docCarpolicy!=nil)
                {
                    [formData appendPartWithFileData:docCarpolicy
                                                name:@"PolicyImg"
                                            fileName:@"PolicyImg.jpeg" mimeType:@"image/jpeg"];
                }
            }
            else
            {
                if(docPolicy!=nil)
                {
                    [formData appendPartWithFileData:docPolicy
                                                name:@"PolicyImg"
                                            fileName:@"PolicyImg.jpeg" mimeType:@"image/jpeg"];
                }
            }
            
          //  [formData appendPartWithFormData:[NSKeyedArchiver archivedDataWithRootObject:tempArr] name:@"FieldList"];
            [formData appendPartWithFormData:[[NSString stringWithFormat:@"%@",[userInfo valueForKey:@"CustomerID"]] dataUsingEncoding:NSUTF8StringEncoding] name:@"customerID"];
            [formData appendPartWithFormData:[[NSString stringWithFormat:@"%@",rowid] dataUsingEncoding:NSUTF8StringEncoding] name:@"PolicyType"];
            NSError *error = nil;

            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:tempArr options:NSJSONWritingPrettyPrinted error:&error];
            NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            [formData appendPartWithFormData:[[NSString stringWithFormat:@"%@",jsonString] dataUsingEncoding:NSUTF8StringEncoding] name:@"FieldList"];

          /*  NSDictionary *userInfo = (NSDictionary*)[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
            

            [formData appendPartWithFormData:[[NSString stringWithFormat:@"%@",[userInfo valueForKey:@"CustomerID"]] dataUsingEncoding:NSUTF8StringEncoding] name:@"customerID"];
            [formData appendPartWithFormData:[[NSString stringWithFormat:@"%@",rowid] dataUsingEncoding:NSUTF8StringEncoding] name:@"PolicyType"];
            [formData appendPartWithFormData:[NSKeyedArchiver archivedDataWithRootObject:tempArr] name:@"FieldList"];
            for (NSDictionary *temp in tempArr)
            {
               // [formData appendPartWithFormData:[[NSString stringWithFormat:@"%@",[temp valueForKey:@"Name"]] dataUsingEncoding:NSUTF8StringEncoding] name:@"Name"];
              //  [formData appendPartWithFormData:[[NSString stringWithFormat:@"%@",[temp valueForKey:@"Value"]] dataUsingEncoding:NSUTF8StringEncoding] name:@"Value"];
                
                NSError *error = nil;
                
                NSData *paramData = [NSJSONSerialization dataWithJSONObject:temp
                                                                    options:0
                                                                      error:&error];
             //   [formData appendPartWithFileData:paramData name:@"FieldList" fileName:@"FieldList" mimeType:@"application/json"];
                [formData appendPartWithFormData:paramData name:@"FieldList"];

            }
*/
            
        } progress:nil success:^(NSURLSessionDataTask *task, id responseObject)
         {
             @try
             {
                 if ([[responseObject valueForKey:@"status"] boolValue]==true)
                 {

                     [General makeToast:@"Offer request updated successfully" withToastView:self.view];
                     self.docFront.image=[UIImage imageNamed:@"bg.jpg"];
                     self.docBack.image=[UIImage imageNamed:@"bg.jpg"];
                     self.licFront.image=[UIImage imageNamed:@"bg.jpg"];
                     self.licBack.image=[UIImage imageNamed:@"bg.jpg"];
                     self.policyDoc.image=[UIImage imageNamed:@"bg.jpg"];
                     self.carPolicyDoc.image=[UIImage imageNamed:@"bg.jpg"];
                     imgdocfrontPath=nil;
                     imgdocbackPath=nil;
                     imglicFrontPath=nil;
                     imglicBackPath=nil;
                     imgPolicyPath=nil;
                     imgcarPolicyPath=nil;
                     frontdoc=nil;
                     backdoc=nil;
                     frontLic=nil;
                     backLic=nil;
                     docPolicy=nil;
                     docCarpolicy=nil;

                 }
                 else
                 {
                     [General makeToast:@"Something went wrong. Please try again later" withToastView:self.view];
                 }
                 [General stopLoader];
             }
             @catch (NSException *exception)
             {
                 [General makeToast:[TSLanguageManager localizedString:@"Something went wrong. Please try again later"] withToastView:self.view];
             }
             
             
             
         } failure:^(NSURLSessionDataTask *task, NSError *error)
         {
             [General makeToast:@"Something went wrong. Please try again later" withToastView:self.view];
             [General stopLoader];
             
         }];

        
    }
    /* APIHandler *api=[[APIHandler alloc]init];
     [api api_NewOfferRequest:apidic withSuccess:^(id result)
     {
     @try
     {
     if ([[result valueForKey:@"status"] boolValue]==true)
     {
     [General makeToast:@"Offer request updated successfully" withToastView:self.view];
     }
     else
     {
     [General makeToast:@"Something went wrong. Please try again later" withToastView:self.view];
     }
     
     }
     @catch (NSException *exception)
     {
     [General makeToast:[TSLanguageManager localizedString:@"Something went wrong. Please try again later"] withToastView:self.view];
     
     }
     [General stopLoader];
     
     } failure:^(NSURLSessionTask *operation, NSError *error)
     {
     [General makeToast:@"Something went wrong. Please try again later" withToastView:self.view];
     [General stopLoader];
     
     }];
     
     */
    
}

- (IBAction)action_Cancel:(UIButton *)sender {
}


#pragma mark PICKERVIEW

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (pickerView.tag==100)
    {
        return 1;

    }
   /* else if (pickerView.tag==1)
    {
        return 1;

    }*/
    else
    {
        return 1;

    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView.tag==100)
    {
        if([_pickerArr count] == 0)
        {
            return 1;
        }
        else
        {
            return _pickerArr.count;
        }

    }
    /*else if (pickerView.tag==1)
    {
        NSLog(@"%d",pickerView.tag);
        NSMutableArray *temp=[masterArr objectAtIndex:1];
        if([temp count] == 0)
        {
            return 1;
        }
        else
        {
            return temp.count;
        }
    }*/
    else
    {
        NSMutableArray *temp=[masterArr objectAtIndex:pickerView.tag];
        if([temp count] == 0)
        {
            return 1;
        }
        else
        {
            return temp.count;
        }
    }
    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView.tag==100)
    {
        NSDictionary *temp=[_pickerArr objectAtIndex:row];
        rowid=[NSString stringWithFormat:@"%@",[temp valueForKey:@"Id"]];
        self.txtPolicytype.text = [NSString stringWithFormat:@"%@",[temp valueForKey:@"Name"]];
        if ([[temp valueForKey:@"Id"]intValue]==1)
        {
            [self.policyView removeFromSuperview];
            [self.uploadImageBaseView addSubview:self.carInsuranceView];
            self.imgbaseHeight.constant = 400;
            self.carInsuranceView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 400);
            isCarInsurance = YES;
        }
        else
        {
            [self.carInsuranceView removeFromSuperview];
            [self.uploadImageBaseView addSubview:self.policyView];
            self.imgbaseHeight.constant = 250;
            self.policyView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 250);
            isCarInsurance = NO;
        }
        [General stopLoader];
        self.docFront.image=[UIImage imageNamed:@"bg.jpg"];
        self.docBack.image=[UIImage imageNamed:@"bg.jpg"];
        self.licFront.image=[UIImage imageNamed:@"bg.jpg"];
        self.licBack.image=[UIImage imageNamed:@"bg.jpg"];
        self.policyDoc.image=[UIImage imageNamed:@"bg.jpg"];
        self.carPolicyDoc.image=[UIImage imageNamed:@"bg.jpg"];
        imgdocfrontPath=nil;
        imgdocbackPath=nil;
        imglicFrontPath=nil;
        imglicBackPath=nil;
        imgPolicyPath=nil;
        imgcarPolicyPath=nil;
        frontdoc=nil;
        backdoc=nil;
        frontLic=nil;
        backLic=nil;
        docPolicy=nil;
        docCarpolicy=nil;
        [self getOfferApi:rowid];

    }
   /* else if (pickerView.tag==1)
    {
        NSMutableArray *temp=[masterArr objectAtIndex:1];
        NSLog(@"Temp:%@",temp);

    }*/
    else
    {
        NSMutableArray *temp=[masterArr objectAtIndex:pickerView.tag];
        
        NSLog(@"Temp:%@",[temp objectAtIndex:row]);
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:pickerView.tag inSection:0];
        
        ReqOfferCell *cell = (ReqOfferCell *)[self.tblOffer cellForRowAtIndexPath:indexPath];
        cell.txtInput.text=[temp objectAtIndex:row];
        //[self.tblOffer reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];

    }
    
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    
    if (pickerView.tag==100)
    {
        NSDictionary *temp=[_pickerArr objectAtIndex:row];
        
        NSString *title;
        if(_pickerArr.count == 0)
        {
            title =   @"No data available";
        }
        else
        {
            title = [NSString stringWithFormat:@"%@",[temp valueForKey:@"Name"]];
            if (self.txtPolicytype.text.length==0)
            {
                self.txtPolicytype.text = [NSString stringWithFormat:@"%@",[[_pickerArr objectAtIndex:0] valueForKey:@"Name"]];
            }
            //self.txtPolicytype.text =title;
        }
        
        
        UILabel* tView = (UILabel*)view;
        if (!tView)
        {
            tView = [[UILabel alloc] init];
            [tView setFont:[UIFont fontWithName:THEME_FONT size:18]];
            [tView setTextAlignment:NSTextAlignmentCenter];
            [tView setTextColor:[UIColor darkGrayColor]];
            tView.numberOfLines=3;
        }
        tView.text=title;
        return tView;
    }
   /* else if (pickerView.tag==1)
    {
        NSArray *temparr=[masterArr objectAtIndex:1];
        
        
        NSString *title;
        if(temparr.count == 0)
        {
            title =   @"No data available";
        }
        else
        {
            title = [NSString stringWithFormat:@"%@",[temparr objectAtIndex:row]];
            self.txtPolicytype.text =title;
        }
        
        
        UILabel* tView = (UILabel*)view;
        if (!tView)
        {
            tView = [[UILabel alloc] init];
            [tView setFont:[UIFont fontWithName:THEME_FONT size:18]];
            [tView setTextAlignment:NSTextAlignmentCenter];
            [tView setTextColor:[UIColor darkGrayColor]];
            tView.numberOfLines=3;
        }
        tView.text=title;
        return tView;
    }*/

    
    else
    {
        NSArray *temparr=[masterArr objectAtIndex:pickerView.tag];
        
        
        NSString *title;
        if(temparr.count == 0)
        {
            title =   @"No data available";
        }
        else
        {
            title = [NSString stringWithFormat:@"%@",[temparr objectAtIndex:row]];

            ReqOfferCell *cell = (ReqOfferCell *)[self.tblOffer cellForRowAtIndexPath:[NSIndexPath indexPathForRow:pickerView.tag inSection:0]];
            if (cell.txtInput.text.length==0)
            {
                cell.txtInput.text = [NSString stringWithFormat:@"%@",[temparr objectAtIndex:0]];
            }
        }
        
        
        UILabel* tView = (UILabel*)view;
        if (!tView)
        {
            tView = [[UILabel alloc] init];
            [tView setFont:[UIFont fontWithName:THEME_FONT size:18]];
            [tView setTextAlignment:NSTextAlignmentCenter];
            [tView setTextColor:[UIColor darkGrayColor]];
            tView.numberOfLines=3;
        }
        tView.text=title;
        return tView;
    }
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([textField isEqual:self.txtPolicytype])
    {
        return NO;
    }
    else
    {
        if ([[[resultpickerArr objectAtIndex:textField.tag]valueForKey:@"FieldType"] isEqualToString:@"Option"])
            return NO;
        else
            return YES;
    }
    return YES;
}



#pragma mark - TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return resultpickerArr.count;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ReqOfferCell" owner:self options:nil];
    ReqOfferCell *cell = [nib objectAtIndex:0];
    NSDictionary *dic=[resultpickerArr objectAtIndex:indexPath.row];
    cell.lblTitle.text=[NSString stringWithFormat:@"%@",[dic valueForKey:@"FieldName"]];
    UIPickerView *resultpicker = [[UIPickerView alloc]init];
    cell.txtInput.tag = indexPath.row;
    cell.txtInput.delegate = self;
    cell.txtInput.text = [dic valueForKey:@"FieldValue"];
    
    if ([[dic valueForKey:@"FieldType"]isEqualToString:@"Option"])
    {
      //  [masterArr addObject:[dic valueForKey:@"FieldOptions"]];
        cell.arrow.hidden=NO;
        resultpicker.delegate = self;
        resultpicker.dataSource = self;
        resultpicker.hidden = NO;
        resultpicker.showsSelectionIndicator = YES;
        cell.txtInput.inputView = resultpicker;
        cell.txtInput.inputView.backgroundColor =[UIColor whiteColor];
        
    }
    else
    {
       // [masterArr addObject:[dic valueForKey:@"FieldOptions"]];
        cell.arrow.hidden=YES;
    }
    resultpicker.tag = indexPath.row;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  100;
}

/*- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (isCarInsurance)
        return 248;
    else
        return 128;
    
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (isCarInsurance)
        return self.carInsuranceView;
    else
        return self.policyView;

}
*/
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"%ld",(long)textField.tag);
    if (textField != self.txtPolicytype)
    {
        NSMutableDictionary *dic=[[resultpickerArr objectAtIndex:textField.tag] mutableCopy];
        [dic removeObjectForKey:@"FieldValue"];
        [dic setValue:textField.text forKey:@"FieldValue"];
        [resultpickerArr replaceObjectAtIndex:textField.tag withObject:dic];
    }
    
}

- (IBAction)action_doc_Front:(UIButton *)sender
{
    cameraTag=1;
    [self changePhoto];
}

- (IBAction)action_doc_Back:(UIButton *)sender
{
    cameraTag=2;
    [self changePhoto];
}

- (IBAction)action_Licence_Front:(UIButton *)sender
{
    cameraTag=3;
    [self changePhoto];
}

- (IBAction)action_Licence_Back:(UIButton *)sender
{
    cameraTag=4;
    [self changePhoto];
}

- (IBAction)action_Car_Policy_Doc:(UIButton *)sender
{
    cameraTag=5;
    [self changePhoto];
}

- (IBAction)action_Policy_Doc:(UIButton *)sender
{
    cameraTag=6;
    [self changePhoto];
}



- (void)changePhoto{
    
    NSLog(@"Inside Image Change...");
    UIActionSheet  *webSheet = [[UIActionSheet alloc] initWithTitle:@"" delegate:self cancelButtonTitle:NSLocalizedString([TSLanguageManager localizedString:@"Cancel"], nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString([TSLanguageManager localizedString:@"Albums"], nil),NSLocalizedString([TSLanguageManager localizedString:@"Take a Photo"], nil), nil];
    
    [webSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        UIImagePickerController* picker = [[UIImagePickerController alloc] init];
        picker.delegate   = self;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:nil];
        
        
    } else if (buttonIndex == 1) {
        BOOL hasCamera = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
        
        UIImagePickerController* picker = [[UIImagePickerController alloc] init];
        picker.delegate   = self;
        picker.sourceType = hasCamera ? UIImagePickerControllerSourceTypeCamera : UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:nil];
        
        
    }
}



- (void)imagePickerControllerDidCancel:(UIImagePickerController*)picker
{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}


-(UIImage *)normalizedImage:(UIImage *) thisImage
{
    if (thisImage.imageOrientation == UIImageOrientationUp) return thisImage;
    
    UIGraphicsBeginImageContextWithOptions(thisImage.size, NO, thisImage.scale);
    [thisImage drawInRect:(CGRect){0, 0, thisImage.size}];
    UIImage *normalizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return normalizedImage;
}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    UIImage *imagee =  [self normalizedImage:chosenImage];
    
    if (cameraTag==1)
    {
        
        self.docFront.image = imagee;
        imgdocfrontPath = [NSString stringWithFormat:@"%@",[info valueForKey:UIImagePickerControllerReferenceURL]];
        frontdoc= [self compressImage:imagee];
        
        
        
    }
    else if (cameraTag==2)
    {
        self.docBack.image = imagee;
        imgdocbackPath = [NSString stringWithFormat:@"%@",[info valueForKey:UIImagePickerControllerReferenceURL]];
        backdoc= [self compressImage:imagee];
        
        
        
    }
    else if (cameraTag==3)
    {
        self.licFront.image = imagee;
         imglicFrontPath= [NSString stringWithFormat:@"%@",[info valueForKey:UIImagePickerControllerReferenceURL]];
        frontLic= [self compressImage:imagee];
        
        
        
    }
    else if (cameraTag==4)
    {
        self.licBack.image = imagee;
        imglicBackPath = [NSString stringWithFormat:@"%@",[info valueForKey:UIImagePickerControllerReferenceURL]];
        backLic= [self compressImage:imagee];
        
        
        
        
    }
    else if (cameraTag==5)
    {
        self.carPolicyDoc.image = imagee;
        imgcarPolicyPath = [NSString stringWithFormat:@"%@",[info valueForKey:UIImagePickerControllerReferenceURL]];
        docCarpolicy= [self compressImage:imagee];
        
        
        
        
    }
    else
    {
        self.policyDoc.image = imagee;
        imgPolicyPath = [NSString stringWithFormat:@"%@",[info valueForKey:UIImagePickerControllerReferenceURL]];
        docPolicy= [self compressImage:imagee];
        
        
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

-(NSData*)compressImage:(UIImage *)yourImage
{
    yourImage = [UIImage imageWithCGImage:yourImage.CGImage scale:0.3 orientation:yourImage.imageOrientation];
    
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.1f;
    int maxFileSize = 200*1024;
    
    NSData *imageData = UIImageJPEGRepresentation(yourImage, compression);
    
    while ([imageData length] > maxFileSize && compression > maxCompression)
    {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(yourImage, compression);
    }
    return imageData;
}


- (UIImage *)imageWithImage:(UIImage *)image scaledToFillSize:(CGSize)size
{
    CGFloat scale = MAX(size.width/image.size.width, size.height/image.size.height);
    CGFloat imgwidth = image.size.width * scale;
    CGFloat imgheight = image.size.height * scale;
    CGRect imageRect = CGRectMake((size.width - imgwidth)/2.0f,
                                  (size.height - imgheight)/2.0f,
                                  imgwidth,
                                  imgheight);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [image drawInRect:imageRect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


@end

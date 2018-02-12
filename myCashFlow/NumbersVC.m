//
//  NumbersVC.m
//  myCashflow
//
//  Created by Rishi on 9/26/17.
//  Copyright © 2017 Parthiban. All rights reserved.
//

#import "NumbersVC.h"
#import "NumbersCell.h"
#import "NumberListVC.h"
@interface NumbersVC ()
{
    NSMutableArray *numberArr,*selectedArr, *finalarr;
    NSDictionary *selectedDic;
    UILabel *nodata;
    NSArray *groups;

}
@end

@implementation NumbersVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupAPI];
    self.lbltitle.text=[TSLanguageManager localizedString:@"Numbers"];
    self.lbltitle.textAlignment=NSTextAlignmentCenter;
}

-(void)setupAPI
{
    
    nodata  = [[UILabel alloc]initWithFrame:CGRectMake(16, self.view.frame.size.height/2 - 65, self.view.frame.size.width-32, 30)];
    nodata.text = [TSLanguageManager localizedString:@"No data found in List"];
    nodata.textAlignment = NSTextAlignmentCenter;
    nodata.font = [UIFont fontWithName:@"" size:16];
    nodata.textColor = THEME_COLOR;

    [General startLoader:self.view];
    
    
    
    
    

    APIHandler *api = [[APIHandler alloc]init];
    [api api_ContactList:^(id result)
     {
         @try
         {
             NSDictionary *temp =[result mutableCopy];
             finalarr=[[NSMutableArray alloc]init];
             numberArr = [temp valueForKey:@"data"];
             if (numberArr.count>0)
             {
                 [nodata removeFromSuperview];
             }
             else
             {
                 [self.tblnumber addSubview:nodata];
             }
             [self.tblnumber reloadData];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
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

#pragma mark - CollectionView DataSource and Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return numberArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NumbersCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"numbercell" forIndexPath:indexPath];
    NSDictionary *tempDic=[numberArr objectAtIndex:indexPath.row];
    cell.lblTitle.text=[NSString stringWithFormat:@"%@",[tempDic valueForKey:@"PolicyType"]];
    NSString *strURL = [NSString stringWithFormat:@"%@",[tempDic valueForKey:@"PolicyImage"]];
    NSURL *url = [NSURL URLWithString:strURL];
    [cell.img setShowActivityIndicatorView:YES];
    [cell.img setIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [cell.img sd_setImageWithURL:url
                    placeholderImage:nil
                             options:SDWebImageRefreshCached];
    NSString *color = [NSString stringWithFormat:@"%@",[self test]];
    cell.img.backgroundColor=[self colorFromHexString:color];
    return cell;
}

-(NSString*)test
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    
    return [NSString stringWithFormat:@"#%02lX%02lX%02lX",
            lroundf(r * 255),
            lroundf(g * 255),
            lroundf(b * 255)];
    // return color;
}

- (UIColor *)colorFromHexString:(NSString *)hexString
{
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    float width = self.view.bounds.size.width/3 - 3;
    return CGSizeMake(width, width);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1.0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(1, 1, 1, 1);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    selectedDic=[numberArr objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"number_to_numList" sender:self];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"number_to_numList"])
    {
        NumberListVC *obj = [segue destinationViewController];
        obj.selectedDic = selectedDic;
    }
}
@end

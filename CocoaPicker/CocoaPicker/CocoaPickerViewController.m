//
//  CocoaPickerViewController.m
//  CocoaPicker
//
//  Created by Cocoa Lee on 15/8/25.
//  Copyright (c) 2015年 Cocoa Lee. All rights reserved.
//

#import "CocoaPickerViewController.h"
#import "CocoaHederView.h"
@interface CocoaPickerViewController ()<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property(nonatomic,strong,readonly)NSArray *nameArray;

@end

@implementation CocoaPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView {
    
    UIView *topView = [UIView new];
    topView.backgroundColor = [UIColor orangeColor];
    topView.frame = CGRectMake(0, 0,CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 340);
    [self.view addSubview:topView];
    topView.backgroundColor = [UIColor clearColor];
    
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [topView addGestureRecognizer:tap];
    
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, topView.bounds.size.height, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-topView.bounds.size.height) style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    tableView.bounces = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    
    _nameArray = @[@"拍照",@"相册",@"取消"];
    
    
    
}


#pragma mark -delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] init];
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor colorWithRed:218/255.0 green:218/255.0 blue:218/255.0 alpha:1];
    line.frame = CGRectMake(0, 0, tableView.bounds.size.width, 1);
    [cell addSubview:line];
    
    
    cell.textLabel.text = _nameArray[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CocoaHederView *hederView = [[CocoaHederView alloc] init];
    __weak typeof (&*self)weakSelf = self;
    hederView.sendImageBlock = ^(UIImage *image){
        if ([weakSelf.delegate respondsToSelector:@selector(CocoaPickerViewSendBackWithImage:andString:)]) {
            [self.delegate CocoaPickerViewSendBackWithImage:image andString:@"选择的照片"];
            [self dismiss];
        }
    };
    return hederView;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 2) {
        [self dismiss];

    }
    else{
        [self tackPhotoOrChoseFromLib:indexPath.row];
    }
}


#pragma mark -dataSouce
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 190;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPat{
    return 50;
}


#pragma mark dismiss
- (void)dismiss{
    NSLog(@"dismiss");
  __weak __typeof(&*self)weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf dismissViewControllerAnimated:YES completion:^{
            
        }];
    });
   
}

- (void)tackPhotoOrChoseFromLib : (NSInteger )indexPathRow{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    if (indexPathRow == 0) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else if (indexPathRow == 1) {
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [self presentViewController:picker animated:YES completion:^{
        
    }];
}




#pragma mark -pickerViewDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
//    传到 首页
    UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    if ([self.delegate respondsToSelector:@selector(CocoaPickerViewSendBackWithImage:andString:)]) {
        [self.delegate CocoaPickerViewSendBackWithImage:image andString:@"选择的照片"];
    }
    __weak typeof (&*self) weakSelf = self;
    [picker dismissViewControllerAnimated:YES completion:^{
        [weakSelf dismiss];
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

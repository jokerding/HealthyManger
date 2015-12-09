//
//  FactoryLoctionViewController.m
//  HealthyManger
//
//  Created by qianfeng on 15/12/3.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "FactoryLoctionViewController.h"

#import "CustomAnnotation.h"  //大图针
#import "CustomAnnotationView.h" //自定义大图针图标

#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

#import "AFNetworking.h"

@interface FactoryLoctionViewController ()<MKMapViewDelegate,CLLocationManagerDelegate>

@property (nonatomic,strong)MKMapView *mapView;

@property (nonatomic,strong)CLLocationManager *manager;

@property (nonatomic,assign)CLLocationCoordinate2D location;

@property (nonatomic,copy)NSString *locationTitle;

@property (nonatomic,copy)NSString *locationSubTitle;

@end

@implementation FactoryLoctionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor whiteColor];
    [self createMapView];
}

-(void)createMapView
{
    _mapView =[[MKMapView alloc]initWithFrame:self.view.bounds];
    
    [self.view addSubview:_mapView];
    
    [_mapView setZoomEnabled:YES];
    [_mapView setRotateEnabled:YES];
    
    _mapView.mapType = MKMapTypeStandard;
    
    _mapView.delegate = self;
    
    
    [self locationMap];
    
   
}



// 开启定位功能
-(void)locationMap
{
    //判断是否开启了定位
    if ([CLLocationManager locationServicesEnabled])
    {
        if (!_manager)
        {
            _manager =[[CLLocationManager alloc]init];
            if ([_manager respondsToSelector:@selector(requestAlwaysAuthorization)])
            {
                [_manager requestAlwaysAuthorization];
                [_manager requestWhenInUseAuthorization];
            }
        }
        _manager.delegate = self;
        
        [_manager setDesiredAccuracy:kCLLocationAccuracyBest];
        [_manager setDistanceFilter:100];
        [_manager startUpdatingLocation];
        [_manager startUpdatingHeading];
     }
    else
    {
        UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:nil message:@"你没有开启定位功能" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
    //[_mapView showsUserLocation];
}
// 定位成功以后
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    _mapView.showsUserLocation = YES;
    
    CLLocation *cllocation = locations.firstObject;
    // 获取经纬度
    
    _location = CLLocationCoordinate2DMake(cllocation.coordinate.latitude, cllocation.coordinate.longitude);
    MKCoordinateRegion region = MKCoordinateRegionMake(_location, MKCoordinateSpanMake(1.0, 1.0));
    [_mapView setRegion:region];
    
    [self reverseGeocoder:cllocation];
    
    [self createAnnotation];
    
    [self getHttpLoad];
}

-(void)getHttpLoad
{
    NSLog(@"进入数据请求");
    
    NSString *locaX = [NSString stringWithFormat:@"%f",_location.latitude];
    NSString *locaY =[NSString stringWithFormat:@"%f",_location.longitude];
    
    NSString *url = [NSString stringWithFormat:TGAPI_FACTORY_LOCTION,locaX,locaY];
    self.httpUrl =[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue:TGAPI_KEY forHTTPHeaderField:TGHEADER_FIELD];
    manager.responseSerializer =[AFHTTPResponseSerializer serializer];
    
    [manager GET:self.httpUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",operation.responseString);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.localizedDescription);
    }];
    
    
    
}
// 创建大头针
-(void)createAnnotation
{
    CustomAnnotation *annotation = [[CustomAnnotation alloc]initAnnotation:_location];
    annotation.anontationTitle = _locationTitle;
    annotation.anontationSubTitle = _locationSubTitle;
    
    [_mapView addAnnotation:annotation];
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    static NSString *idenf = @"factory";
    
    CustomAnnotationView *annotationView = (CustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:idenf];
    if (!annotationView)
    {
        annotationView =[[CustomAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:idenf];
        
        annotationView.image =[UIImage imageNamed:@"tab6_2"];
        annotationView.enabled = YES;
        annotationView.canShowCallout = YES;
    }
    
    return annotationView;
}

#pragma mark Geocoder
// 反地址编码
-(void)reverseGeocoder:(CLLocation *)currentLocation
{
    CLGeocoder *geocoder =[[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error || placemarks.count == 0)
        {
            NSLog(@"error= %@",error);
        }
        else
        {
            CLPlacemark *placemark = placemarks.lastObject;
            NSLog(@"%@",[placemark addressDictionary]);
           
            NSLog(@"placemark:%@",[[placemark addressDictionary] objectForKey:@"City"]);
            UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"你的位置" message:[[placemark addressDictionary] objectForKey:@"Name"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
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

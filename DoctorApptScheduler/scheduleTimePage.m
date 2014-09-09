//
//  scheduleTimePage.m
//  DoctorApptScheduler
//
//  Created by administrator on 12/08/14.
//
//

#import "scheduleTimePage.h"
#import "SBJson.h"
#import "historyOfAppointments.h"

#define selectScheduleURL @"http://10.10.30.150/doctor_Mopapp/index.php?tag=reasonofvisit"

@interface scheduleTimePage ()
@property (strong, nonatomic) NSDate *selectedDate;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (nonatomic,weak) IBOutlet UISegmentedControl *statusControl;
@end

@implementation scheduleTimePage
@synthesize appIdDetails,patientNameDetails,patientReasonDetails,currentDateShed,datePickerShed,testDate,delegate;



-(void)viewWillDisappear:(BOOL)animated
{
    [delegate sendDataToA:artArrayAcceptRejectList];
    
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpTextField];
    NSLog(@"hai ");
    NSLog(@"dsfsdfsdsdf %@",appIdDetails);
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.statusControl.selectedSegmentIndex=-1;
    self.patientNameShed.text = patientNameDetails;
    self.patientReasonShed.text = patientReasonDetails;
    NSLog(@"%@",appIdDetails);
}


- (void)setUpTextField {
    
   
    datePickerShed = [[UIDatePicker alloc] init];
   
    datePickerShed.datePickerMode = UIDatePickerModeTime;
    
  
  self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"hh:mm a"];
    NSString *currentTime = [self.dateFormatter stringFromDate:datePickerShed.date];
    
    self.currentDateShed.textColor = [self.view tintColor];
    datePickerShed.hidden = NO;
    datePickerShed.alpha = 0.0f;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        datePickerShed.alpha = 1.0f;
        
    }];
   currentDateShed.text = currentTime;
    
  datePickerShed.date = [NSDate date];
    

}

- (IBAction)dateChanged:(UIDatePicker*)sender
{

    
    self.currentDateShed.text =  [self.dateFormatter stringFromDate:sender.date];
      self.selectedDate = sender.date;
    
 
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)statusChanged:(UISegmentedControl *)sender
{
    switch (self.statusControl.selectedSegmentIndex)
    {
        case 0:
            self.acceptRejectShed.text = @"approved";
                          [self pendingLists];

                        break;
        case 1:
            self.acceptRejectShed.text= @"rejected";
           [self rejectList];
            break;
        default:
            
            break;
    }
}

-(void)rejectList
{
    
    NSInteger success = 0;
    NSString *post =[[NSString alloc] initWithFormat:@"appid=%@&scheduletime=%@&status=%@&tag=%s",appIdDetails,[self.currentDateShed text],[self.acceptRejectShed text],"schedulepatient"];
    NSLog(@"PostData: %@",post);
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSURL *url = [NSURL URLWithString:[selectScheduleURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *response = nil;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSLog(@"Response code: %d", [response statusCode]);
    if ([response statusCode] >=200 && [response statusCode] <300)
    {
        NSString* resData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
        NSLog(@"Response ==> %@", resData);
        
        SBJsonParser *jsonParser = [SBJsonParser new];
        NSDictionary *jsonData = (NSDictionary *) [jsonParser objectWithString:resData error:nil];
        NSLog(@"%@",jsonData);
        
        //  artArrayDoctorList = [jsonData objectForKey:@"doctors"];
        success = [(NSNumber *) [jsonData objectForKey:@"success"] integerValue];
        NSLog(@"%d",success);
        if(success == 1)
        {
            //  artArrayAcceptRejectList = [jsonData objectForKey:@"pendinglist"];
            
            [self.navigationController popViewControllerAnimated:YES];
            
            
        }
        
        
    } else {
        
        NSLog(@"Login FAILED");
    }
    
    
}

    



-(void)pendingLists
{
    
    NSInteger success = 0;
    NSString *post =[[NSString alloc] initWithFormat:@"appid=%@&scheduletime=%@&status=%@&tag=%s",appIdDetails,[self.currentDateShed text],[self.acceptRejectShed text],"schedulepatient"];
    NSLog(@"PostData: %@",post);
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSURL *url = [NSURL URLWithString:[selectScheduleURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *response = nil;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSLog(@"Response code: %d", [response statusCode]);
    if ([response statusCode] >=200 && [response statusCode] <300)
    {
        NSString* resData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
        NSLog(@"Response ==> %@", resData);
        
        SBJsonParser *jsonParser = [SBJsonParser new];
        NSDictionary *jsonData = (NSDictionary *) [jsonParser objectWithString:resData error:nil];
        NSLog(@"%@",jsonData);
        
        //  artArrayDoctorList = [jsonData objectForKey:@"doctors"];
        success = [(NSNumber *) [jsonData objectForKey:@"success"] integerValue];
        NSLog(@"%d",success);
        if(success == 1)
        {
           artArrayAcceptRejectList = [jsonData objectForKey:@"schedulelist"];
            
        
         
             [self.navigationController popViewControllerAnimated:YES];
        }
        
        
    } else {
        
        NSLog(@"Login FAILED");
    }
    
    

    
    
}





@end

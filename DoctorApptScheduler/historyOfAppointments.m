//
//  historyOfAppointments.m
//  DoctorApptScheduler
//
//  Created by administrator on 12/08/14.
//
//




#import "historyOfAppointments.h"
#import "scheduleTimePage.h"
#import "SBJson.h"

#define selectDoctorpendingURL @"http://10.10.30.150/doctor_Mopapp/index.php?tag=patientpendinglist"


NSDictionary* airportAtIndexDoc;



@interface historyOfAppointments ()

@property (strong, nonatomic) NSDate *selectedDate;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;

@property (nonatomic,weak) IBOutlet UISegmentedControl *docSegmentedControl;
@end

@implementation historyOfAppointments
@synthesize dateChangeHistory,doctorName,docTableView,segmentChangeHistory;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)sendDataToA:(NSArray *)array
{
    NSLog(@"arrrrrrrrrraaaaayyyyyy  %@",array);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpTextField];
    
    self.doctorName.text = self.doctorsName;
    NSLog(@"doctor id %@",self.doctorsId);
    self.segmentChangeHistory.text = @"pending";
  
  [self approvedLists];
    
    [self.docTableView reloadData];
   

    
    [self dismissViewControllerAnimated:YES completion:^{
        //this code here will execute when modal is done being dismissed
        [self.docTableView reloadData];
    }];
    
    
    UIBarButtonItem *btnBack = [[UIBarButtonItem alloc]
                                initWithTitle:@"Logout"
                                style:UIBarButtonItemStyleBordered
                                target:self
                                action:@selector(OnClick_btnBack:)];
    self.navigationItem.leftBarButtonItem = btnBack;
 
    
}

-(IBAction)OnClick_btnBack:(id)sender  {
    [self.navigationController popViewControllerAnimated:YES];
    //[self.navigationController pushViewController:self.navigationController.parentViewController animated:YES];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.docSegmentedControl.selectedSegmentIndex=1;
    self.segmentChangeHistory.text = @"approved";
[self approvedLists];
       [self.docTableView reloadData];
 
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.docTableView reloadData];

}

- (void)setUpTextField {
    
    
    
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat: @"dd-MMM-yy"];
    //[self.dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    //  [self.dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    NSDate *defaultDate = [NSDate date];
    
    self.dateChangeHistory.text = [self.dateFormatter stringFromDate:defaultDate];
    self.dateChangeHistory.textColor = [self.view tintColor];
    datePickerHistory.hidden = NO;
    datePickerHistory.alpha = 0.0f;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        datePickerHistory.alpha = 1.0f;
        
    }];
    self.selectedDate = defaultDate;
    datePickerHistory.date = [NSDate date];
    [self.docTableView reloadData];

}

- (IBAction)pickerDateChanged:(UIDatePicker *)sender {
    
    self.dateChangeHistory.text =  [self.dateFormatter stringFromDate:sender.date];
    
    
  [self pendingLists];
    [self.docTableView reloadData];
    
    
    self.selectedDate = sender.date;
}







- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)planSchedule:(id)sender
{
    scheduleTimePage *secondViewController =     [self.storyboard instantiateViewControllerWithIdentifier:@"scheduleAppointments"];
    [self.navigationController pushViewController:secondViewController animated:YES];
    
}


#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     NSLog(@"sdghjgsddshfkgdsfkdshfsd%lu",(unsigned long)artArrayPendingList.count);
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
       return artArrayPendingList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
     static NSString *CellIdentifierPending;
    static NSString *CellIdentifierApproved;
  
     airportAtIndexDoc = [artArrayPendingList objectAtIndex:indexPath.row];
    
    if([self.segmentChangeHistory.text  isEqual: @"pending"]){
        CellIdentifierPending = @"pendingCell";
        UITableViewCell *cellExp = [tableView dequeueReusableCellWithIdentifier:CellIdentifierPending];
     
        if (cellExp == nil) {
            cellExp = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifierPending];
        }
        
        
        UITextField *label1 = (UITextField *)[cellExp viewWithTag:1];
        label1.text= [airportAtIndexDoc objectForKey:@"patientname"];
        
        UITextField *label2 = (UITextField *)[cellExp viewWithTag:2];
        label2.text= [airportAtIndexDoc objectForKey:@"reason"];
        
        
        
        
        return cellExp;
    }
    
    else{
         CellIdentifierApproved = @"approvedCell";
        
        UITableViewCell *cellNew = [tableView dequeueReusableCellWithIdentifier:CellIdentifierApproved];
        
        if (cellNew == nil) {
            cellNew = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifierApproved];
        }

        
        UITextField *label11 = (UITextField *)[cellNew viewWithTag:11];
        label11.text= [airportAtIndexDoc objectForKey:@"patientname"];
        
        UITextField *label12 = (UITextField *)[cellNew viewWithTag:12];
        label12.text= [airportAtIndexDoc objectForKey:@"reason"];
        
        UITextField *label13 = (UITextField *)[cellNew viewWithTag:13];
        label13.text= [airportAtIndexDoc objectForKey:@"apptime"];

        
        
        return cellNew;

    }
    
    
    

    
    
    return nil;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.docTableView beginUpdates];
    
    UITableViewCell *cell = [self.docTableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    airportAtIndexDoc = [artArrayPendingList objectAtIndex:indexPath.row];
    NSLog(@"gfdgdgdf%@",airportAtIndexDoc);
    NSLog(@"vdfvkgjdhfgflkdjg;ldfkg;kdf;gjdfjgldjfglkj");
   scheduleTimePage *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"scheduleAppointments"];
   [self.navigationController pushViewController:secondViewController animated:YES];
    
    secondViewController.delegate=self;
   secondViewController.appIdDetails = [airportAtIndexDoc objectForKey:@"appid"];
    secondViewController.patientNameDetails = [airportAtIndexDoc objectForKey:@"patientname"];
   secondViewController.patientReasonDetails = [airportAtIndexDoc objectForKey:@"reason"];

    
    
    [self.docTableView endUpdates];
    [self.docTableView reloadData];
    
}




/*
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"scheduleAppointments"])
    {
        scheduleTimePage *detailViewController =
        [segue destinationViewController];
        
        NSIndexPath *indexPath = [self.docTableView
                                    indexPathForSelectedRow];
        airportAtIndexDoc = [artArrayPendingList objectAtIndex:indexPath.row];
        
        detailViewController.patientIdDetails = [airportAtIndexDoc objectForKey:@"patientid"];
        detailViewController.patientNameDetails = [airportAtIndexDoc objectForKey:@"patientname"];
        detailViewController.patientReasonDetails = [airportAtIndexDoc objectForKey:@"reason"];

    }
}

*/




-(IBAction)indexChanged:(UISegmentedControl *)sender
{
    switch (self.docSegmentedControl.selectedSegmentIndex)
    {
        case 0:
            NSLog(@"First selected") ;
            
            self.segmentChangeHistory.text = @"pending";
            
            
            
            
                [self pendingLists];
          [self.docTableView reloadData];
            
            
            break;
        case 1:
            NSLog(@"Second selected") ;
             self.segmentChangeHistory.text = @"approved";
           
           
                [self approvedLists];
 [self.docTableView reloadData];
            
            break;
        default:
            
            break;
    }
}


-(void)pendingLists
{
    
    
    NSInteger success = 0;
    NSInteger errormsg = 0;
    NSString *post =[[NSString alloc] initWithFormat:@"docdate=%@&docid=%@&docstatus=%@&tag=%s",[self.dateChangeHistory text],self.doctorsId,[self.segmentChangeHistory text],"patientpendinglist"];
    NSLog(@"PostData: %@",post);
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSURL *url = [NSURL URLWithString:[selectDoctorpendingURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
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
        errormsg = [(NSNumber *) [jsonData objectForKey:@"error"] integerValue];
        NSLog(@"%d",success);
        if(success == 1)
        {
            artArrayPendingList = [jsonData objectForKey:@"pendinglist"];
            
            
            // artArrayDoctorList = [jsonData objectForKey:@"doctors"];
            NSLog(@"sucesssssss%lu",(unsigned long)artArrayPendingList.count);
            
            /*   artArrayDoctorList = [jsonData objectForKey:@"doctors"];
             for (NSDictionary *photo in artArrayDoctorList)
             {
             
             
             NSString *title = [photo objectForKey:@"email"];
             NSLog(@"email ... : %@",title);
             }
             
             */
        }
        
        if (errormsg==1) {
            
            artArrayPendingList = NULL;
            /*   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Records found !"
             message:@""
             delegate:nil
             cancelButtonTitle:@"OK"
             otherButtonTitles:nil];
             
             [alert show];
             [self.docTableView reloadData]; */
            
        }
        
    } else {
        
        NSLog(@"Login FAILED");
    }
    
    
}




-(void)approvedLists
{
    
    
    NSInteger success = 0;
      NSInteger errormsg = 0;
    NSString *post =[[NSString alloc] initWithFormat:@"docdate=%@&docid=%@&docstatus=%@&tag=%s",[self.dateChangeHistory text],self.doctorsId,[self.segmentChangeHistory text],"patientpendinglist"];
    NSLog(@"PostData: %@",post);
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSURL *url = [NSURL URLWithString:[selectDoctorpendingURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
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
          errormsg = [(NSNumber *) [jsonData objectForKey:@"error"] integerValue];
        NSLog(@"%d",success);
        if(success == 1)
        {
            artArrayPendingList = [jsonData objectForKey:@"pendinglist"];
            
            
           // artArrayDoctorList = [jsonData objectForKey:@"doctors"];
            NSLog(@"sucesssssss%lu",(unsigned long)artArrayPendingList.count);
            
            /*   artArrayDoctorList = [jsonData objectForKey:@"doctors"];
             for (NSDictionary *photo in artArrayDoctorList)
             {
             
             
             NSString *title = [photo objectForKey:@"email"];
             NSLog(@"email ... : %@",title);
             }
             
             */
        }
        
        if (errormsg==1) {
            
            artArrayPendingList = NULL;
         /*   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Records found !"
                                                            message:@""
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            
            [alert show];
            [self.docTableView reloadData]; */

        }
        
    } else {
        
        NSLog(@"Login FAILED");
    }
    
 
}

@end

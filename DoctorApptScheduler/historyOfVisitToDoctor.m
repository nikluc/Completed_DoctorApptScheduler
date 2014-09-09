//
//  historyOfVisitToDoctor.m
//  DoctorApptScheduler
//
//  Created by administrator on 12/08/14.
//
//

#import "historyOfVisitToDoctor.h"
#import "SBJson.h"


#define selectpatientapprovedURL @"http://10.10.30.150/doctor_Mopapp/index.php?tag=patientpendingapproved"

@interface historyOfVisitToDoctor ()
@property (nonatomic,weak) IBOutlet UISegmentedControl *docSegmentedControl;
@end
NSDictionary*airportAtIndexPat;
@implementation historyOfVisitToDoctor
@synthesize patTableView,patAcceptReject,patientId,patientName,patName;

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
    NSLog(@"patiiiiiiieeeeent id :%@",patientId);
    
    self.patAcceptReject.text = @"approved";
    
   
    
    
    
    patientName.text = patName;
    
    UIBarButtonItem *btnBack = [[UIBarButtonItem alloc]
                                initWithTitle:@"Logout"
                                style:UIBarButtonItemStyleBordered
                                target:self
                                action:@selector(OnClick_btnBack:)];
    self.navigationItem.leftBarButtonItem = btnBack;
     [self approvedLists];
    [self.patTableView reloadData];
   

}
-(IBAction)OnClick_btnBack:(id)sender  {
    [self.navigationController popViewControllerAnimated:YES];
    //[self.navigationController pushViewController:self.navigationController.parentViewController animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.docSegmentedControl.selectedSegmentIndex=1;
    self.patAcceptReject.text = @"approved";
    [self approvedLists];
    [self.patTableView reloadData];
    
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
    
    airportAtIndexPat = [artArrayPendingList objectAtIndex:indexPath.row];
    
    if([self.patAcceptReject.text  isEqual: @"pending"]){
        CellIdentifierPending = @"pendingListCell";
        UITableViewCell *cellExp = [tableView dequeueReusableCellWithIdentifier:CellIdentifierPending];
        
        if (cellExp == nil) {
            cellExp = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifierPending];
        }
        
        
       UITextField *label1 = (UITextField *)[cellExp viewWithTag:1];
       label1.text= [airportAtIndexPat objectForKey:@"docname"];
        
       UITextField *label2 = (UITextField *)[cellExp viewWithTag:2];
      label2.text= [airportAtIndexPat objectForKey:@"reason"];
        
        UITextField *label3 = (UITextField *)[cellExp viewWithTag:3];
        label3.text= [airportAtIndexPat objectForKey:@"appdate"];
        
        
        
        
        return cellExp;
    }
    
    else{
        CellIdentifierApproved = @"approvedListCell";
        
        UITableViewCell *cellNew = [tableView dequeueReusableCellWithIdentifier:CellIdentifierApproved];
        
        if (cellNew == nil) {
            cellNew = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifierApproved];
        }
        
        
        UITextField *label11 = (UITextField *)[cellNew viewWithTag:11];
        label11.text= [airportAtIndexPat objectForKey:@"docname"];
        
        UITextField *label12 = (UITextField *)[cellNew viewWithTag:12];
        label12.text= [airportAtIndexPat objectForKey:@"reason"];
        
        UITextField *label13 = (UITextField *)[cellNew viewWithTag:13];
        label13.text= [airportAtIndexPat objectForKey:@"appdate"];
        
        UITextField *label14 = (UITextField *)[cellNew viewWithTag:14];
        label14.text= [airportAtIndexPat objectForKey:@"apptime"];
        
        
        return cellNew;
        
    }
    
    
    
    
    
    
    return nil;
}



-(IBAction)indexChanged:(UISegmentedControl *)sender
{
    switch (self.docSegmentedControl.selectedSegmentIndex)
    {
        case 0:
            NSLog(@"First selected") ;
            
            self.patAcceptReject.text = @"pending";
            
            
            
            
            [self pendingLists];
            [self.patTableView reloadData];
            
            
            break;
        case 1:
            NSLog(@"Second selected") ;
            self.patAcceptReject.text = @"approved";
            
            
            [self approvedLists];
            [self.patTableView reloadData];
            
            break;
        default:
            
            break;
    }
}


-(void)pendingLists
{
    
    
    NSInteger success = 0;
    NSInteger errormsg = 0;
    NSString *post =[[NSString alloc] initWithFormat:@"patientid=%@&patstatus=%@&tag=%s",patientId,[self.patAcceptReject text],"patientpendingapproved"];
    NSLog(@"PostData: %@",post);
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSURL *url = [NSURL URLWithString:[selectpatientapprovedURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
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
            artArrayPendingList = [jsonData objectForKey:@"getalllists"];
            
            
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
    NSString *post =[[NSString alloc] initWithFormat:@"patientid=%@&patstatus=%@&tag=%s",patientId,[self.patAcceptReject text],"patientpendingapproved"];
    NSLog(@"PostData: %@",post);
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSURL *url = [NSURL URLWithString:[selectpatientapprovedURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
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
            artArrayPendingList = [jsonData objectForKey:@"getalllists"];
            
            
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




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

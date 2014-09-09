//
//  doctorsReqViewByPatient.m
//  DoctorApptScheduler
//
//  Created by administrator on 12/08/14.
//
//

#import "doctorsReqViewByPatient.h"

#import "doctorsProfileView.h"
#import "SBJson.h"


#define selectReasonURL @"http://10.10.30.150/doctor_Mopapp/index.php?tag=reasonofvisit"
#define selectRequestAppointmentURL @"http://10.10.30.150/doctor_Mopapp/index.php?tag=login"
#define selectRegisterURL @"http://10.10.30.150/doctor_Mopapp/index.php?tag=register"

UIPickerView *reasonPickerView ;

@interface doctorsReqViewByPatient ()
@property (nonatomic,weak) IBOutlet UISegmentedControl *segmentedControl;
@property (nonatomic,weak) IBOutlet UISegmentedControl *segmentedSexControl;

@property (nonatomic, strong) UITextField *reasonPickerViewTextField;

@end

@implementation doctorsReqViewByPatient
@synthesize photoView,nameView,designationView,addressView,countryView;
@synthesize reasonPickerViewTextField = _reasonPickerViewTextField;
@synthesize reasonResponseData,doctorIdView,imageViewPro;






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
 
    NSLog(@"reason array  :%@",reasonArtArray);
    
    
    self.photoViewLab.text=photoView;
    self.nameViewLab.text=nameView;
    self.designationViewLab.text=designationView;
    self.addressViewLab.text=addressView;
    self.countryViewLab.text=countryView;
    
   // self.profileViewLab.text=profileViewPro;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    
    
    
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    
    [datePicker setDate:[NSDate date]];
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    datePicker.minimumDate = [NSDate date];
    NSDateFormatter *formate=[[NSDateFormatter alloc]init];
    [formate setDateFormat:@"dd-MMM-yy"];
    //set date too your lable here
    self.selDate.text=[formate stringFromDate:datePicker.date];

    [self.selDate setInputView:datePicker];
    
    
    [self selectReason];
    
    self.reasonResponseData = [NSMutableData data];
   
    
    NSURLRequest *requestReason = [NSURLRequest requestWithURL:[NSURL URLWithString:selectReasonURL]];
    (void)[[NSURLConnection alloc] initWithRequest:requestReason delegate:self];

    NSLog(@"desig Id : %@",doctorIdView);
    
    
  //  self.imageViewPro.image = [UIImage imageWithData: [NSData dataWithContentsOfURL: [NSURL URLWithString: photoView]]];
    
    imageViewPro.layer.cornerRadius = 25;
    imageViewPro.layer.borderWidth = 2.0f;
    imageViewPro.layer.borderColor = [UIColor cyanColor].CGColor;
    imageViewPro.clipsToBounds = YES;
    
    
    

    
}



- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [reasonResponseData setLength:0];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [reasonResponseData appendData:data];
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    self.reasonResponseData = nil;
    
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
  
    NSError* error;
   
    
    NSDictionary *jsonVal = [NSJSONSerialization JSONObjectWithData:reasonResponseData options:kNilOptions error:&error];
    NSLog(@"Guide: %@", jsonVal);
    
    reasonArtArray = [jsonVal objectForKey:@"reasonofvisit"];
    
    [reasonPickerView reloadAllComponents] ;
  
}
//*******Picker view for CHOOSING Reason

-(void)selectReason
{
    self.reasonPickerViewTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.reasonPickerViewTextField];
    
    
    
    
    //self.reasonText.delegate = self;
  //  [self.view addSubview:self.reasonText];
    
    reasonPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    reasonPickerView.showsSelectionIndicator = YES;
    reasonPickerView.dataSource = self;
    reasonPickerView.delegate = self;
    
    // set change the inputView (default is keyboard) to UIPickerView
    //  self.pickerViewTextField.inputView = pickerView;
   
    // add a toolbar with Cancel & Done button
    UIToolbar *toolBarReason = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolBarReason.barStyle = UIBarStyleDefault;
  
   
    
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone  target:self action:@selector(doneReasonTouched:)];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelReasonTouched:)];
    
    // the middle button is to make the Done button align to right
    [toolBarReason setItems:[NSArray arrayWithObjects:cancelButton, [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], doneButton, nil]];
    //  self.pickerViewTextField.inputAccessoryView = toolBar;
     self.reasonText.inputView = reasonPickerView;
    
    self.reasonText.inputAccessoryView = toolBarReason;
    [self.reasonText resignFirstResponder];
    
}



- (void)cancelReasonTouched:(UIBarButtonItem *)sender
{
    // hide the picker view
    [self.reasonText resignFirstResponder];
}

- (void)doneReasonTouched:(UIBarButtonItem *)sender
{
    // hide the picker view
    [self.reasonText resignFirstResponder];
    
    // perform some action
}


-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [reasonPickerView reloadAllComponents] ;
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)reasonPickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)reasonPickerView numberOfRowsInComponent:(NSInteger)component
{
    return [reasonArtArray count];
}

#pragma mark - UIPickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)reasonPickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSDictionary *diction = [reasonArtArray objectAtIndex:row];
    NSLog(@"dict: %@", diction);
    return [diction objectForKey:@"reasonofvisits"];
    
    
    //  NSString *item = [artArray objectAtIndex:row];
    
    //  return item;
}

- (void)pickerView:(UIPickerView *)reasonPickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    NSDictionary *dictor = [reasonArtArray objectAtIndex:row];
    
    NSString* testVal11 =[dictor objectForKey:@"reasonofvisits"];
    NSString* testVal12 =[dictor objectForKey:@"reason_sk"];
    
    NSLog(@"tesval 11 :%@",testVal11);
    NSLog(@"tesval 11 :%@",testVal12);
    
    
    self.reasonTextId.text = [NSString stringWithFormat:@"%@",testVal12];
    
    self.reasonText.text = [NSString stringWithFormat:@"%@",testVal11];
}
//***************************************//






- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.segmentedControl.selectedSegmentIndex=0;
    self.segmentedSexControl.selectedSegmentIndex=-1;
    
    [self.regFirstName setHidden:YES];
    [self.regLastName setHidden:YES];
    [self.regEmail setHidden:YES];
    [self.regPassword setHidden:YES];
    [self.regAge setHidden:YES];
    [self.signupName setHidden:YES];
    [self.signupEmail setHidden:YES];
    [self.signupPassword setHidden:YES];
    [self.signupSex setHidden:YES];
    [self.signupAge setHidden:YES];
    [self.signupAge setHidden:YES];
   
     [self.patientRegistration setHidden:YES];
    [self.segmentedSexControl setHidden:YES];
    [self.enterDetails setHidden:YES];
    
    
    [self.selDate setHidden:NO];
    [self.reasonText setHidden:NO];
    [self.selDateLabel setHidden:NO];
    [self.reasonLabel setHidden:NO];
     [self.requestAppt setHidden:NO];
 
    
    [self.emailText setHidden:NO];
    [self.passwordText setHidden:NO];
    [self.loginEmail setHidden:NO];
    [self.loginPassword setHidden:NO];
    
    
   
}


-(void)updateTextField:(id)sender
{
    
    UIDatePicker *picker = (UIDatePicker*)self.selDate.inputView;
  
    NSDateFormatter *formate=[[NSDateFormatter alloc]init];
    [formate setDateFormat:@"dd-MMM-yy"];
    self.selDate.text=[formate stringFromDate:picker.date];
}


-(void)dismissKeyboard {
    [self.selDate resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)patientRegistration:(id)sender
{
 NSLog(@"sex : %@",self.sexSegment.text);
    NSInteger success = 0;
    NSString *emailReg = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailReg];
    
    
    NSString *passRegex = @"^([a-zA-Z0-9]{4,18}?)$";
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passRegex];
    
    
        if ([self.sexSegment.text  isEqual: @""]) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Registration Failed !"
                                                            message:@"Select Your Gender"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];}
    
    
        else{
            if ( self.regPassword.text.length<7 || self.regFirstName.text.length<1 ||self.regLastName.text.length<1 ||self.regEmail.text.length<1 ||self.regAge.text.length>2){
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Registration Failed !"
                                                                message:@"Check Your Fields"
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                
                [alert show];
                
               
                
            }
            else {
                
                if ([emailTest evaluateWithObject:self.regEmail.text] == NO) {
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Registration Failed !"
                                                                    message:@"Check Your Email"
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                    
                    [alert show];
                }
                else{
                    if ([passwordTest evaluateWithObject:self.regPassword.text] == NO) {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Enter password without space !"
                                                                        message:@""
                                                                       delegate:nil
                                                              cancelButtonTitle:@"OK"
                                                              otherButtonTitles:nil];
                        
                        [alert show];        }
                    else{
                
                   
                
                NSString *post =[[NSString alloc] initWithFormat:@"firstname=%@&lastname=%@&email=%@&password=%@&age=%@&sex=%@&tag=%s",[self.regFirstName text],[self.regLastName text],[self.regEmail text],[self.regPassword text],[self.regAge text],[self.sexSegment text],"register"];
                NSLog(@"PostData: %@",post);
                    
                
                NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
                
                NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
                
                NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
                NSURL *url = [NSURL URLWithString:[selectRegisterURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                
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
                        self.regFirstName.text =@"";
                        self.regLastName.text =@"";
                        self.regEmail.text =@"";
                        self.regPassword.text =@"";
                        self.regAge.text =@"";
                        self.sexSegment.text =@"";
                        
                        
                        [self.view endEditing:YES];
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Welcome"
                                                                        message:@"Registered Successfully !"
                                                                       delegate:nil
                                                              cancelButtonTitle:@"OK"
                                                              otherButtonTitles:nil];
                        [alert show];
                        
                    }
                    
               
                    
                }
                
            }        }
  
        }
    
    
        }
  
    
    
}


- (IBAction)requestAppt:(id)sender
{
    
    
    NSInteger success = 0;
    NSInteger errormsg = 0;
    
    
    
    NSString *post =[[NSString alloc] initWithFormat:@"doctorid=%@&patientemail=%@&patientpassword=%@&reasonid=%@&selecteddate=%@&tag=%s",doctorIdView,[self.emailText text],[self.passwordText text],[self.reasonTextId text],[self.selDate text],"login"];
    NSLog(@"PostData: %@",post);
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSURL *url = [NSURL URLWithString:[selectRequestAppointmentURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
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
        NSLog(@"errorrrrrrr :%d",errormsg);
        if(success == 1)
        {
            
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Doctor Appointment"
                                                            message:@"Request sent !"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
           
        }
        
        
    }
    
    
    
        
        if (errormsg == 1) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Request Failed"
                                                            message:@"Multiple Requests not allowed on the same day !"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            
        }
    if (errormsg == 2) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Request Failed"
                                                        message:@"Please Check emailID & password !"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    }

        else{
        NSLog(@"Login FAILED");
        }
    
    

    
    
}





-(IBAction)indexChanged:(UISegmentedControl *)sender
{
    switch (self.segmentedControl.selectedSegmentIndex)
    {
        case 0:
         NSLog(@"First selected") ;
            
            [self.regFirstName setHidden:YES];
            [self.regLastName setHidden:YES];
            [self.regEmail setHidden:YES];
            [self.regPassword setHidden:YES];
            [self.regAge setHidden:YES];
            [self.signupName setHidden:YES];
            [self.signupEmail setHidden:YES];
            [self.signupPassword setHidden:YES];
            [self.signupSex setHidden:YES];
            [self.signupAge setHidden:YES];
            [self.patientRegistration setHidden:YES];
            [self.requestAppt setHidden:YES];
            [self.segmentedSexControl setHidden:YES];
            [self.enterDetails setHidden:YES];
            
            [self.emailText setHidden:NO];
            [self.passwordText setHidden:NO];
            [self.loginEmail setHidden:NO];
            [self.loginPassword setHidden:NO];
            
            [self.selDate setHidden:NO];
            [self.reasonText setHidden:NO];
            [self.selDateLabel setHidden:NO];
            [self.reasonLabel setHidden:NO];
            [self.requestAppt setHidden:NO];
         
           
            break;
        case 1:
            NSLog(@"Second selected") ;
            
            
            [self.regFirstName setHidden:NO];
            [self.regLastName setHidden:NO];
            [self.regEmail setHidden:NO];
            [self.regPassword setHidden:NO];
            [self.regAge setHidden:NO];
            [self.signupName setHidden:NO];
            [self.signupEmail setHidden:NO];
            [self.signupPassword setHidden:NO];
            [self.signupSex setHidden:NO];
            [self.signupAge setHidden:NO];
             [self.patientRegistration setHidden:NO];
              [self.segmentedSexControl setHidden:NO];
            [self.enterDetails setHidden:NO];
            
            [self.selDate setHidden:YES];
            [self.reasonText setHidden:YES];
            [self.selDateLabel setHidden:YES];
            [self.reasonLabel setHidden:YES];
            [self.emailText setHidden:YES];
            [self.passwordText setHidden:YES];
            [self.loginEmail setHidden:YES];
            [self.loginPassword setHidden:YES];
            [self.requestAppt setHidden:YES];
            
            break;
        default:
            
            break; 
    } 
}

-(IBAction)sexChanged:(UISegmentedControl *)sender
{
    switch (self.segmentedSexControl.selectedSegmentIndex)
    {
        case 0:
            self.sexSegment.text=@"1";
           
            break;
        case 1:
            self.sexSegment.text=@"2";
            break;
        default:
           
            break;
    }
}




@end

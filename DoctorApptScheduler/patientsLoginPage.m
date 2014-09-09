//
//  patientsLoginPage.m
//  DoctorApptScheduler
//
//  Created by administrator on 12/08/14.
//
//

#import "patientsLoginPage.h"

#import "historyOfVisitToDoctor.h"

#import "SBJson.h"

#define kOFFSET_FOR_KEYBOARD 80.0
#define selectRequestAppointmentURL @"http://10.10.30.150/doctor_Mopapp/index.php?tag=frontpatientlogin"
#define selectRegisterURL @"http://10.10.30.150/doctor_Mopapp/index.php?tag=register"

@interface patientsLoginPage ()
@property (nonatomic,weak) IBOutlet UISegmentedControl *segmentedControl;
@property (nonatomic,weak) IBOutlet UISegmentedControl *segmentedSexControl;

@end

NSString *patId;
NSString *patName;
@implementation patientsLoginPage


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
    
    
}





- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    self.segmentedControl.selectedSegmentIndex=0;
    self.segmentedSexControl.selectedSegmentIndex=-1;
    
    [self.loginName setHidden:YES];
    [self.loginEmail setHidden:YES];
    [self.loginCreatePassword setHidden:YES];
    [self.loginAge setHidden:YES];
    [self.loginSex setHidden:YES];
    [self.PatientRegister setHidden:YES];
    
    [self.regFirstName setHidden:YES];
    [self.regLastName setHidden:YES];
    [self.regEmail setHidden:YES];
    [self.regPasswrod setHidden:YES];
    [self.regAge setHidden:YES];
    [self.regSex setHidden:YES];
    [self.segmentedSexControl setHidden:YES];
    
    [self.loginEmailId setHidden:NO];
    [self.loginPassword setHidden:NO];
    [self.patientLogin setHidden:NO];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)patientLogin:(id)sender
{
    
    
    NSInteger success = 0;
    NSInteger errormsg = 0;
    
    NSString *emailReg = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailReg];
    
    
    
    if ([emailTest evaluateWithObject:self.loginEmailId.text] == NO) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Enter valid email ID !"
                                                        message:@""
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        
        [alert show];
        
    }
    
    
    else{
        if ( self.loginPassword.text.length<7){
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid username/password !"
                                                            message:@""
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            
            [alert show];
            
            
            
        }
        else{
   
    
    
    NSString *post =[[NSString alloc] initWithFormat:@"patientemail=%@&patientpassword=%@&tag=%s",[self.loginEmailId text],[self.loginPassword text],"frontpatientlogin"];
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
            artArrayPatientList = [jsonData objectForKey:@"apprequests"];
            NSLog(@"dictionary test : %@",artArrayPatientList);
         
     
            
      
            for (NSDictionary *photo in artArrayPatientList)
            {
                patId =[photo objectForKey:@"patientid"];
                patName =[photo objectForKey:@"patientname"];
                
              
            }

            
            
            self.loginEmailId.text =@"";
            self.loginPassword.text =@"";
            
            
            
            [self.view endEditing:YES];
            
            historyOfVisitToDoctor *secondViewController =     [self.storyboard instantiateViewControllerWithIdentifier:@"patientLoginView"];
            [self.navigationController pushViewController:secondViewController animated:YES];
        secondViewController.patientId =patId;
            secondViewController.patName =patName;
              }
        
        
    }
    
        
    
    
    if (errormsg == 1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Username & Password"
                                                        message:@""
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    }
        
    

    
    
    
    
    }
    
    }
    
}
- (IBAction)patientRegister:(id)sender
{
    NSLog(@"sex : %@",self.regSex.text);
    NSInteger success = 0;
    NSInteger errormsg = 0;
    NSString *emailReg = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailReg];
    
    
    NSString *passRegex = @"^([a-zA-Z0-9]{4,18}?)$";
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passRegex];
    
    
    if ([self.regSex.text  isEqual: @""]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Registration Failed !"
                                                        message:@"Select Your Gender"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];}
    
    
    else{
        if ( self.regPasswrod.text.length<7 || self.regFirstName.text.length<1 ||self.regLastName.text.length<1 ||self.regEmail.text.length<1 ||self.regAge.text.length>2){
            
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
               
                if ([passwordTest evaluateWithObject:self.regPasswrod.text] == NO) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Enter password without space !"
                                                                    message:@""
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                    
                    [alert show];        }
                
                else{
                
                NSString *post =[[NSString alloc] initWithFormat:@"firstname=%@&lastname=%@&email=%@&password=%@&age=%@&sex=%@&tag=%s",[self.regFirstName text],[self.regLastName text],[self.regEmail text],[self.regPasswrod text],[self.regAge text],[self.regSex text],"register"];
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
                     errormsg = [(NSNumber *) [jsonData objectForKey:@"error"] integerValue];
                    NSLog(@"%d",success);
                    if(success == 1)
                    {
                        self.regFirstName.text =@"";
                        self.regLastName.text =@"";
                        self.regEmail.text =@"";
                        self.regPasswrod.text =@"";
                        self.regAge.text =@"";
                        self.regSex.text =@"";
                        
                        
                        [self.view endEditing:YES];
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Welcome"
                                                                        message:@"Registered Successfully !"
                                                                       delegate:nil
                                                              cancelButtonTitle:@"OK"
                                                              otherButtonTitles:nil];
                        [alert show];
                        
                    }
                    
                    if(errormsg == 2)
                    {
                     
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Email ID eixsting!"
                                                                        message:@"Please enter a new mail ID !"
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


-(IBAction)indexChanged:(UISegmentedControl *)sender
{
    switch (self.segmentedControl.selectedSegmentIndex)
    {
        case 0:
             [self.loginName setHidden:YES];
              [self.loginEmail setHidden:YES];
              [self.loginCreatePassword setHidden:YES];
             [self.loginAge setHidden:YES];
             [self.loginSex setHidden:YES];
            [self.PatientRegister setHidden:YES];
            
            [self.regFirstName setHidden:YES];
            [self.regLastName setHidden:YES];
            [self.regEmail setHidden:YES];
            [self.regPasswrod setHidden:YES];
            [self.regAge setHidden:YES];
            [self.regSex setHidden:YES];
            [self.segmentedSexControl setHidden:YES];
            
            [self.loginEmailId setHidden:NO];
            [self.loginPassword setHidden:NO];
            [self.patientLogin setHidden:NO];
            
            
            
            break;
        case 1:
            
            [self.loginName setHidden:NO];
            [self.loginEmail setHidden:NO];
            [self.loginCreatePassword setHidden:NO];
            [self.loginAge setHidden:NO];
            [self.loginSex setHidden:NO];
            [self.PatientRegister setHidden:NO];
            
            [self.regFirstName setHidden:NO];
            [self.regLastName setHidden:NO];
            [self.regEmail setHidden:NO];
            [self.regPasswrod setHidden:NO];
            [self.regAge setHidden:NO];
            [self.regSex setHidden:NO];
            [self.segmentedSexControl setHidden:NO];
            
            [self.loginEmailId setHidden:YES];
            [self.loginPassword setHidden:YES];
            [self.patientLogin setHidden:YES];
            
           
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
           self.regSex.text= @"1";
            
            break;
        case 1:
          self.regSex.text = @"2";
            break;
        default:
            
            break;
    }
}




@end

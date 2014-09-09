//
//  doctorsListView.m
//  DoctorApptScheduler
//
//  Created by administrator on 11/08/14.
//
//

#import "doctorsListView.h"
#import "doctorsProfileView.h"
#import "doctorsReqViewByPatient.h"

NSDictionary *airportAtIndex;
@interface doctorsListView ()


@end

@implementation doctorsListView
@synthesize myTableView,doctorListArray,imageView;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [myTableView reloadData];
    
  
    NSLog(@"djkshfsdjvbbnuenvnjskdnvlnsdlv %@",doctorListArray);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [doctorListArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"doctorsList";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:
                UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
      
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    
    
   UIButton *apptButton = (UIButton *)[cell viewWithTag:11];
    
    long row = [indexPath row];
    [apptButton setTag:row];
    [apptButton addTarget:self action:@selector(apptButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:apptButton];
    
    
    airportAtIndex = [doctorListArray objectAtIndex:indexPath.row];
    
  
    
    // UIImageView *background = [[UIImageView alloc] initWithFrame:CGRectMake(500, 50, 20, 20)];
       imageView=(UIImageView *)[cell viewWithTag:1];
    
   // self.imageView.image = [UIImage imageWithData: [NSData dataWithContentsOfURL: [NSURL URLWithString: [airportAtIndex objectForKey:@"photo"]]]];
    
    imageView.layer.cornerRadius = 15;
    imageView.layer.borderWidth = 2.0f;
    imageView.layer.borderColor = [UIColor cyanColor].CGColor;
    imageView.clipsToBounds = YES;

   // [cell.contentView addSubview:background];
    
    


  
    
    UILabel *label2 = (UILabel *)[cell viewWithTag:3];
    label2.text= [airportAtIndex objectForKey:@"designation"];
    
    
    UILabel *label3 = (UILabel *)[cell viewWithTag:2];
    NSString *firname =[airportAtIndex objectForKey:@"firstname"];
    NSString *lasname =[airportAtIndex objectForKey:@"lastname"];
    NSString *name = [NSString stringWithFormat: @"%@ %@", firname, lasname];
    label3.text= name;
    
     
    UILabel *label4 = (UILabel *)[cell viewWithTag:4];
    NSString *addr =[airportAtIndex objectForKey:@"address"];
    NSString *city =[airportAtIndex objectForKey:@"city"];
    NSString *state =[airportAtIndex objectForKey:@"state"];
    NSString *pincode =[airportAtIndex objectForKey:@"pincode"];
    NSString *addressline = [NSString stringWithFormat: @"%@,%@,%@ %@", addr, city, state, pincode];
   label4.text= addressline;
    
    UILabel *label5 = (UILabel *)[cell viewWithTag:5];
    label5.text= [airportAtIndex objectForKey:@"country"];
    



    return cell;
}

-(void)apptButtonAction:(UIButton*)sender
{
   
        [myTableView beginUpdates];
   
    
       NSString* inStr = [NSString stringWithFormat: @"%d", (int)[sender tag]];
        NSLog(@"db val : %@",inStr);
        CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.myTableView];
        NSIndexPath *indexPath = [self.myTableView indexPathForRowAtPoint:buttonPosition];
       
        if (indexPath != nil)
        {
          
            NSLog(@"index val : %d",indexPath.row);
            
            
            
           //  NSIndexPath *indexPath = [myTableView indexPathForSelectedRow];
             airportAtIndex = [doctorListArray objectAtIndex:indexPath.row];
            doctorsReqViewByPatient *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"appointmentReqView"];
          [self.navigationController pushViewController:secondViewController animated:YES];
          
                   
            
           // secondViewController.photoView = [airportAtIndex objectForKey:@"photo"];
            NSString *firname =[airportAtIndex objectForKey:@"firstname"];
            NSString *lasname =[airportAtIndex objectForKey:@"lastname"];
            NSString *name = [NSString stringWithFormat: @"%@ %@", firname, lasname];
            secondViewController.nameView = name;
            secondViewController.designationView = [airportAtIndex objectForKey:@"designation"];
            NSString *addr =[airportAtIndex objectForKey:@"address"];
            NSString *city =[airportAtIndex objectForKey:@"city"];
            NSString *state =[airportAtIndex objectForKey:@"state"];
            NSString *pincode =[airportAtIndex objectForKey:@"pincode"];
            NSString *addressline = [NSString stringWithFormat: @"%@,%@,%@ %@", addr, city, state, pincode];
            secondViewController.addressView = addressline;
            secondViewController.countryView = [airportAtIndex objectForKey:@"country"];
               secondViewController.doctorIdView = [airportAtIndex objectForKey:@"doctor_sk"];
           
            
            
        
            
       
      
            
        }
        
        [myTableView endUpdates];
        [myTableView reloadData];
        
        
        
        NSLog(@"dsfgjksfshd");
   
}


- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [myTableView beginUpdates];
    
    UITableViewCell *cell = [myTableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    airportAtIndex = [doctorListArray objectAtIndex:indexPath.row];
    doctorsProfileView *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"doctornewProfileView"];
[self.navigationController pushViewController:secondViewController animated:YES];

    
    
   // secondViewController.photoViewPro = [airportAtIndex objectForKey:@"photo"];
    NSString *firname =[airportAtIndex objectForKey:@"firstname"];
    NSString *lasname =[airportAtIndex objectForKey:@"lastname"];
    NSString *name = [NSString stringWithFormat: @"%@ %@", firname, lasname];
    secondViewController.nameViewPro = name;
    secondViewController.designationViewPro = [airportAtIndex objectForKey:@"designation"];
    NSString *addr =[airportAtIndex objectForKey:@"address"];
    NSString *city =[airportAtIndex objectForKey:@"city"];
    NSString *state =[airportAtIndex objectForKey:@"state"];
    NSString *pincode =[airportAtIndex objectForKey:@"pincode"];
    NSString *addressline = [NSString stringWithFormat: @"%@,%@,%@ %@", addr, city, state, pincode];
    secondViewController.addressViewPro = addressline;
    secondViewController.countryViewPro = [airportAtIndex objectForKey:@"country"];
    secondViewController.emailViewPro = [airportAtIndex objectForKey:@"email"];
    secondViewController.profileViewPro = [airportAtIndex objectForKey:@"description"];
    
    
    [myTableView endUpdates];
    [myTableView reloadData];
    
}



@end

use strict;
use warnings;
use POSIX ":sys_wait_h";
use Getopt::Long;
use Data::Dumper;
use Cwd;

use lib qw(C:/Users/yousefh/workspace-po/play_ground/Archive);
require SevenZip;

my ($contract,$path,$dir);
GetOptions (
              "path=s"   => \$dir,  # string
               "contract=s"   => \$contract,  # string
            ) or die("Usage: $0 --from file\n");



chdir "$dir";

my ($Summary_report_name,  $seven_zip_run);
       
opendir(my $dh, $dir) || die "Can't open $dir: $!";

while (readdir $dh) {
       next if $_ =~ /^\.\.?$/;
       ( $seven_zip_run, $Summary_report_name)= get_summary_report ($_);    
        if ($Summary_report_name=~ m/MailSummaryReport/)   {
         		eval{	
             		find_pulls_stream ( ARCHIVE_NAME=>$_, 
                                 		REPORT_NAME=>$Summary_report_name, 
                                		 RUN_NUMBER=> $seven_zip_run
                                 	);
                                 	   
                                 	my $test= waitpid -1, 0;    #The waitpid() system call suspends execution of the current process until a child specified by pid argument has changed state         
             	                                       #perl open3: IO::Pipe: Can't spawn-NOWAIT: Resource temporarily unavailable
             	                   print"$test ,\n";
         		}; exit $@ if $@;
           		
        }
} #while

 closedir $dh;


sub get_summary_report{
	    my $seven_zip=shift;
	    my @seven_zip_run= split /_/, $seven_zip ;
	    $seven_zip_run[1] =~ s/.7z$//;
	    $seven_zip_run[1] =~ m/([1-9]+0{0,5})$/;
	    my $Summary_report_name ="$seven_zip_run[1]\\Print_Files\\$seven_zip_run[0]_MailSummaryReport_$1.txt";
		return $seven_zip_run[1], $Summary_report_name;
}


sub find_pulls_stream{
	
					my %args=@_;
				    my $seven_zip= $args{ARCHIVE_NAME};
				    my $Summary_report_name =$args{REPORT_NAME};
				    my $seven_zip_run =$args{RUN_NUMBER};
	
				    my $ar = Archive::SevenZip->new(
					               archivename => "$seven_zip",
					               find        => 1,
					              # verbose => 1,
					        );					  
				    print "Processing: $seven_zip_run\\Print_Files\\$Summary_report_name \n";  
				    my $fh = $ar->openMemberFH("$Summary_report_name");
			
			   			while( <$fh> ) {
			  	    					if ($_ =~ m/PULLS/){
			        						print "Found in : $seven_zip_run\\Print_Files\\$Summary_report_name \n ";
			        						print "Line : $_ \n ";
			  	    					} 
			   			 }; #   waitpid($pid,&WNOHANG); #perl open3: IO::Pipe: Can't spawn-NOWAIT: Resource temporarily unavailable
			        waitpid -1, 0;
			        # my $child_exit_status = $? >> 8;
			        return;
}







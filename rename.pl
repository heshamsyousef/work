use strict;
use warnings;
use Data::Dumper;
use English;
use Cwd qw(abs_path);
use Getopt::Long;
#my $path = abs_path();
use File::Copy;

my $path= 'C:\Temp\PROD\config';
chdir "$path";

        opendir(my $dh, $path) || die "Can't open $path: $!";
        while (readdir $dh) {
        	next if $_ =~ /^\.\.?$/;
        	$_ =~ m/([0-9A-Z]+0008_)/;
        	my $new= "$1"."CONNECTCOMPANYDETAIL.cfg \n";
            print "$new \n";
            copy($_, "C:\\Temp\\PROD\\config\\new\\$new") || die "Cannot copy $_: $!";;
        }
        closedir $dh;


#read_conf_files($path);
sub read_conf_files {
	my $path=shift;
	foreach my $fp (glob("*.cfg")) {
		$fp =~ m/([0-9A-Z]+0008_)/;
		my $new= "$1"."CONNECTCOMPANYDETAIL \n";
		  printf "%s\n",  $fp;
		rename($fp, $new."cfg") || die "Cannot rename $fp: $!";;
		    
		  
   }
  
}
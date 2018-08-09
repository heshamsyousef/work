use strict;
use warnings;
use POSIX ":sys_wait_h";
use Getopt::Long;
use Data::Dumper;
use Cwd;

use File::Basename qw( fileparse );
use File::Path qw( make_path );
use File::Spec;
use File::Copy;

#use lib qw(C:/Users/yousefh/workspace-po/play_groundTest);
#require MySub qw(copy_file);





my ($contract,$path,$source, $target,$file_name);
GetOptions (
              "source=s"   => \$source,  # string
               "target=s"   => \$target,  # string
               "file_name=s" =>\$file_name,
            ) or die("Usage: $0 --from file\n");


$source ="Z:\\Implementation - Shared\\01 - Change_Requests\\COCC\\126 COCC_LB Consolidation - Onboarding\\4-Testing\\008 Prod Archives\\";
$target="Z:\\Implementation - Shared\\01 - Change_Requests\\COCC\\126 COCC_LB Consolidation - Onboarding\\3-Setups\\008 Prod Rerun Setups - FIs\\LB Input Files";
$file_name='Releasefiles\*.zip';
chdir "$source";




#if (not -d $target) { make_path $target or die "Failed to create path: $target";}
opendir(my $dh, $source) || die "Can't open $source: $!";

while (readdir $dh) {
	next if $_ =~ /^\.\.?$/;
    copy_file($_,$target,$file_name);     
}    
closedir $dh;


sub copy_file{
	my $folder=shift;
	my $target=shift;
	my $file_name	=shift; 
	my @file = glob "$folder/$file_name";
	print " copying $folder, $file[0] to $target \n";
	  copy($file[0],$target) or die "Copy failed: $!";
	return;
	
}
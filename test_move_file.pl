use strict;
use warnings;
use POSIX ":sys_wait_h";
use Getopt::Long;
use Data::Dumper;
use Cwd;



 





my ($contract,$path,$source, $target,$file_name);
GetOptions (
              "source=s"   => \$source,  # string
               "target=s"   => \$target,  # string
               "file_name=s" =>\$file_name,
            ) or die("Usage: $0 --from file\n");

chdir "$source";

if (not -d $target) { make_path $target or die "Failed to create path: $target";}
opendir(my $dh, $source) || die "Can't open $source: $!";

while (readdir $dh) {
	next if $_ =~ /^\.\.?$/;
    Test::MySub::copy_file($_,$target,$file_name);     
}    
closedir $dh;



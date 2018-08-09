use strict;
use warnings;
use Data::Dumper;
use English;
use Cwd qw(abs_path);
use Getopt::Long;
my $path = abs_path();
my ($source,$target,$switch);
use Capture::Tiny ':all';
 
  my $verbose;
  GetOptions (
              "path=s"   => \$path,  # string
              "source=s"  => \$source,
              "target=s" => \$target, 
              "switch=s" => \$switch,
              "verbose"  => \$verbose)   # flag
  or die("Usage: $0 --from file\n");

open ( my $fh, "<", 'C:\Temp\PROD\input\TEST_1154_20180724_RT_STMNT.stt') or "die cant open graphics.text: $!";
my @st=();
while (<$fh>) {
	if ($_ =~ m/^\d{1,4}\s+([a-zA-Z]+\s+[a-zA-Z]+?)/){
	   #print $1 ,"\n";
		push  @st, $1;
		#print $1 ,"\n";
	}
}
#print  @st;
close $fh;

my $uniq_st = uniq(@st);
print scalar keys %$uniq_st;
sub uniq {
    my %seen;
    grep !$seen{$_}++, @_;
   return \%seen;
}
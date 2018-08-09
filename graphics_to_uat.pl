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

open ( my $fh, ">", 'c:\temp\prod\config\graphics\graphics.text') or "die cant open graphics.text: $!";

my @graphics= read_conf_files($path);

my @graphic_names=get_graphic_names(@graphics);

my @uniq_graphics = uniq(@graphic_names);


exe_xcopy(@uniq_graphics);

close $fh;

my $exec_time=time - $^T;
print "Execution took  $exec_time sec.";

sub read_conf_files {
	my $path=shift;
	 my @graphics;
	foreach my $fp (glob("$path/*.cfg")) {
		  #printf "%s\n", $fp;
		  open my $fh, "<", $fp or die "can't read open '$fp': $OS_ERROR";
		  while (<$fh>) {
		      	if  ($_ =~ /\.jpg|\.pdf|\.pcx/i){
		     	     push @graphics,  $_;
		        }
		    
		   }
		  close $fh or die "can't read close '$fp': $OS_ERROR";
   }
   return @graphics;
}

sub get_graphic_names{
	my @graphics_only;
	foreach my $graphic ( @_){
		    $graphic =~ s/^.*://;
		    push  @graphics_only,$graphic;	   
	}
	 return @graphics_only;
}

sub uniq {
    my %seen;
    grep !$seen{$_}++, @_;
   
}


sub exe_xcopy{
	my ($stdout, $stderr, $exit);
	foreach my $f_graphic (@_){
			chomp($f_graphic);
			my $command = "xcopy $source\\$f_graphic  $target  $switch";
			print "executing $command \n";	
		    ($stdout, $stderr, $exit) = capture {system $command ;}	;
		    print $fh $stdout;
		    exit;
	 }
	 print "All Graphics were copied \n"
}




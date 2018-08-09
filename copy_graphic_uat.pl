use strict;
use warnings;
use Data::Dumper;
use English;
use Cwd qw(abs_path);
use Getopt::Long;
my $path = abs_path();
my ($source,$target,$switch);
  my @graphics;
  my $verbose;
  GetOptions (
              "path=s"   => \$path,  # string
              "source=s"  => \$source,
              "target=s" => \$target, 
              "switch=s" => \$switch,
              "verbose"  => \$verbose)   # flag
  or die("Usage: $0 --from file\n");
@graphics= read_config($path);

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

my @graphic_names=get_graphic_names(@graphics);

#my @graphic_only;
#foreach my $graphic ( @graphics){
#	    $graphic =~ s/^.*://;
#	    push  @graphic_only,$graphic;
#}

my @filtered_graphics = uniq(@graphic_names);
#print @filtered_graphics;


exe_xcopy(@filtered_graphics);

#foreach my $f_graphic (@filtered_graphics){
#	chomp($f_graphic);
#	my $command = "xcopy $source\\$f_graphic  $target  $switch";
#	print "executing $command \n";
#    system "$command ";	
#}


sub uniq {
    my %seen;
    grep !$seen{$_}++, @_;
}


sub exe_xcopy{
	foreach my $f_graphic (@_){
			chomp($f_graphic);
			my $command = "xcopy $source\\$f_graphic  $target  $switch";
			print "executing $command \n";
			
		    if (not $verbose) {system "$command ";}	
	 }
	 print "All Graphics were copied \n"
}

sub get_graphic_names{
	my @graphics_only;
	foreach my $graphic ( @_){
		    $graphic =~ s/^.*://;
		    push  @graphics_only,$graphic;	   
	}
	 return @graphics_only;
}

sub read_config {
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
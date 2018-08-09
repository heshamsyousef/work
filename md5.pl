#!/usr/bin/perl

use strict;
use warnings;
use Digest::MD5 qw(md5_hex);

my $dirname = "C:\\Temp\\duplicate";
opendir( DIR, $dirname );
my @files = sort ( grep { !/^\.|\.\.}$/ } readdir(DIR) );
closedir(DIR);

#print "@files\n";

foreach my $file (@files) {
	print "$file \n";
    if ( -d $file || !-r $file ) { next; }
    open( my $FILE, $file );
    binmode($FILE);
    print Digest::MD5->new->addfile($FILE)->hexdigest, " $file \n";
    close($FILE);
}
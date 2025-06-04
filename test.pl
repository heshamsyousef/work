#!/usr/bin/perl
    use strict;
    use warnings;
	use File::stat;

    my $directory = 'C:\Users\YousefH\Documents\gold';

    opendir (DIR, $directory) or die $!;
	while (my $file = readdir(DIR)) {
           my $sb= system ( stat($file));
        print "$sb->size:$file\n";

    }

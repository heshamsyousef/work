#!/usr/bin/perl
use strict;
use warnings;
use File::stat;
use File::Spec; # For joining paths

# Get the directory from the first command-line argument, or default to the current directory
my $directory = @ARGV ? $ARGV[0] : '.';

opendir(my $dh, $directory) or die "Could not open directory '$directory': $!";

print "Size:Filename\n";
print "------------\n";

while (my $file = readdir($dh)) {
    # Skip . and ..
    next if ($file eq '.' or $file eq '..');

    my $full_path = File::Spec->catfile($directory, $file);
    my $stat_info = stat($full_path);

    if ($stat_info) {
        print $stat_info->size . ":$file\n";
    } else {
        warn "Could not stat file '$full_path': $!";
    }
}

closedir($dh);

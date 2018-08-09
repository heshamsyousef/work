use digest::MD5;

print "\nPlease enter filepath and name (including file extension) of 
+the first file you would like to compare:\n\n";
$fileone = <STDIN>;
chomp $fileone;
print "\n\n";

print "\nPlease enter filepath and name (including file extension) of 
+the first file you would like to compare:\n\n";
$filetwo = <STDIN>;
chomp $filetwo;
print "\n\n";

open (FILE, $fileone) or print "File invalid, Please try again.";

print "The MD5 hash of file one is: ";
$md5a = Digest::MD5->new->addfile(*FILE)->clone->hexdigest;
print "$md5a\n\n";

open (FILE, $filetwo) or print "File invalid, Please try again.";

print "The MD5 hash of file two is: ";
$md5b = Digest::MD5->new->addfile(*FILE)->clone->hexdigest;
print "$md5b\n\n";
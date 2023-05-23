# use perl

# run directly in each subfolder with parametersRemoved.txt
# used to remove ID elements from XML output


use warnings;
use strict;

# define parameters to remove using a reference file
# push the parameters to an array
my $params = "parametersRemoved.txt";
open (PARMS,"<$params") || print "$params not found\n";
my @parms = <PARMS>;
close PARMS;
my @parameters;
for $_(@parms){
    my $value = $_;
    chomp $value;
    push @parameters, $value;
}

# defining working files
@ARGV = glob("*.xml");
my $fileCount = 0;

print "\n";
print "###################################################################\n";
print "\n";

foreach my $file (@ARGV){
    $fileCount++;

    open (FILEI,"<$file") || print "$file not found\n";
    my @wholeFile = <FILEI>;
    close FILEI;
    print "Input file: $file\n";

    my $fileOut = "dID-$file";
    print "Output file: $fileOut\n\n";
    open (FILEO,">>$fileOut") || print "$fileOut not found\n";

    # compare each line to the parameters array
    # remove data tagged by the parameters
    for $_(@wholeFile){
        my $line = $_;
        for $_(@parameters){
            my $p = $_;
            if ($line =~ m/\<$p\>/g){
                $line =~ s/\<$p\>.+\<\/$p\>/\<$p\>\<\/$p\>/g;
                #print $line;
                last;
            }
        }
        # strip extraneous free text lines with timestamps
        if ($line =~ m/.+ (PM|AM)/g){
                $line =~ s/.+ (PM|AM)//g;
                #print $line;
        }
        print FILEO $line;
    }

    close FILEO;
}



print "\nProcessed $fileCount files.\n";
print "\n";
print "###################################################################\n";
print "\n";

sleep 1;

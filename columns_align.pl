#! use perl
## columns_align.pl file1 file2

use warnings;
use strict;

# call 2 files from ARGV
my $file1 = $ARGV[0];
my $file2 = $ARGV[1];

# define separator
print "Enter column separator: ";
my $sep = <STDIN>;
chomp $sep;

# line count var
my $lc = 0;

# row vars
my ($row1, $row2);

# read first file
open(F1,"<$file1");
for $_(<F1>){
    last if $lc == 1;
    $row1 = $_;
    chomp $row1;
    $lc++;
}

# reset line count
$lc = 0;

# read second file
open(F2,"<$file2");
for $_(<F2>){
    last if $lc == 1;
    $row2 = $_;
    chomp $row2;
    $lc++;
}

# sort headers
my @d1 = split($sep, $row1);
my @row1_sorted = sort(@d1);
my $r1 = join("\",\"", @row1_sorted);
my @d2 = split($sep, $row2);
my @row2_sorted = sort(@d2);
my $r2 = join("\",\"", @row2_sorted);

# map header arrays to hashes
my %head1 = map { $_ => 1 } @row1_sorted;
my %head2 = map { $_ => 1 } @row2_sorted;

# use hashes to compare to eachother
# print missing columns for each file
my @m1;
my @m2;
print "Fields missing from $file2\n\tfound in $file1:\n";
foreach my $var(keys %head1){
    if(exists($head2{$var})){ 
        next;
    }
    else{ 
        push(@m1,$var);
    }
}
my @m1_s = sort(@m1);
for $_(@m1_s){
    print "$_\n";
}
print "---\n";
print "Fields missing from $file1\n\tfound in $file2:\n";
foreach my $var(keys %head2){
    if(exists($head1{$var})){ 
        next;
    }
    else{ 
        push(@m2,$var);
    }
}
my @m2_s = sort(@m2);
for $_(@m2_s){
    print "$_\n";
}
print "---\n";

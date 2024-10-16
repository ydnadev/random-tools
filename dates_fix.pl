#! use perl

use warnings;
use strict;

my $inputFile = $ARGV[0];
my $outputFile = "dates_fixed-".$inputFile;

open(IN,"<$inputFile") || print "can't open $inputFile\n";
open(OUT,">>$outputFile") || print "can't open $outputFile\n";


for $_(<IN>){
    my $line = $_;
    #print "$line\n";
    chomp $line;

    my @array = split(",",$line);
    my @data_array;

    for $_(@array){
        my $var = $_;
        my $var_new;

        # 01/02/2012
        if ($var =~ m/(..)(\/|-)(..)(\/|-)(....)/){
            my ($m,$d,$y) = ($1,$3,$5);
            if ($m =~ m/[0-9][0-9]/){
                if ($d =~ m/[0-9][0-9]/){
                    $var_new = "$y-$m-$d";
                    push(@data_array,$var_new);
                    print "$var_new";
                }
            }
        }
        # 10/5/2012
        elsif ($var =~ m/(..)(\/|-)(.)(\/|-)(....)/){
            my ($m,$d,$y) = ($1,$3,$5);
            if ($m =~ m/[0-9][0-9]/){
                if ($d =~ m/[0-9]/){
                    $var_new = "$y-$m-0$d";
                    push(@data_array,$var_new);
                    print "$var_new";
                }
            }
        }
        # 5/10/2012
        elsif ($var =~ m/(.)(\/|-)(..)(\/|-)(....)/){
            my ($m,$d,$y) = ($1,$3,$5);
            if ($m =~ m/[0-9]/){
                if ($d =~ m/[0-9][0-9]/){
                    $var_new = "$y-0$m-$d";
                    push(@data_array,$var_new);
                    print "$var_new";
                }
            }
        }
        # 5/1/2012
        elsif ($var =~ m/(.)(\/|-)(.)(\/|-)(....)/){
            my ($m,$d,$y) = ($1,$3,$5);
            if ($m =~ m/[0-9]/){
                if ($d =~ m/[0-9]/){
                    $var_new = "$y-0$m-0$d";
                    push(@data_array,$var_new);
                    print "$var_new";
                }
            }
        }
        # 01/02/12
        elsif($var =~ m/(..)(\/|-)(..)(\/|-)(..)/){
            my ($m,$d,$y) = ($1,$3,$5);
            if ($m =~ m/[0-9][0-9]/){
                if ($d =~ m/[0-9][0-9]/){
                    $var_new = "20$y-$m-$d";
                    push(@data_array,$var_new);
                    print "$var_new";
                }
            }
        }
        # 10/5/12
        elsif($var =~ m/(..)(\/|-)(.)(\/|-)(..)/){
            my ($m,$d,$y) = ($1,$3,$5);
            if ($m =~ m/[0-9][0-9]/){
                if ($d =~ m/[0-9]/){
                    $var_new = "20$y-$m-0$d";
                    push(@data_array,$var_new);
                    print "$var_new";
                }
            }
        }
        # 5/10/12
        elsif ($var =~ m/(.)(\/|-)(..)(\/|-)(..)/){
            my ($m,$d,$y) = ($1,$3,$5);
            if ($m =~ m/[0-9]/){
                if ($d =~ m/[0-9][0-9]/){
                    $var_new = "20$y-0$m-$d";
                    push(@data_array,$var_new);
                    print "$var_new";
                }
            }
        }
        # 5/1/12
        elsif ($var =~ m/(.)(\/|-)(.)(\/|-)(..)/){
            my ($m,$d,$y) = ($1,$3,$5);
            if ($m =~ m/[0-9]/){
                if ($d =~ m/[0-9]/){
                    $var_new = "20$y-0$m-0$d";
                    push(@data_array,$var_new);
                    print "$var_new";
                }
            }
        }
        # 10-Apr-12
        elsif ($var =~ m/(..)(\/|-)(...)(\/|-)(..)/){
            print("10-Apr-12\n");
            my ($d,$m,$y) = ($1,$3,$5);
            if ($m =~ m/([A-Z]|[a-z]{3})/){
                $m =~ s/(J|j)an/01/g;
                $m =~ s/(F|f)eb/02/g;
                $m =~ s/(M|m)ar/03/g;
                $m =~ s/(A|a)pr/04/g;
                $m =~ s/(M|m)ay/05/g;
                $m =~ s/(J|j)un/06/g;
                $m =~ s/(J|j)ul/07/g;
                $m =~ s/(A|a)ug/08/g;
                $m =~ s/(S|s)ep/09/g;
                $m =~ s/(O|o)ct/10/g;
                $m =~ s/(N|n)ov/11/g;
                $m =~ s/(D|d)ec/12/g;
                if ($d =~ m/[0-9][0-9]/){
                    $var_new = "20$y-$m-$d";
                    push(@data_array,$var_new);
                    print "$var_new";
                }
            }
        }
        # 1-Apr-12 or 1/Apr/12
        elsif ($var =~ m/(.)(\/|-)(...)(\/|-)([0-9][0-9])/){
            print("1-Apr-12\n");
            my ($d,$m,$y) = ($1,$3,$5);
            if ($m =~ m/([A-Z]|[a-z]{3})/){
                $m =~ s/(J|j)an/01/g;
                $m =~ s/(F|f)eb/02/g;
                $m =~ s/(M|m)ar/03/g;
                $m =~ s/(A|a)pr/04/g;
                $m =~ s/(M|m)ay/05/g;
                $m =~ s/(J|j)un/06/g;
                $m =~ s/(J|j)ul/07/g;
                $m =~ s/(A|a)ug/08/g;
                $m =~ s/(S|s)ep/09/g;
                $m =~ s/(O|o)ct/10/g;
                $m =~ s/(N|n)ov/11/g;
                $m =~ s/(D|d)ec/12/g;
                if ($d =~ m/[0-9]/){
                    $var_new = "20$y-$m-0$d";
                    push(@data_array,$var_new);
                    print "$var_new";
                }
            }
        }
        # 2020/07/11
        elsif ($var =~ m/([0-9][0-9][0-9][0-9])(\/|-)([0-9][0-9])(\/|-)([0-9][0-9])/){
            my ($d,$m,$y) = ($5,$3,$1);
            $var_new = "$y-$m-$d";
                    push(@data_array,$var_new);
            print "$var_new\n";
        }
        else {
            push(@data_array,$var);
            print "$var";
        }
        print ",";
    }
    my $new_line = join(',',@data_array);
    print OUT "$new_line\n";
    print "\n";
}
close IN;
close OUT;
print "New file --> $outputFile\n";

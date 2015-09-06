#!/usr/bin/perl

use strict;
use Storable qw(dclone);
use Data::Dumper;
use List::Util qw(shuffle );

=head1 SUMMARY

Simple program to help answer the question - "If I have 

=cut

my $theBest;

sub main(@) {
  my $config = {};
  my $peopleArray = [];
  my $theBestAverage = -1;
  my $theLeastDuplicates = -1;

  
  $config->{"TABLE_SIZE"} = 6;
  $config->{"TABLE_COUNT"} = 5;
  $config->{"ROUNDS"} = 3;
  $config->{"TRY_COUNT"} = 10000000;
  
  ## Build the array of all the people
  for (my $i = 1; $i <= $config->{"TABLE_SIZE"} * $config->{"TABLE_COUNT"}; $i++) {
    # print("Adding Person #$i\n");
    push($peopleArray, $i);
  }
  
  
  STARTTRY: for (my $tries = 0; $tries < $config->{"TRY_COUNT"}; $tries++) {
    ## Start the whole try
    my $tableTry = {};
    $tableTry->{"Duplicates"} = 0;
    $tableTry->{"Sat with"} = {};
    $tableTry->{"Tables"} = {};
  
    ## Initialize the sat with array
    foreach my $person (@{$peopleArray}) {
      $tableTry->{"Sat with"}->{"$person"} = {};
      $tableTry->{"Tables"}->{"$person"} = [];
    }
  
  
    ## Here are the rounds:
    for (my $roundNumber = 1; $roundNumber <= $config->{"ROUNDS"}; $roundNumber++) {
      $tableTry->{"Round $roundNumber"} = {};
  
      ## Randomize the people list.
      my $randomList = dclone($peopleArray);
      my @randomListArray = shuffle(@{$randomList});
      $randomList = \@randomListArray;

      for (my $i = 1; $i <= $config->{"TABLE_COUNT"}; $i++) {
        ## This array will contain the people sitting at table $i
        my @tablePeopleArray = splice($randomList, 0, $config->{"TABLE_SIZE"});
        
        $tableTry->{"Round $roundNumber"}->{"Table $i"} = \@tablePeopleArray;
        foreach my $firstPerson (@tablePeopleArray) {
          if ( grep( /^Table #$i$/, @{$tableTry->{"Tables"}->{"$firstPerson"}} ) ) {
            $tableTry->{"Duplicates"} ++;
          }
          push($tableTry->{"Tables"}->{"$firstPerson"}, "Table #$i");
          
          foreach my $secondPerson (@tablePeopleArray) {
            $tableTry->{"Sat with"}->{"$firstPerson"}->{"$secondPerson"} = 1;
          }
        }
      }
      # print(Dumper($tableTry));
    }
  
    ## Now we need to calculate the average people that each person sat with.
    my $total = 0;
    my $count = 0;
    foreach my $personSatWith (keys $tableTry->{"Sat with"}) {
      $count++;
      $total += scalar(keys($tableTry->{"Sat with"}->{"$personSatWith"}));
    }
    $tableTry->{"Average"} = $total / $count;  
    
    
    ## Besting the Least Table
    if($theLeastDuplicates == "-1" || $tableTry->{"Duplicates"} < $theLeastDuplicates) {
      $theLeastDuplicates = $tableTry->{"Duplicates"};
      $theBest = $tableTry;
      # print(Dumper($tableTry));
    } elsif($tableTry->{"Duplicates"} == $theLeastDuplicates) {
      if($theBestAverage == "-1" || $tableTry->{"Average"} > $theBestAverage) {
        $theBestAverage = $tableTry->{"Average"};
        $theBest = $tableTry;
        # print(Dumper($tableTry));
      } else {
        print("Try #" . $tries . " - " . $tableTry->{"Average"} . " didn't beat average $theBestAverage\n");
      }    
    } else {
      print("Try #" . $tries . " - " . $tableTry->{"Duplicates"} . " didn't beat duplicates $theLeastDuplicates (best average $theBestAverage)\n");
    }


  }
  print(Dumper($theBest));

};

eval {
  $SIG{'INT'} = sub {print(Dumper($theBest));die;};
  main(@ARGV);
};

if($@) {
  print("Failed due to $@\n");
}



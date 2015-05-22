#!/usr/bin/perl

use strict;
use File::Basename;

parseAndRecurse(".",".");

sub parseAndRecurse($$) {
	my $currentDirectory = shift;
	my $directoryName = shift;
	my @mp3List = ();

	opendir(my $logdirfh, $currentDirectory);
	while(readdir $logdirfh) {
	    my $filename = $_;
	    if($filename ne "." && $filename ne "..") {
		    if (-d $filename) {
  			    # print("recursing: $currentDirectory/$filename\n");
  			    parseAndRecurse("$currentDirectory/$filename", $filename);
		    } elsif ($filename =~ /^(.*\.mp3)$/) {
		    	unshift(@mp3List, $filename);
		    }
	    }
	}
	closedir($logdirfh);
	
	if($#mp3List > 0) {
		open(my $fh, '>', "$currentDirectory/$directoryName.m3u");
		while($#mp3List > 0) {
		  my $songName = pop(@mp3List);
		  print($fh "$songName\n");
		}
		close($fh);
	}
}
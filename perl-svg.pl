#!/usr/bin/perl

use Modern::Perl;
use SVG;

# my $R = 1;
my $r;
my $p;
my $phi;
my $N=5;
my $M=1;
my $pixels = '512';
my $half = '256';

# create base SVG canvas;
my $svg = SVG->new(id => 'canvas', width => $pixels, height => $pixels);
my $image = $svg->group(id=>'image');

# See if we can get image
my $c = $image->circle(cx=>0, cy=>0, r=>100, transform=>"translate($half,$half)");

print $svg->xmlify;

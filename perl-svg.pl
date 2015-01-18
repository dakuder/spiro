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
my $xv = [-200, 0, 200, 0];
my $yv = [0, 200, 0, -200];
my $points = $image->get_path(x=>$xv, y=> $yv, -type=>'polygon');
my $c = $image->polygon(%$points, transform=>"translate($half, $half)");

print $svg->xmlify;

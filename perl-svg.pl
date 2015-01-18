#!/usr/bin/perl

use Modern::Perl;
use SVG;
use Math::Trig ':pi';

my $R = 128;
my $r;
my $p;
my $phi;
my $N;
my $M;
my $A;
my $step;
my $pixels = '512';
my $half = '256';
my $stroke_width;

# Hardcoded parameters
$N=5;
$M=1;
$r = ($M / $N)*$R;
$p = 2.2 * $r;
$phi = pi/20;
$A = 400;
$step=(2 * $N * pi)/$A;
my $sigma=($R-$r)/$r;
$stroke_width = 5;

# loop 
my @xs;
my @ys;

for(my $t=0; $t<(2 * $N * pi); $t = $t + $step) {
	my $x = ($R - $r) * cos($t) + $p * cos($sigma * $t + $phi);
	my $y = ($R - $r) * sin($t) - $p * sin($sigma * $t + $phi);
	push @xs, $x;
	push @ys, $y;
}
# create base SVG canvas;
my $svg = SVG->new(id => 'canvas', width => $pixels, height => $pixels);
my $image = $svg->group(id=>'image');

# convert array of points to svg polygon
my $points = $image->get_path(x=>\@xs, y=> \@ys, -type=>'polygon');
my $c = $image->polygon(transform=>"translate(256, 256)", style=>"stroke: black; fill: none; stroke-width: $stroke_width", %$points ); 

print $svg->xmlify;

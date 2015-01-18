#!/usr/bin/perl

use Modern::Perl;
use SVG;
use Math::Trig ':pi';

my $R = 100;
my $r;
my $p;
my $phi;
my $N;
my $M;
my $A;
my $step;
my $pixels = '512';
my $half = '256';

# Hardcoded parameters
$N=5;
$M=1;
$r = ($M / $N)*$R;
$p = $r;
$phi = 0;
$A = 200;
$step=(2 * $N * pi)/$A;
my $sigma=($R-$r)/$r;

# loop 
my @xs;
my @ys;

for(my $t=0; $t<(2 * $N * pi); $t = $t + $step) {
	my $x = ($R - $r) * cos($t) + $r * cos($sigma * $t);
	my $y = ($R - $r) * sin($t) - $r * sin($sigma * $t);
	push @xs, $x;
	push @ys, $y;
}
# create base SVG canvas;
my $svg = SVG->new(id => 'canvas', width => $pixels, height => $pixels);
my $image = $svg->group(id=>'image');

# convert array of points to svg polygon
my $points = $image->get_path(x=>\@xs, y=> \@ys, -type=>'polygon');
my $c = $image->polygon(transform=>"translate(256, 256)", style=>"stroke: black; fill: none;", %$points ); 

print $svg->xmlify;

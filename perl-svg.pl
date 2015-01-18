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
my $pen_color;
my $fill_color;

# Hardcoded parameters
$N=5;
$M=2;
$r = ($M / $N)*$R;
$p = 2.2 * $r;
$phi = pi/20;
$A = 50;
$step=(2 * pi)/$A;
my $sigma=($R-$r)/$r;
$stroke_width = 3;
$pen_color = "rgb(255, 100,100)";

# create base SVG canvas;
my $svg = SVG->new(id => 'canvas', width => $pixels, height => $pixels);
my $image = $svg->group(id=>'image');

# Outer loop, need to figure out how to input description
for(my $i = 0; $i<5; $i++) {
$p = (1+$i/2)* $r;
$phi = $i * pi/10;

# loop 
my @xs;
my @ys;

for(my $t=0; $t<(2 * pi * $M); $t = $t + $step) {
	my $x = ($R - $r) * cos($t) + $p * cos($sigma * $t + $phi);
	my $y = ($R - $r) * sin($t) - $p * sin($sigma * $t + $phi);
	push @xs, $x;
	push @ys, $y;
}

# convert array of points to svg polygon
my $points = $image->get_path(x=>\@xs, y=> \@ys, -type=>'polygon');
my $c = $image->polygon(transform=>"translate(256, 256)", style=>"stroke: $pen_color; fill: none; stroke-width: $stroke_width", %$points ); 
}
print $svg->xmlify;

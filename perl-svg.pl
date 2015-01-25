#!/usr/bin/perl

use Modern::Perl;
use SVG;
use Math::Trig ':pi';

sub gcd {
   my $t;
   my $a = shift;
   my $b = shift;
   while ($b > 0) {
     $t= $b;
     $b = $a % $b;
     $a = $t;
   };
   return $a;
};

my $R = 128;
my $r;
my $p;
my $phi;
my $NN;
my $MM;
my $A;
my $step;
my $pixels = '512';
my $half = '256';
my $stroke_width;
my $pen_color;
my $fill_color;
my $scale_x;
my $scale_y;
my $theta;
my $offset_x;
my $offset_y;

# Hardcoded parameters
$NN=11;
$MM=5;
# assuming N>M and N/2 > M;
my $f = gcd($NN, $MM);
my $N = $NN / $f;
my $M = $MM / $f;
$r = ($M / $N)*$R;
$p = 1 * $r;
$phi = pi/20;
$A = 150;
$step=(2 * pi)/$A;
my $sigma=($R-$r)/$r;
$stroke_width = 1;
$pen_color = "rgb(0, 0,0)";
$fill_color = "rgb(80,240,100)";

# create base SVG canvas;
my $svg = SVG->new(id => 'canvas', width => $pixels, height => $pixels);
my $image = $svg->group(id=>'image');

# Outer loop, need to figure out how to input description
for(my $i = 0; $i<4; $i++) {
$p = (1.4-$i/7)* $r;
# $phi = $i * pi/10;

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
my $c = $image->polygon(transform=>"translate(256, 256)", style=>"stroke: $pen_color; fill: $fill_color; stroke-width: $stroke_width", %$points ); 
}
print $svg->xmlify;

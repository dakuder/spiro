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
my $fill_opacity;
my $scale_x;
my $scale_y;
my $theta;
my $offset_x;
my $offset_y;

# create base SVG canvas;
my $svg = SVG->new(id => 'canvas', width => $pixels, height => $pixels);
my $image = $svg->group(id=>'image');

# Outer loop, reading parameters from a CSV
while(<>) {
    chomp;
    my @params = split(',');
    $R = $params[0];
print STDERR "R = $R\n";
    $NN = $params[1];
    $MM = $params[2];
# assuming N>M and N/2 > M;
    my $f = gcd($NN, $MM);
print STDERR "f = $f\n";
    my $N = $NN / $f;
    my $M = $MM / $f;
print STDERR "N = $N; M = $M\n";
    $r = ($M / $N)*$R;
print STDERR "r = $r\n";
    my $sigma=($R-$r)/$r;
    $p = $params[3];
    $p = $p * $r;
print STDERR "p=$p\n";
    $phi = $params[4];
print STDERR "phi = $phi\n";
    $A = $params[5];
print STDERR "A=$A\n";
    $step=(2 * pi)/$A;
    $stroke_width = $params[6];
print STDERR "stroke_width = $stroke_width\n";
    $pen_color = $params[7];
print STDERR "pen_color = $pen_color\n";
    $fill_color = $params[8];
print STDERR "fill_color = $fill_color\n";
    $fill_opacity = $params[9];
print STDERR "fill_opacity = $fill_opacity\n";
    $scale_x = $params[10];
print STDERR "scale_x = $scale_x\n";
    $scale_y = $params[11];
print STDERR "scaly_y = $scale_y\n";
    $theta = $params[12] * pi;
print STDERR "theta = $theta\n";
    $offset_x = $params[13];
    $offset_y = $params[14];
print STDERR "offset x,y = $offset_x, $offset_y\n";
    
# inner loop drawing a single hypocycloid or whater
    my @xs;
    my @ys;

    for(my $t=0; $t<(2 * pi * $M); $t = $t + $step) {
	    my $x = ($R - $r) * cos($t) + $p * cos($sigma * $t + $phi);
	    my $y = ($R - $r) * sin($t) - $p * sin($sigma * $t + $phi);

	    my $c = cos($theta);
	    my $s = sin($theta);
	    my $xt = $scale_x * $c* $x + $s * $y + $offset_x; 
	    my $yt = $scale_y * $c *$y - $s * $x + $offset_y; 

	    push @xs, $xt;
	    push @ys, $yt;
    }

# convert array of points to svg polygon
    my $points = $image->get_path(x=>\@xs, y=> \@ys, -type=>'polygon');
    my $c = $image->polygon(transform=>"translate(256, 256)", style=>"stroke: $pen_color; fill: $fill_color; fill-opacity: $fill_opacity; stroke-width: $stroke_width", %$points ); 
}
print $svg->xmlify;

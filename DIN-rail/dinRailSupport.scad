/*
**
** Support for DIN rail
**
** Base for Arduino & Raspberry Pi
**
** Copyright (c) 2015 finizi - domoenergytics.com
**
** Made use of "Arduino connectors library" (c) 2013 Kelly Egan
**
** Permission is hereby granted, free of charge, to any person obtaining a copy of this software 
** and associated documentation files (the "Software"), to deal in the Software without restriction, 
** including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
** and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do 
** so, subject to the following conditions:
**
** The above copyright notice and this permission notice shall be included in all copies or substantial
** portions of the Software.
**
** THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT 
** NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. 
** IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
** WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE 
** SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
**
*/



/* Samples
*/
include <arduino.scad>

//supportDIN(40);
//railDin(35);
//dinArduino();
//dinRaspberry1();




/* Module to draw a Raspberry Pi model 1 support with bumpers & holes
*/
module dinRaspberry1() {
  piWidth = 56.0;     // width of Pi board
  holeRadius = 2.85;  // hole radius por fixing screws
  decal = -17;        // offset
  bottomRadius = 6;
  topRadius = 2.5;
  bord = 25.0;        // extend base size
  ep = 4.0;           // base thickness
  $fn = 32;

  piHoles = [
    [ 12.5, 80.0 ],
    [ 38.0, 25.5 ]
    ];
  standHoles = concat(piHoles, 
    [ [ 46.0, 78.0 ],
      [ 12.0, 25.5 ]
    ]);

  // rotate o draw verticaly
  rotate([0, -90, 0]) difference() {
    union() {
      // Din rail
      translate([piWidth, 0, 0]) rotate([-90, 0, 90]) supportDIN(piWidth);
      // bumper
      translate([0, decal, 0]) piHolePlacement(standHoles) cylinder(r1=bottomRadius, r2=topRadius, h = 5);	
      // extend the base
      translate([0, -bord, -ep]) cube([piWidth, bord+0.1, ep]);
    }
    union() {
      // Holes for screws
      translate([0, decal, -10]) piHolePlacement(piHoles) cylinder(d=holeRadius, h = 30);	
      // To cut the edges
      translate([0, 67, -10]) cube([piWidth, 10, 20]);
    }
  }

  module piHolePlacement(places) {
    for(i = places ) {
      translate(i) children(0);
    }
  }
}




/* Module to draw an Arduino support with stand & holes
*/
module dinArduino() { 
  $fn = 32;
  // rotate to draw verticaly
  rotate([0, -90, 0]) difference() {
    union() {
      // Din rail
      translate([ngWidth, 0, 1]) rotate([-90, 0, 90]) supportDIN(ngWidth);
      // bumper
      translate([0, -5, 0]) standoffs(UNO, height=4, bottomRadius=6, topRadius=2.5);
    }
    union() {
      // screw hole
      translate([0, -5, -10]) {
        holePlacement(boardType=UNO) cylinder(r = mountingHoleRadius, h = 30);	
      }
      // To cut the edges
      translate([-10, 0, -5]) cube([10, 70, 20]);
      translate([ngWidth, 0, -5]) cube([10, 70, 20]);
    }
  }
}




/* Module to draw base support
*/
module supportDIN(haut) {
  eor = 4.0;   // thickness above the rail
  er = 1.1;    // rail thickness
  wr = 35.0;   // rail width
  cran = 2.5;  // step thickness
  dx = 16.0;   // spring diameter
  ex = 1.2;    // spring thickness
  cong = 0.35; // spring trailing space
  clips = 1.2; // clips size 
  ergot = 3.2; // pin size
  a = (er+cran-cong*2)/2; // anti-snatching tab thickness
  $fn = 32;

  linear_extrude(height = haut) {
    // base design
    polygon(points=[
      [0, 0],
      [0, eor+er+cran],
      [dx, eor+er+cran],
      [dx+clips, eor+er],
      [dx, eor+er],
      [dx, eor],
      [dx+wr+clips*ergot+ex+cong, eor],
      [dx+wr+clips*ergot+ex+cong, eor+er+cran],
      [dx*2+wr, eor+er+cran],
      [dx*2+wr, 0]
    ]);
    // clips design
    polygon(points=[
      [dx+wr, eor+cong],
      [dx+wr+ex, eor+cong],
      [dx+wr+ex, eor+er+cran],
      [dx+wr, eor+er+cran],
      [dx+wr-clips, eor+er],
      [dx+wr, eor+er]
    ]);
    // anti-snatching tab
    translate([dx+wr+cong+ex+clips, eor+er+cran-a]) square([clips*(ergot+1), a]);
    // tab at the end of spring
    translate([dx+wr, eor+cong]) square([clips*(ergot-1)+ex, a]);
    // sprin
    difference() { 
      union() {
        // inner circle
        translate([dx+wr+dx/2, eor+er+cran]) circle(d=dx);
      }
      union() {  
        // outer circle
        translate([dx+wr+dx/2, eor+er+cran]) circle(d=dx-ex*2);
        // gap between the spring and base
        translate([dx, eor]) square([wr+clips*4, cong]);
        // To truncate the circle under the base
        translate([0, -dx]) square([wr+dx*2, dx]);
      }
    }
  }
}




/* module to draw a DIN rail (not used)
*/
module railDin(len) {
  outerW = 35.0;
  innerW = 25.0;
  outerH = 7.5;
  Ep = 1.0;
  dec = (outerW-innerW)/2;
  linear_extrude(height = len) {
    translate([0, -Ep, 0]) square([dec, Ep]);
    translate([dec-Ep, -outerH, 0]) square([Ep, outerH]);
    translate([dec, -outerH, 0]) square([innerW, Ep]);
    translate([outerW-dec, -outerH, 0]) square([Ep, outerH]);
    translate([outerW-dec, -Ep, 0]) square([dec, Ep]);
  }
}

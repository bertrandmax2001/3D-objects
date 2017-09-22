/*
**  ePaperBox
*/

ssw = 32.0;       // Screen Size Width
bsw = 33.5;       // Board Size Width
bsh = 48.5;       // Board Size Height
fst = 0.35;       // Front Side Thikness
tss = 5.8;        // Top Side Screen
wt = 2.5;         // Wall Thickness
ot = 9.0;         // Overall Thickness
ra = 1.0;         // Rail
sbt = 2.9;        // Screen + Board Thickness
j = 0.1;          // Adjustment clearance
bt = 1.2;         // Back Thikness
ht = 0.9;         // Holder Thickness
mh = 80.0;        // Max Height (with holder)
fw = 15.0;        // Finger Width
fc = 2.0;         // Finger Cut
fl = 20.0;        // Finger Length
fh = 6.0;         // Finger Top
ew = 26.0;        // Electronic Width

use<Cubo.scad>;

module frontSide () {
  difference() {
    union() {
      cube([bsw+wt*2, bsh+wt, ot]);
    }
    union() {
      translate([wt, wt, fst]) cube([bsw, bsh*2, ot]);
      translate([wt+(bsw-ssw)/2, wt+tss, 0]) cube([ssw, ssw, ot]);
      backSide();
    }
  }
}

module backSide() {
  difference() {
    union() {
      // Bevel
      translate([wt-ra, wt-ra, fst+sbt]) cubo([bsw+ra*2, bsh*2, ra], [2,7,8], ra*1.41);
      // Filling
      translate([wt+j, wt+j, fst+sbt+ra]) cube([bsw-j*2, bsh*2, ot-sbt-ra+bt-fst+j]);
      // Back
      translate([0, bsh+wt*2+j-mh, ot+j]) cubo([bsw+wt*2, mh, bt], [9,12], 2);
      // fermeture
      translate([0, bsh+wt+j, 0]) cube([bsw+wt*2, wt, ot+j+bt]);
    }
    union() {
      // To refine the clip
      translate([0, -mh, 0]) cube([bsw+wt*2, mh, ot+j+bt-ht]);
      // To cut out what's overflowing
      translate([0, bsh+wt*2+j, 0]) cube([mh, mh, mh]);
      // Finger Slot
      translate([(bsw+wt*2-fw)/2, -fh, bt*2]) cube([fw, fc*2, ot]);
      translate([(bsw+wt*2-fw)/2, -fh-fl+fc*2, bt*2]) cube([fc, fl, ot]);
      translate([(bsw+wt*2+fw)/2-fc, -fh-fl+fc*2, bt*2]) cube([fc, fl, ot]);
      // Place for electronics
      translate([(bsw+wt*2-ew)/2, 0, 0]) cube([ew, bsh, sbt+ra+ot-sbt-ra+j]);
    }
  }
  // Finger
  translate([(bsw+wt*2-fw)/2+fc, -fh-fc*3, ot+j+bt-ht]) cubo([fw-fc*2, fc*4, ht], [10,11], 2);
}


module All() {
  frontSide();
  translate([-5, 0, ot+j+bt]) rotate([0, 180, 0]) backSide();
}

All();
//backSide();

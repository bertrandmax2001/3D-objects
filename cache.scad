/* 
**
** Cache boitier DIN
**
** 0.3; 0.35
** 100%; rectilinear; fill angle = 0
** filament diametre = 2.2
** 210; 210
** 75; 55
*/

wElem = 8.96;  // 8.74 auparavant
               // 1 module = 17,9 mm
hElem = 52;
hHole = 46.6;
eElem = 0.65;
wRay = 0.85;
hRay = 3.5;
hTop = 2;
grip = 0.5;
eCase = 2.5;

// Appel de la fonction principale, en indiquant le nombre d'éléments
cacheDIN(7);


module cacheDIN(nElem) {
  x = (hElem-hHole)/2+hTop+hRay;
  m = (wElem-wRay)/2-wRay;
  for (n = [0 : nElem-1]) {
    translate([n*wElem, 0, 0]) difference() {
      union() {
        // plaque de base
        cube([wElem, hElem, eElem]);
        // arrête de maintient
        translate([(wElem-wRay)/2, (hElem-hHole)/2, eElem]) cube([wRay, hHole, hRay]);
        translate([(wElem-wRay)/2, (hElem-hHole)/2-grip, eElem+eCase]) cube([wRay, hHole+grip*2, hRay-eCase]);
      }
      union() {
        for (i = [0, 1]) {
          translate([i*wElem, 0, eElem*1.2]) rotate([-90, 0, 0]) cylinder(d=eElem*2, h=hElem, $fn=4);
        }
        // creux dans l'arrête de maintient
        hull() {  
          translate([m, x, hRay+eElem]) rotate([0, 90, 0]) cylinder(d=hRay*2, h=wRay*3, $fn=4);
          translate([m, hElem-x, hRay+eElem]) rotate([0, 90, 0]) cylinder(d=hRay*2, h=wRay*3, $fn=4);
        }
      }
    }
  }
}


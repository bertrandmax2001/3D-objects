// -----------------
// module cubo
// GPL v2.0
// yvoz.lg@gmail.com
// -----------------

cubo([10,10,5], [1,2,3,4,5,6,7,8,9,10,11,12], 1.5);

translate([15, 0, 0]){
	difference(){
		cubo([10,20,5], [2,3], 3);
		translate([5,10,-1]) cylinder(r=2, h=7, $fn=12);
	}
}

translate([-15, 0, 0]){
	difference(){
		cube([10,20,15]);
		translate([3,3,3]) cubo([10,20,50], [1,5], 3);
	}
}

module cubo(dim, cro, a){

	diago = sqrt(pow(a,2)+pow(a,2));
	difference(){
		cube(dim);
		
		for(i=cro){
			//x
			if(i==1){
				translate([-1, 0, -diago/2])
				rotate([45, 0, 0])
				cube([dim.x+2, a, a]);
			}
			if(i==2){
				translate([-1, 0, dim.z-diago/2])
				rotate([45, 0, 0])
				cube([dim.x+2, a, a]);
			}
			if(i==3){
				translate([-1, dim.y, dim.z-diago/2])
				rotate([45, 0, 0])
				cube([dim.x+2, a, a]);
			}
			if(i==4){
				translate([-1, dim.y, -diago/2])
				rotate([45, 0, 0])
				cube([dim.x+2, a, a]);
			}
			//y
			if(i==5){
				translate([-diago/2, -1, 0])
				rotate([0, 45, 0])
				cube([a, dim.y+2, a]);
			}
			if(i==6){
				translate([dim.x-diago/2, -1, 0])
				rotate([0, 45, 0])
				cube([a, dim.y+2, a]);
			}
			if(i==7){
				translate([dim.x-diago/2, -1, dim.z])
				rotate([0, 45, 0])
				cube([a, dim.y+2, a]);
			}
			if(i==8){
				translate([-diago/2, -1, dim.z])
				rotate([0, 45, 0])
				cube([a, dim.y+2, a]);
			}
			//z
			if(i==9){
				translate([0, -diago/2, -1])
				rotate([0, 0, 45])
				cube([a, a, dim.z+2]);
			}
			if(i==10){
				translate([0, dim.y-diago/2, -1])
				rotate([0, 0, 45])
				cube([a, a, dim.z+2]);
			}
			if(i==11){
				translate([dim.x, dim.y-diago/2, -1])
				rotate([0, 0, 45])
				cube([a, a, dim.z+2]);
			}
			if(i==12){
				translate([dim.x, -diago/2, -1])
				rotate([0, 0, 45])
				cube([a, a, dim.z+2]);
			}
		}
	}
}





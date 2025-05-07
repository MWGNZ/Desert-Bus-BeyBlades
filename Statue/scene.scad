include <stadium.scad>
include <statue.scad>

module the_ground() {
	color("LimeGreen"){
		translate([0,0,-1]) {
			cube([10000,10000,2], true);
		}
	}
}

translate([1000,0,0])
	statue_and_plinth();

stadium();
the_ground();
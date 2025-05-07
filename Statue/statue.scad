$fn=200;

module leg_split() {
	cube(10, true);
}

module centredrotate(a, orig) {
	translate(orig)
		rotate(a)
			translate(-orig)
				children();
}

module legparts() {
	//shin
	intersection() {
		resize([4.5,6,11]) cylinder(h=10, r1=2, r2=3);
		leg_split();
	}
	//thigh
	centredrotate([-90,0,0],[0,0,5]) {
		difference() {
			resize([4.5,6,11]) cylinder(h=10, r1=2, r2=3);
			leg_split();
		}
	}
	//butt
	translate([0,5.9,5]) {
		resize([4.5,5.9,5.999]) sphere(1);
	}
	foot();
}

module leg() {
	rotate([10,0,0]) {
		centredrotate([0,0,25],[0,0,0]) {
			legparts();
			//knee
			hull() {
				union() {
					intersection() {
						legparts();
						translate([0,-1.999,6.999])
							rotate([0,0,0])
								cube([6,4,4], true);
					}
					translate([0,-1,5.7])
						sphere(d=3);
				}
			}
		}
	}
}

module legs() {
	translate([4.5,-4,0]) {
		leg();
	}
	mirror([1,0,0]) {
		translate([4.5,-4,0]) {
			leg();
		}
	}
}

module foot() {
	translate([0,0,-.5])
		rotate([-10,0,0]) {
			intersection() {
				union() {
					rotate([90,0,0])
						cylinder(h=3, r=2);
					translate([0,-3,0])
						sphere(r=2);
					sphere(r=2);
				}
				translate([0,0,5])
					cube(10, true);
			}
		}
}

module arm() {
	centredrotate([-120,0,0],[0,0,10]) {
		translate([0,0,10])
			sphere(r=2.5);
		translate([0,0,3])
			cylinder(h=7, r1=2, r2=2.5);
		rotate([0,20,80])
			translate([-1,0,2.5])
				rotate([0,-25,0])
					resize([2,4,6])
						sphere(r=2.5);
	}
}

module arms() {
	translate([-5,1,6])
		arm();
	mirror([1,0,0])
		translate([-5,1,6])
			arm();
}

module bodyarm() {
	translate([0,0,10]) {
		rotate([0,90,0])
			cylinder(h=5, r1=2.5, r2=3);
	}
}

module body() {
	translate([0,0,-4]) {
		hull() {
			translate([-5,1,10]) {
				bodyarm();
			}
			mirror([1,0,0]) {
				translate([-5,1,10])
					bodyarm();
			}
			translate([0,0,14]) {
				intersection() {
					translate([0,0,7.7]) {
						cube(20, true);
					}
					resize(newsize=[10,8,18]) {
						sphere(r=10);
						translate([0,0,-2.5]) {
							cylinder(h=1, r1=12, r2=12);
						}
					}
				}
			}
			translate([1.5,-7.4,-.7]) {
				centredrotate([40,0,0],[0,0,10]) {
					translate([0,5.9,5]) {
						resize([4.5,5.9,5.999]) sphere(1);
					}
				}
			}
			mirror([1,0,0]) {
				translate([1.5,-7.4,-.7]) {
					centredrotate([40,0,0],[0,0,10]) {
						translate([0,5.9,5]) {
							resize([4.5,5.9,5.999]) sphere(1);
						}
					}
				}
			}
		}
	}
}

module head() {
	translate([0,-7,-2]) {
		translate([0,0,-4]) {
			translate([0,0,26]) {
				resize(newsize=[6,7,8]) sphere(r=10);
			}
		}
	glasses_rectangle();
	}
}


module glasses_rectangle() {
	translate([0,-4,22.5]) {
		glass_rectangle();
		mirror([1,0,0]) glass_rectangle();
	}
}

module glass_rectangle() {
	translate([-3,.5,0]) {
		cube([3,5,.5]);
		cube([3,.5,.5]);
		translate([.5,0,-1]) {
			cube([2,.5,1.5]);
		}
	}
}

module statue() {
	translate([0,12,0]) {
		scale(2.5) {
			translate([0,-3,-.7]) {
				centredrotate([40,0,0],[0,0,10]) {
					body();
					arms();
				}
			}
			legs();
			head();
		}
	}
}

module plinth() {
	translate([0,0,-8])
		cylinder(8,29,29);

	translate([0,0,-70])
		cylinder(10,30,30);

	difference(){
	translate([0,0,-60])
		cylinder(60,28,28);
	translate([0,0,-30])
		for (i=[0:45:359]) {
			r = 33; // pattern radius
			n = 20; // number of cars
			step = 360/n;
			for (i=[0:step:359]) {
				angle = i;
				dx = r*cos(angle);
				dy = r*sin(angle);
				translate([dx,dy,1])
				rotate([0,0,angle]){
					cylinder(80,8,8,center = true);
				}
			}
		}
	}
}

module statue_and_plinth() {
	rotate([0,0,90]) {
		translate([0,0,70]) {
			statue();
			plinth();
		}
	}
}

statue_and_plinth();
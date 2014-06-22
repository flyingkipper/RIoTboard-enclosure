// An enclosure for the RIoTboard SBC.
//  
//
// Uncomment the required part for printing
// Two part enclosure is just top and base
// Three part is lid, middle and base

// TOP
//rotate([180,0,0]) box_top();

// BASE
//box_base();

// MIDDLE
//rotate([180,0,0]) box_middle();

// LID
//rotate([180,0,0]) box_lid();


// 
//riotboard();
all();

module all() {
	translate([0,0,5])	box_lid();
								box_middle();
	translate([0,0,-5])	box_base();
}


$fn=30;

box_len=127;
box_wid=82;
box_ht=32;
thickness=3.5;
lid_ht=6;
box_ins_len=box_len-thickness*2;
box_ins_wid=box_wid-thickness*2;
box_ins_ht=box_ht-thickness-1;

PCB_len=120;
PCB_wid=75;
PCB_thickness=1.6;
PCB_location=9;

vent_hole_r=2;
vent_hole_spacing=(vent_hole_r * 2) + 1;
vent_length_x=83;
vent_length_y=48;
vent_depth=thickness+2;


module	vent_holes() {
	for(j=[0:vent_hole_spacing:vent_length_y])
		for(i=[0:vent_hole_spacing:vent_length_x]) {
			assign( i=i + (((j+vent_hole_spacing) / vent_hole_spacing + 1) % 2) * vent_hole_r)
			if(i < vent_length_x - vent_hole_spacing/2)
				translate([i, j, 0]) rotate([0,0,30]) cylinder(r=vent_hole_r, h=vent_depth, $fn=6 );
		}
}


// This module is used to create the holes and voids for the SBC
//
module riotboard() {
// pcb
	translate([-0.5,-0.5,-0.2])	cube([PCB_len+1,PCB_wid+1,PCB_thickness+0.4]);
// S1 Reset button
		translate([9.5,-2,PCB_thickness])	cube([8.5,3,7.5]);	
		translate([11,-6,PCB_thickness])		cube([5,8,5.5-PCB_thickness]);	
		translate([13.5,-6,5.5]) rotate([-90,0,0]) cylinder(r=2.5, h=6);
// J5 Audio OUT
		translate([23,-6,9]) rotate([-90,0,0]) cylinder(r=3.5, h=8);
		translate([19.5,-6,PCB_thickness])  cube([16,7,9]);
// J4 Microphone IN
		translate([32,-6,9]) rotate([-90,0,0]) cylinder(r=3.5, h=8);
// J3 HDMI
	hull() {
		translate([40,-1,PCB_thickness])	cube([16,2,6.5]);
		translate([38,-6,0])	cube([20,1,6.5+PCB_thickness*2]);
	}
// J2 LVDS
	hull() {
		translate([64,-1,PCB_thickness])	cube([12,2,4]);
		translate([62,-6,0])	cube([16,1,4+PCB_thickness*2]);
	}
// uncommect these to create slots for flat ribbon cables
// J9 Camera
//	translate([78,-2,PCB_thickness])		cube([20,6,3]);
// J8 CSI
//	translate([85,-2,-3])					cube([13,6,6]);
//	translate([85,-2,-3])					cube([15,6,3.1+PCB_thickness]);

// J14 SDA
// To remove change the first translate below to ([101,1.5,PCB_thickness])
	hull() {
		translate([101,-1,PCB_thickness])	cube([9.5,2,4]);
		translate([99,-6,0])	cube([13.5,2,4+PCB_thickness*2]);
	}
// USB HUB2
	hull() {
		translate([-6,6,0])	cube([1,21,17+PCB_thickness*2]);
		translate([-1,8,PCB_thickness])	cube([2,22,17]);
	}
// USB HUB1
	hull() {
		translate([-6,27,0])	cube([1,21,17+PCB_thickness*2]);
		translate([-1,29,PCB_thickness])	cube([2,17,17]);
	}
// J15 Ethernet
	hull() {
		translate([-6,47,0])	cube([1,22,15+PCB_thickness*2]);
		translate([-1,46,PCB_thickness])	cube([2,21,15]);
	}
// J11 USB OTG
	hull() {
		translate([23,74,PCB_thickness])	cube([9.5,2,4]);
		translate([21,80,0])	cube([13.5,1,4+PCB_thickness*2]);
	}
// J7 uSD
	hull() {
		translate([39,74,PCB_thickness])	cube([13,2,3]);
		translate([37,80,0])	cube([17,1,3+PCB_thickness*2]);
	}
// J6 SD
	hull() {
		translate([38,74,-4])	cube([28,2,4.1+PCB_thickness]);
		translate([36,80,-(3+PCB_thickness)])	cube([32,1,3+PCB_thickness*2]);
	}
// J1 Power 
	hull() {
		translate([120,51,PCB_thickness])	cube([2,11,12]);
		translate([126,49,0])	cube([1,15,12+PCB_thickness*2]);
	}
// J18 Serial debug console (cut a notch in the side of the case with two narrow grooves
// 	to take a small blanking plug (yet to be designed)
	translate([8,68,PCB_thickness])	cube([10,15,25]);
	translate([8,76,PCB_thickness])	cylinder(r=0.5, h=25);
	translate([18,76,PCB_thickness])	cylinder(r=0.5, h=25);
// LEDS
	translate([117.5,29,PCB_thickness])	cylinder(r=1.1, h=box_ht);
	translate([117.5,36,PCB_thickness])	cylinder(r=1.1, h=box_ht);
	translate([117.5,42.5,PCB_thickness])	cylinder(r=1.1, h=box_ht);
	translate([117.5,48.5,PCB_thickness])	cylinder(r=1.1, h=box_ht);
}



module box() {
	difference() {
// Solid box with rounded edges
		translate([-thickness,-thickness,0])	rounded_box(box_len,box_wid,box_ht,thickness); 
// Hollow out
		translate([0,0,thickness])	cube([box_ins_len,box_ins_wid,box_ins_ht]);					
// Vent holes
		translate([30,10,box_ht-thickness-1]) 	vent_holes();							
	}
// Now add back some internal structures
// Corner screw posts
	translate([4,4,2.5])		cylinder(r=4,h=28.5);
	translate([116,4,2.5])	cylinder(r=4,h=28.5);
	translate([4,71,2.5])	cylinder(r=4,h=28.5);
	translate([116,71,2.5])	cylinder(r=4,h=28.5);
// Larger base for screw head support
	translate([4,4,2.5])		cylinder(r1=6,r2=4,h=5);
	translate([116,4,2.5])	cylinder(r1=6,r2=4,h=5);
	translate([4,71,2.5])	cylinder(r1=6,r2=4,h=5);
	translate([116,71,2.5])	cylinder(r1=6,r2=4,h=5);
// Fill in some gaps
	translate([0,0,2.5])		cube([5,8,28.5]);
	translate([0,0,2.5])		cube([8,5,28.5]);
	translate([115,0,2.5])	cube([5,8,28.5]);
	translate([112,0,2.5])	cube([8,5,28.5]);
	translate([0,67,2.5])	cube([5,8,28.5]);
	translate([0,70,2.5])	cube([8,5,28.5]);
	translate([115,67,2.5])	cube([5,8,28.5]);
	translate([112,70,2.5])	cube([8,5,28.5]);
// LED light guide block 
	translate([113,24,PCB_location+5])	cube([9,27,16]);
// Console port
	translate([6,67,11])		cube([2,8,20]);
	translate([18,67,11])	cube([2,8,20]);
	translate([0,67,11])		cube([18,1,20]);
}


module box_base() {
	difference() {
		box();
		translate([0,0,PCB_location])		riotboard();
// Chop off the top
		translate([-5,-5,PCB_location+PCB_thickness])	cube([box_len+10,box_wid+10,box_ht]);
// Base M3 clear
		translate([4,4,0])			cylinder(r=1.6, h=PCB_location);
		translate([116,4,0])			cylinder(r=1.6, h=PCB_location);
		translate([4,71,0])			cylinder(r=1.6, h=PCB_location);
		translate([116,71,0])		cylinder(r=1.6, h=PCB_location);
// base M3 csk
		translate([4,4,-0.5])		cylinder(r=3.1,h=1.5);
		translate([116,4,-0.5])		cylinder(r=3.1,h=1.5);
		translate([4,71,-0.5])		cylinder(r=3.1,h=1.5);
		translate([116,71,-0.5])	cylinder(r=3.1,h=1.5);
		translate([4,4,1])			cylinder(r1=3.1,r2=1.6,h=1.5);
		translate([116,4,1])			cylinder(r1=3.1,r2=1.6,h=1.5);
		translate([4,71,1])			cylinder(r1=3.1,r2=1.6,h=1.5);
		translate([116,71,1])		cylinder(r1=3.1,r2=1.6,h=1.5);
	}
}


module box_top() {
	difference() {
		box();
		translate([0,0,PCB_location])			riotboard();
// Chop off base
		translate([-5,-5,-1])	cube([box_len+10,box_wid+10,PCB_location+PCB_thickness+1.1]);
// M3 tap
		translate([4,4,PCB_location])			cylinder(r=1.3, h=box_ht-3);
		translate([116,4,PCB_location])		cylinder(r=1.3, h=box_ht-3);
		translate([4,71,PCB_location])		cylinder(r=1.3, h=box_ht-3);
		translate([116,71,PCB_location])		cylinder(r=1.3, h=box_ht-3);

	}
}

module box_lid() {
	difference() {
		box();
		translate([0,0,PCB_location])			riotboard();
		translate([-5,-5,-1])	cube([box_len+10,box_wid+10,box_ht-lid_ht+1]);
// Lid M3 clear
		translate([4,4,box_ht-lid_ht])		cylinder(r=1.6, h=lid_ht);
		translate([116,4,box_ht-lid_ht])		cylinder(r=1.6, h=lid_ht);
		translate([4,71,box_ht-lid_ht])		cylinder(r=1.6, h=lid_ht);
		translate([116,71,box_ht-lid_ht])	cylinder(r=1.6, h=lid_ht);
// Lid M3 csk
		translate([4,4,box_ht-2.5])			cylinder(r1=1.6,r2=3.1,h=1.5);
		translate([116,4,box_ht-2.5])			cylinder(r1=1.6,r2=3.1,h=1.5);
		translate([4,71,box_ht-2.5])			cylinder(r1=1.6,r2=3.1,h=1.5);
		translate([116,71,box_ht-2.5])		cylinder(r1=1.6,r2=3.1,h=1.5);
		translate([4,4,box_ht-1])				cylinder(r=3.1,h=1);
		translate([116,4,box_ht-1])			cylinder(r=3.1,h=1);
		translate([4,71,box_ht-1])				cylinder(r=3.1,h=1);
		translate([116,71,box_ht-1])			cylinder(r=3.1,h=1);
// Leds light guide, conical hole to make it easy to slide onto optical fibre
		translate([117.5,29,box_ht-lid_ht])		cylinder(r1=2,r2=1.1, h=lid_ht-0.5);
		translate([117.5,36,box_ht-lid_ht])		cylinder(r1=2,r2=1.1, h=lid_ht-0.5);
		translate([117.5,42.5,box_ht-lid_ht])	cylinder(r1=2,r2=1.1, h=lid_ht-0.5);
		translate([117.5,48.5,box_ht-lid_ht])	cylinder(r1=2,r2=1.1, h=lid_ht-0.5);
	}
}

module box_middle() {
	difference() {
		box();
		translate([0,0,PCB_location])			riotboard();
	// Chop off the base
		translate([-5,-5,-1])					cube([box_len+10, box_wid+10, PCB_location+PCB_thickness+1.1]);
	// Chop off the top
		translate([-5,-5,box_ht-lid_ht])		cube([box_len+10,box_wid+10,lid_ht+1]);
	// M3 tap holes
		translate([4,4,PCB_location])			cylinder(r=1.3, h=box_ht);
		translate([116,4,PCB_location])		cylinder(r=1.3, h=box_ht);
		translate([4,71,PCB_location])		cylinder(r=1.3, h=box_ht);
		translate([116,71,PCB_location])		cylinder(r=1.3, h=box_ht);
	}			
}

// One of many ways of producing a rounded edge box, may not be tha fastest.
//
module rounded_box(lx,ly,lz,r) 
{
	hull() {
		translate([r,r,r])				sphere(r);
		translate([r,ly-r,r])			sphere(r);
		translate([r,r,lz-r])			sphere(r);
		translate([r,ly-r,lz-r])		sphere(r);
		translate([lx-r,r,r])			sphere(r);
		translate([lx-r,ly-r,r])		sphere(r);
		translate([lx-r,r,lz-r])		sphere(r);
		translate([lx-r,ly-r,lz-r])	sphere(r);
	}
}


name = "Your Name";
code    = "0123456890123";

name_font = "Liberation Sans:style=Bold";
name_size = 9;
name_margin = 5;

code_font = "Libre Barcode EAN13 Text:style=Regular";
code_size = 36;
code_margin = 5;

margin_v = 5.0;
margin_h = 6.0;

// Layer hight and derived valuse
layer = 0.2;
thickness = 4;
recess = 1;

// Radius of the card corners
corner = 3.0;

// Diameter of the punchhole
punchhole = 5.0;

// Reduction of size in first and last layer to counte elephan foot
// problem and give the card a nice round corner
elephant = 0.15;

// Size of the card
card_w = 85.60;
card_h = 53.98;

$fn = 32;

use <fonts/name.ttf>;
use <fonts/code.ttf>;

module rounded_rect2d(w, h, r) {
    offset(r=r)
        offset(delta=-r)
            square([w, h], center=true);
}

difference() { 
    union() {
        linear_extrude(height=layer)
            offset(delta=-elephant)
                rounded_rect2d(card_w, card_h, max(0, corner - elephant));
        
        translate([0, 0, layer])
            linear_extrude(height=layer * (thickness - 2))
                rounded_rect2d(card_w, card_h, corner);
        
        translate([0, 0, layer * (thickness - 1)])
            linear_extrude(height=layer)
                offset(delta=-elephant)
                    rounded_rect2d(card_w, card_h, max(0, corner - elephant));
    }
    
    translate([-card_w / 2 + corner + 2, card_h / 2 - corner - 2, 0])
        cylinder(h=thickness * 2, d=punchhole, center=true);

    
    translate([0, 0, thickness * layer])
        linear_extrude(height=recess * layer * 2, center=true)
            text(
                code,
                size=code_size,
                font=code_font,
                halign="center",
                valign="center",
                direction="ltr",
                spacing=1.0
            );
    
    translate([0, name_margin, 0])
        rotate([0, 180, 0])
        linear_extrude(height=recess * layer * 2, center=true)
            import("logo.svg", center=true, dpi=50);
    
    translate([0, -card_h / 2 + name_margin, 0])
        rotate([0, 180, 0])
        linear_extrude(height=recess * layer * 2, center=true)
            text(
                name,
                size=name_size,
                font=name_font,
                halign="center",
                valign="baseline",
                direction="ltr",
                spacing=1.0
            );
}

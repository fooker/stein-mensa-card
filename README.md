# Mensa Card generator
The mensa at https://stein.schul use EAN-13 bar codes as mensa cards.
This generator builds a chip-card sized model to be 3D-printed which contains the student code, the name and the logo.


## Generate the card
Edit the [card.scad](./card.scad) file and enter your name and code on top of the file.

One can fire up `openscad -o card.stl card.scad` to generate the model or use the provided nix package:
```bash
nix build
```
and print the resulting `result/card.stl`.


## How to print
Slice the resulting model using a layer hight of 0.2mm.

Add a filament change after the first and before the last layer.
This will print the bottom and topmost layer with different colors.
As the text and code is resessed a little bit, the inner color will be visible as text color.

Use a white color for the outer layers and a black one for the inner layers to improve readability.


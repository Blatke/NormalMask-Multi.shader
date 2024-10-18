# NormalMask-Multi.shader
A Unity shader that supports 5 normal masks to affect the display of the normal map.

Each mask has 3 channels (RBG) to decide whether the corresponding parts on the normal map to show bump effect. So, we can have 5 * 3 = 15 different parts in total to affect the display of the normal map.

I plan to use this shader in some circumstance such as on tight clothes. When rotating an arm, the masks can let the normal map show some wrinkles on the elbow with other parts of the normal map still hidding. If you have a script to link the parameters of this shader with the rotation of the joints, those wrinkles can be automatically driven by the character's movements.

## List of Properties
### Main
#### Color
Tint color that blends with the color of the main texture.

White by default.
#### Albedo
Main texture as an RGB image.

White by default.
#### OMS
An RGB texture for occlusion (red), metallic (green) and smoothness (blue).

White by default.
#### Occlusion
#### Metallic
#### Smoothness
#### Normal Map
Normal texture to show bump effect.
#### Normal Strength
Intensity that the normal map exerts influence.
#### Detail Normal Map
Another normal texture to show bump effect and blend with the normal map.
#### Detail Normal Strength
Intensity that the detail normal map exerts influence.
### Normal Mask 1
#### Normal Map Mask 1
An RGB texture on which the parts with the values in the red, green or blue channels repectively indicates what corresponding parts of the NORMAL map (NOT the detail normal map) to show. 

Like the texture below used as a normal mask:

![未命名-6](https://github.com/user-attachments/assets/d64a786e-7418-40be-91f9-a3bd8c8dd991)

It lets the normal map show bump effect according to its red, green and blue parts, and nothing on its black parts (see the right cube; the left one is without the mask).

![image](https://github.com/user-attachments/assets/66fe6c01-cff3-4fef-bd3e-5212a21123e9)

This mask texture slot is white by default that it lets the normal map display effect if there is no image imported in it.
#### Mask 1 Red Strength
Intensity that the red part of the mask affects the normal map.
#### Mask 1 Green Strength
Intensity that the green part of the mask affects the normal map.
#### Mask 1 Blue Strength
Intensity that the blue part of the mask affects the normal map.

For instance, I reduced the Blue Strength to 0 without adjusting the values in the Red and Green Strengths:

![image](https://github.com/user-attachments/assets/6fad14d7-a9da-4b38-bded-a5042d5388b8)

### Normal Map Mask 2
### Normal Map Mask 3
### Normal Map Mask 4
### Normal Map Mask 5
The properties from Normal Map Mask 2 to Normal Map Mask 5 are similar to Normal Map Mask 1 except that the mask texture slots here are black by default.

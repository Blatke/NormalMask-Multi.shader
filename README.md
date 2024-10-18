# NormalMask-Multi.shader
A Unity shader that supports 5 normal masks to affect the display of the normal map.

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
An RGB texture on which the parts with the values in the red, green or blue channels repectively indicates what corresponding parts of the NORMAL map (not the detail normal map) to show. 

Like the texture below used as a normal mask:

![未命名-6](https://github.com/user-attachments/assets/d64a786e-7418-40be-91f9-a3bd8c8dd991)

It lets the normal map show bump effect according to its red, green and blue parts, and nothing on its black parts (see the right cube; the left one is without the mask).

![image](https://github.com/user-attachments/assets/66fe6c01-cff3-4fef-bd3e-5212a21123e9)

# NormalMask-Multi.shader
A Unity shader that supports 5 normal masks to affect the display of the normal map.
## Features
1. Normal Masks

Each mask has 3 channels (RBG) to decide whether the corresponding parts on the normal map to show bump effect. So, we can have 5 * 3 = 15 different parts in total to affect the display of the normal map.

You can use this shader in some circumstance such as on tight clothes. When rotating an arm, the masks can let the normal map show some wrinkles on the elbow with other parts of the normal map still hidding. If you have a script to link the parameters of this shader with the rotation of the joints, those wrinkles can be automatically driven by the character's movements.

2. Color Mask

Use an RGB texture to indicate which parts of the main texture to be blended with designated colors.

3. OMS Mask

Use an RGB texture to respectively control the Occlusion, Metallic and Smoothness of the material by red, green and blue channel.

4. Cutout

Supports for importing the main texture with alpha channel that indicates the parts on the texture to cull.

## List of Properties
### Main
#### Albedo
Main texture as an RGBA image.

White by default.
#### Color
Tint color that blends with the color of the main texture.

White by default.
#### Cutout
If there's a value in Alpha channel of the main texture, any pixels will be discarded when its alpha value is smaller than this cutout parameter. So, the transparent or semi-transparent parts on the main texture could be culled.
#### OMS
An RGB texture for occlusion (red), metallic (green) and smoothness (blue).

White by default.
#### Occlusion
#### Metallic
#### Smoothness

### Color Mask
#### Albedo Mask
To import an RGB texture in it, the colors of corresponding parts on the main texture can be specifically controlled according to the red, green and blue parts on this albedo mask texture.

Black by default.
#### Mask R Color
The color to blend with the parts on the main texture that is referred by the red parts on the albedo mask texture.
#### Mask G Color
The color to blend with the parts on the main texture that is referred by the green parts on the albedo mask texture.
#### Mask B Color
The color to blend with the parts on the main texture that is referred by the blue parts on the albedo mask texture.

For instance, I imported this RGB texture below as the albedo mask:

![未命名-6](https://github.com/user-attachments/assets/d64a786e-7418-40be-91f9-a3bd8c8dd991)

The none-black parts on the mask let the main texture be blended with those three options for mask colors. I gave different colors to those options, and the effect shows like this:

![image](https://github.com/user-attachments/assets/b2460118-fa6b-44bd-be09-56cf58dd4460)

### Normal Maps
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

Suppose that we import the albedo mask texture we mentioned above as the normal map mask texture.

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

### Normal Mask 2
### Normal Mask 3
### Normal Mask 4
### Normal Mask 5
The properties from Normal Map Mask 2 to Normal Map Mask 5 are similar to Normal Map Mask 1 except that the mask texture slots here are black by default.

Please note that if multiple normal masks have some parts overlapped, the shader will get the biggest value among their channels on these overlapped parts with ignoring the rest values instead of cumulating these values.

## Application Case
[NormalMask-Multi-Shader-for-ME](https://github.com/Blatke/NormalMask-Multi-Shader-for-ME), a shader mod for HS2 / AIS.

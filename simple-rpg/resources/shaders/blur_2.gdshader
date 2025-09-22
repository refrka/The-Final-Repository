shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform float blur_size = 2.0; // blur radius in px
uniform float alpha : hint_range(0.0, 1.0) = 0.6; // overlay opacity

void fragment() {
    vec2 texel = blur_size / vec2(textureSize(SCREEN_TEXTURE, 0));
    vec4 sum = vec4(0.0);

    // simple 9-tap blur
    sum += texture(SCREEN_TEXTURE, SCREEN_UV + texel * vec2(-1.0, -1.0));
    sum += texture(SCREEN_TEXTURE, SCREEN_UV + texel * vec2( 0.0, -1.0));
    sum += texture(SCREEN_TEXTURE, SCREEN_UV + texel * vec2( 1.0, -1.0));

    sum += texture(SCREEN_TEXTURE, SCREEN_UV + texel * vec2(-1.0,  0.0));
    sum += texture(SCREEN_TEXTURE, SCREEN_UV);
    sum += texture(SCREEN_TEXTURE, SCREEN_UV + texel * vec2( 1.0,  0.0));

    sum += texture(SCREEN_TEXTURE, SCREEN_UV + texel * vec2(-1.0,  1.0));
    sum += texture(SCREEN_TEXTURE, SCREEN_UV + texel * vec2( 0.0,  1.0));
    sum += texture(SCREEN_TEXTURE, SCREEN_UV + texel * vec2( 1.0,  1.0));

    vec4 blurred = sum / 9.0;

    // mix blurred background with a translucent overlay
    COLOR = vec4(blurred.rgb, alpha);
}
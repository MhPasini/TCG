shader_type canvas_item;
render_mode unshaded;

uniform bool outline_on = false;
uniform vec4 outline_color : source_color;
uniform float border_size : hint_range(0.0, 5.0, 0.5) = 1.0;

void fragment(){
	if (outline_on){
		float size_x = border_size/float(textureSize(TEXTURE, 0).x);
		float size_y = border_size/float(textureSize(TEXTURE, 0).y);
		vec4 sprite_color = COLOR;
		float alpha = -4.0 * sprite_color.a;
		alpha += texture(TEXTURE, UV + vec2(size_x, 0)).a;
		alpha += texture(TEXTURE, UV + vec2(-size_x, 0)).a;
		alpha += texture(TEXTURE, UV + vec2(0, size_y)).a;
		alpha += texture(TEXTURE, UV + vec2(0, -size_y)).a;

		vec4 final_color = mix(sprite_color, outline_color, clamp(alpha, 0.0, 1.0));
		COLOR = vec4(final_color.rgb, clamp(abs(alpha) + sprite_color.a, 0.0, 1.0));
	}
}

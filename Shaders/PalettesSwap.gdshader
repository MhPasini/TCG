shader_type canvas_item;
render_mode unshaded;

uniform sampler2D palette : source_color ; // Insert a palette from lospec for instance
uniform int palette_size = 16;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture;

float when_lt(float x, float y) {
	return max(sign(y - x), 0.0);
}

void fragment(){ 
	vec4 color = COLOR;
	vec4 new_color = vec4(.0);
	
	for (int i = 0; i < palette_size; i++) {
		vec4 palette_color = texture(palette, vec2(1.0 / float(palette_size) * float(i), .0));
		if (distance(palette_color, color) < distance(new_color, color)) {
			new_color = palette_color;
		}
	}
	COLOR = new_color;
}
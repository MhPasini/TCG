shader_type canvas_item;

uniform bool active = false;
uniform vec4 tint : source_color = vec4(1.0, 1.0, 1.0, 1.0);

void fragment() {
	vec4 tint_copy = tint;
	
	if (active == true)
	{
		COLOR.rgb += tint_copy.rgb;
	}
}
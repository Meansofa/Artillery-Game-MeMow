shader_type canvas_item;

uniform sampler2D overlay_tex : repeat_enable, filter_nearest;
uniform vec2 overlay_tex_size = vec2(2800.0, 1080.0); // Set to actual image size
varying vec2 world_position;

void vertex() {
	// World position for each vertex
	world_position = (MODEL_MATRIX * vec4(VERTEX, 0.0, 1.0)).xy;
}

void fragment() {
	// Only apply on red areas
	float mix_amount = floor(COLOR.r);

	// Offset world position to center the texture
	vec2 tex_uv = (world_position + overlay_tex_size * 0.5) / overlay_tex_size;

	// Sample the overlay image at calculated UV
	vec4 overlay_color = texture(overlay_tex, tex_uv);

	// Mix original color and overlay
	COLOR = mix(COLOR, overlay_color, mix_amount);
}

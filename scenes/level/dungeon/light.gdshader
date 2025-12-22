shader_type canvas_item;

uniform vec2 light_pos = vec2(0.0, 0.0); // позиция фонаря в пикселях
uniform float light_radius = 100.0;      // радиус света
uniform float gradient_size = 50.0;      // ширина градиента на краю круга

void fragment() {
    vec2 uv = FRAGCOORD.xy;
    float dist = distance(uv, light_pos);
    float alpha = smoothstep(light_radius - gradient_size, light_radius, dist);
    COLOR = vec4(0.0, 0.0, 0.0, alpha);
}

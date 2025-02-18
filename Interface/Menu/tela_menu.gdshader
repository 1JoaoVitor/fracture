shader_type canvas_item;

uniform float speed : hint_range(0.1, 5.0) = 1.0;
uniform float intensity : hint_range(1.0, 2.0) = 1.5;

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
    
    // Detecta partes brilhantes (estrelas) na textura baseando-se na luminosidade
    float brightness = dot(tex_color.rgb, vec3(0.299, 0.587, 0.114));
    float glow = smoothstep(0.6, 1.0, brightness);

    // Onda de brilho - Fazendo um ciclo de transição perceptível
    float cycle = sin(TIME * speed) * 0.5 + 0.5;  // Varia de 0 a 1 suavemente

    // Definição das cores para transição
    vec3 color_dark = vec3(0.0, 0.0, 0.0);  // Apagado (escuro)
    vec3 color_white = vec3(1.0, 1.0, 1.0); // Branco
    vec3 color_blue_purple = vec3(0.5, 0.2, 1.0); // Azul/Roxo

    // Aplicando diferentes fases do brilho
    vec3 glow_color;
    if (cycle < 0.3) {
        glow_color = mix(color_dark, color_white, cycle / 0.3); // Vai de apagado para pouco branco
    } else if (cycle < 0.5) {
        glow_color = mix(color_white, color_blue_purple, (cycle - 0.3) / 0.2); // De branco para mais colorido
    } else if (cycle < 0.8) {
        glow_color = mix(color_blue_purple, color_white, (cycle - 0.5) / 0.3); // De colorido para branco
    } else {
        glow_color = mix(color_white, color_dark, (cycle - 0.8) / 0.2); // De branco para apagado
    }

    // Aplica o brilho apenas nas estrelas
    vec3 final_color = tex_color.rgb + glow * glow_color * (intensity - 1.0);
    
    COLOR = vec4(final_color, tex_color.a);
}
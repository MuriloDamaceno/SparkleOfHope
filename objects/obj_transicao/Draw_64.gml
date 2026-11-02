// TESTE VISUAL DO DRAW GUI

draw_set_alpha(1);
draw_set_color(c_red);

// Retângulo vermelho bem grande
draw_rectangle(
    0,
    0,
    display_get_gui_width(),
    display_get_gui_height(),
    false
);

draw_set_color(c_white);

// Confirma se o evento está executando
show_debug_message("DRAW GUI EXECUTANDO");

/// OBJ_CUTSCENE_BECO - DRAW GUI

if (etapa == 6) {

    var _alpha;

    if (piscada_tempo <= 10) {

        // Escurece gradualmente
        _alpha = piscada_tempo / 10;

    } else {

        // Clareia gradualmente
        _alpha = 1 - (
            (piscada_tempo - 10) / 12
        );
    }

    _alpha = clamp(_alpha, 0, 1);

    draw_set_color(c_black);
    draw_set_alpha(_alpha);

    draw_rectangle(
        0,
        0,
        display_get_gui_width(),
        display_get_gui_height(),
        false
    );

    draw_set_alpha(1);
    draw_set_color(c_white);
}

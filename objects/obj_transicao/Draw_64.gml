var _gw = display_get_gui_width();
var _gh = display_get_gui_height();

var _bloco  = _gh / linhas;            // lado do bloco
var _cols   = ceil(_gw / _bloco);
var _total  = _cols + linhas - 1;      // número de diagonais

var _cobrindo = (estado != 2);
var _n = _cobrindo ? ceil(progresso * _total) : floor(progresso * _total);

draw_set_alpha(1);
draw_set_color(c_black);

for (var _r = 0; _r < linhas; _r++) {
    for (var _c = 0; _c < _cols; _c++) {
        var _d = _c + _r;
        var _preto = _cobrindo ? (_d < _n) : (_d >= _n);
        if (_preto) {
            // bordas compartilhadas (sem frestas)
            draw_rectangle(floor(_c * _bloco), floor(_r * _bloco),
                           floor((_c + 1) * _bloco), floor((_r + 1) * _bloco), false);
        }
    }
}

draw_set_color(c_white);
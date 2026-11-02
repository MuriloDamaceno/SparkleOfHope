
var _gw = display_get_gui_width();
var _gh = display_get_gui_height();

var _linhas = 12;
var _colunas = 16;
var _total = _linhas + _colunas - 1;

var _limite = progresso * _total;

draw_set_alpha(1);
draw_set_color(c_black);

for (var _y = 0; _y < _linhas; _y++) {
    for (var _x = 0; _x < _colunas; _x++) {

        var _diagonal = _x + _y;
        var _mostrar = false;

        if (estado == 0 || estado == 1) {
            _mostrar = (_diagonal < ceil(_limite));
        }

        if (estado == 2) {
            _mostrar = (_diagonal >= floor(_limite));
        }

        if (_mostrar) {
            draw_rectangle(
                floor(_x * _gw / _colunas),
                floor(_y * _gh / _linhas),
                ceil((_x + 1) * _gw / _colunas),
                ceil((_y + 1) * _gh / _linhas),
                false
            );
        }
    }
}

draw_set_color(c_white);

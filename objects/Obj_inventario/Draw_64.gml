
var _gw = display_get_gui_width();
var _gh = display_get_gui_height();

var _escala = (_gh * 0.95) / sprite_get_height(spr);
var _x = (_gw - sprite_get_width(spr) * _escala) / 2;
var _y = (_gh - sprite_get_height(spr) * _escala) / 2;

// Desenha o inventário
draw_sprite_ext(
    spr, 0, _x, _y,
    _escala, _escala, 0, c_white, 1
);

// Mostra o livro somente se foi coletado
if (global.tem_livro) {

    // Canto superior esquerdo do sprite
    var _base_x = _x - sprite_get_xoffset(spr) * _escala;
    var _base_y = _y - sprite_get_yoffset(spr) * _escala;

    // Centro do primeiro quadradinho
    var _item_x = _base_x + 27 * _escala;
    var _item_y = _base_y + 58 * _escala;

    // Tamanho máximo do livro dentro do espaço
    var _tam = min(
        (11 * _escala) / sprite_get_width(livro),
        (8 * _escala) / sprite_get_height(livro)
    );

    // Centraliza o livro independentemente da origem
    var _livro_x = _item_x +
        (sprite_get_xoffset(livro)
        - sprite_get_width(livro) / 2) * _tam;

    var _livro_y = _item_y +
        (sprite_get_yoffset(livro)
        - sprite_get_height(livro) / 2) * _tam;

    // Desenha o livro
    draw_sprite_ext(
        livro, 0,
        round(_livro_x), round(_livro_y),
        _tam, _tam, 0, c_white, 1
    );
}

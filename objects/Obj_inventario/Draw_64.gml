
var _gw = display_get_gui_width();
var _gh = display_get_gui_height();

var _escala = (_gh * 0.95) / sprite_get_height(spr);
var _x = (_gw - sprite_get_width(spr) * _escala) / 2;
var _y = (_gh - sprite_get_height(spr) * _escala) / 2;

// Desenha o inventário normalmente
draw_sprite_ext(
    spr, 0, _x, _y,
    _escala, _escala, 0, c_white, 1
);

// DESENHA O LIVRO NO PRIMEIRO ESPAÇO
if (global.tem_livro) {

    // Centro do primeiro quadradinho
    var _item_x = _x + sprite_get_width(spr) * _escala * 0.12;
    var _item_y = _y + sprite_get_height(spr) * _escala * 0.305;

    // Tamanho máximo do livro
    var _largura = sprite_get_width(spr) * _escala * 0.11;
    var _altura = sprite_get_height(spr) * _escala * 0.13;

    var _tam = min(
        _largura / sprite_get_width(spr_livro),
        _altura / sprite_get_height(spr_livro)
    );

    // Centraliza o sprite do livro
    var _livro_x = _item_x +
        (sprite_get_xoffset(spr_livro) -
        sprite_get_width(spr_livro) / 2) * _tam;

    var _livro_y = _item_y +
        (sprite_get_yoffset(spr_livro) -
        sprite_get_height(spr_livro) / 2) * _tam;

    draw_sprite_ext(
        spr_livro, 0,
        round(_livro_x), round(_livro_y),
        _tam, _tam, 0, c_white, 1
    );
}

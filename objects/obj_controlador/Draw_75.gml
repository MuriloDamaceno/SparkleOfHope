/// OBJ_CONTROLADOR - DRAW GUI END

window_set_cursor(cr_none);

var _mx = device_mouse_x_to_gui(0);
var _my = device_mouse_y_to_gui(0);
var _sobre = false;

// 1. MENU: botões e barras de volume
if (room == rm_menu) {
    if (global.opcoes_aberta) {
        _sobre = collision_point(mouse_x, mouse_y, obj_botao_fechar, true, false) != noone;

        with (obj_slider) {
            if (point_in_rectangle(mouse_x, mouse_y,
                barra_x0, barra_y0,
                barra_x0 + comprimento, barra_y0 + altura_barra)) {
                _sobre = true;
            }
        }
    } else {
        _sobre = collision_point(mouse_x, mouse_y,
            [obj_botao_iniciar, obj_botao_opcoes, obj_botao_sair],
            true, false) != noone;
    }
}

// 2. ESCOLHAS DO BECO: só as duas respostas abrem a mão
else if (instance_exists(obj_escolha_animal)) {
    with (obj_escolha_animal) {
        _sobre = point_in_rectangle(_mx, _my,
            gato_x, opcoes_y, gato_x + opcao_w, opcoes_y + opcao_h)
            || point_in_rectangle(_mx, _my,
            cachorro_x, opcoes_y, cachorro_x + opcao_w, opcoes_y + opcao_h);
    }
}
else if (instance_exists(obj_escolha_aproximacao)
      || instance_exists(obj_escolha_confianca)) {
    var _escolha = instance_find(obj_escolha_aproximacao, 0);
    if (_escolha == noone) _escolha = instance_find(obj_escolha_confianca, 0);

    with (_escolha) {
        _sobre = point_in_rectangle(_mx, _my,
            esquerda_x, opcoes_y, esquerda_x + opcao_w, opcoes_y + opcao_h)
            || point_in_rectangle(_mx, _my,
            direita_x, opcoes_y, direita_x + opcao_w, opcoes_y + opcao_h);
    }
}

// 3. DIÁLOGO: usa a mesma área de clique da caixa
else if (global.caixa_aberta) {
    with (obj_caixa_dialogo) {
        var _esc = clamp(floor(display_get_gui_height() / 200), 1, 6);
        var _larg = sprite_width * _esc * 1.35;
        var _alt = sprite_height * _esc;
        var _cx = floor((display_get_gui_width() - _larg) / 2);
        var _cy = floor(display_get_gui_height() - _alt - 4 * _esc);

        _sobre = global.caixa_texto != "" && point_in_rectangle(
            _mx, _my, _cx, _cy, _cx + _larg, _cy + _alt
        );
    }
}

// 4. CENÁRIO: móveis, portas, livro e personagens
else if (!instance_exists(Obj_inventario) && !global.cutscene_bloqueio) {
    var _objetos = [
        obj_armario, obj_cama, obj_relogio, obj_porta, obj_porta_corredor,
        obj_corredor_mesa, obj_corredor_planta, obj_corredor_portaCozinha,
        objeto_corredor_armario, objeto_corredor_portaBanheiro,
        objeto_corredor_portaPais, obj_cozinha_cesto, obj_cozinha_geladeira,
        obj_cozinha_pia, obj_cozinha_porta, obj_cozinha_portaCorredor,
        obj_mae, obj_hope
    ];

    _sobre = collision_point(mouse_x, mouse_y, _objetos, true, false) != noone;

    with (obj_livro) {
        if (visible && collision_point(mouse_x, mouse_y, id, true, false) != noone) {
            _sobre = true;
        }
    }

    if (instance_exists(obj_jogador)) {
        with (obj_ponto_dialogo) {
            if (point_distance(x, y, obj_jogador.x, obj_jogador.y) <= 75
                && collision_point(mouse_x, mouse_y, id, true, false) != noone) {
                _sobre = true;
            }
        }

        with (obj_saida_biblioteca) {
            if (point_distance(x, y, obj_jogador.x, obj_jogador.y) <= 55
                && collision_point(mouse_x, mouse_y, id, true, false) != noone) {
                _sobre = true;
            }
        }
    }
}

// 5. MOCHILA: também permite fechar o inventário pelo ícone
if (instance_exists(obj_mochila) && global.despedida_etapa == 0) {
    with (obj_mochila) {
        var _s = display_get_gui_height() * 0.184 / sprite_get_height(spr);

        if (point_in_rectangle(_mx, _my,
            sprite_get_bbox_left(spr) * _s,
            sprite_get_bbox_top(spr) * _s,
            (sprite_get_bbox_right(spr) + 1) * _s,
            (sprite_get_bbox_bottom(spr) + 1) * _s)) {
            _sobre = true;
        }
    }
}

// 0 = apontando | 1 = aberta sobre algo clicável | 2 = pressionada
var _quadro = 0;

if (mouse_check_button(mb_left)) {
    _quadro = 2;
} else if (_sobre) {
    _quadro = 1;
}

var _altura_gui = display_get_gui_height();

// Guarda a altura da interface onde a mão já tem o tamanho certo.
if (room == rm_menu || room == Room1) {
    cursor_altura_referencia = _altura_gui;
}

// Também permite testar o jogo começando direto em outra sala.
if (!variable_instance_exists(id, "cursor_altura_referencia")) {
    cursor_altura_referencia = 201;
}

var _escala_cursor = _altura_gui / max(1, cursor_altura_referencia);

draw_sprite_ext(
    spr_cursor_mao, _quadro,
    _mx, _my,
    _escala_cursor, _escala_cursor,
    0, c_white, 1
);
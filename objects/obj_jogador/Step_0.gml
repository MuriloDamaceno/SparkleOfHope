
// =====================================
// BLOQUEIO DURANTE CUTSCENE
// =====================================

if (
    variable_global_exists("cutscene_bloqueio") &&
    global.cutscene_bloqueio
) {
    exit;
}


/// OBJ_JOGADOR - STEP COMPLETO

// =====================================
// CONFIGURACOES DE SEGURANCA
// =====================================

if (!variable_instance_exists(id, "escala")) {
    escala = abs(image_xscale);
}

if (!variable_global_exists("bloquear_entrada_beco")) {
    global.bloquear_entrada_beco = false;
}


// =====================================
// BLOQUEIO DE DIALOGOS E INVENTARIO
// =====================================

if (global.caixa_aberta || instance_exists(Obj_inventario)) {

    has_target = false;
    global.indo_para_porta = false;

    image_speed = 0;
    image_index = 0;

    if (passo_som_id != -1) {
        audio_stop_sound(passo_som_id);
        passo_som_id = -1;
    }

    exit;
}

atualizar_perspectiva();	
// =====================================
// AVISO DA FAIXA DE PEDESTRES
// =====================================

if (room == rm_rua) {

    var _teste_y = y;

    if (
        keyboard_check(vk_up) ||
        keyboard_check(ord("W"))
    ) {

        _teste_y -= spd;

    } else if (
        keyboard_check(vk_down) ||
        keyboard_check(ord("S"))
    ) {

        _teste_y += spd;

    } else if (has_target) {

        if (target_y < y - spd) {
            _teste_y -= spd;

        } else if (target_y > y + spd) {
            _teste_y += spd;
        }
    }

    if (_teste_y != y) {

        var _barreira = instance_place(
            x, _teste_y, obj_ruacasa
        );

        if (_barreira != noone) {

            if (variable_instance_exists(
                _barreira, "aviso_travessia"
            )) {

                if (_barreira.aviso_travessia) {

                    has_target = false;

                    global.caixa_aberta = true;
                    global.caixa_texto =
                        "Ei, não posso ir por aqui. . .";

                    image_speed = 0;
                    image_index = 0;

                    if (passo_som_id != -1) {
                        audio_stop_sound(passo_som_id);
                        passo_som_id = -1;
                    }

                    exit;
                }
            }
        }
    }
}


// =====================================
// MOVIMENTACAO
// =====================================

var _y_antes_de_andar = y;
var _moving = false;

var _kb_input =
    keyboard_check(vk_right) ||
    keyboard_check(vk_left) ||
    keyboard_check(vk_up) ||
    keyboard_check(vk_down) ||
    keyboard_check(ord("D")) ||
    keyboard_check(ord("A")) ||
    keyboard_check(ord("W")) ||
    keyboard_check(ord("S"));

if (_kb_input) {
    has_target = false;
}
var _horizontal =
    (keyboard_check(vk_right) || keyboard_check(ord("D"))) -
    (keyboard_check(vk_left)  || keyboard_check(ord("A")));

var _vertical =
    (keyboard_check(vk_down) || keyboard_check(ord("S"))) -
    (keyboard_check(vk_up)   || keyboard_check(ord("W")));

var _passo_tecla = (_horizontal != 0 && _vertical != 0)
    ? spd / sqrt(2)
    : spd;


// =====================================
// DIREITA
// =====================================

if (
    keyboard_check(vk_right) ||
    keyboard_check(ord("D"))
) {

    if (pode_pisar(x + spd, y)) {
        x += spd;
    }

    sprite_index = spr_perfil;
    image_xscale = escala;
    _moving = true;
}


// =====================================
// ESQUERDA
// =====================================

if (
    keyboard_check(vk_left) ||
    keyboard_check(ord("A"))
) {

    if (pode_pisar(x - spd, y)) {
        x -= spd;
    }

    sprite_index = spr_perfil;
    image_xscale = -escala;
    _moving = true;
}


// =====================================
// CIMA
// =====================================

if (
    keyboard_check(vk_up) ||
    keyboard_check(ord("W"))
) {

    if (pode_pisar(x, y - spd)) {
        y -= spd;
    }

    sprite_index = spr_costas;
    image_xscale = escala;
    _moving = true;
}


// =====================================
// BAIXO
// =====================================

if (
    keyboard_check(vk_down) ||
    keyboard_check(ord("S"))
) {

    if (pode_pisar(x, y + spd)) {
        y += spd;
    }

    sprite_index = spr_frente;
    image_xscale = escala;
    _moving = true;
}


// =====================================
// MOVIMENTACAO PELO MOUSE
// =====================================

if (!_kb_input && has_target) {

    var _dist = point_distance(
        x, y, target_x, target_y
    );

    if (_dist > spd) {

        var _dx = sign(target_x - x);
        var _dy = sign(target_y - y);
        var _moved = false;

        if (_dx != 0) {

            var _next_x = x + (target_x - x) / _dist * spd;

            if (
                _next_x >= 8 &&
                _next_x <= room_width - 8 &&
                pode_pisar(_next_x, y)
            ) {
                x = _next_x;
                _moved = true;
            }
        }

        if (_dy != 0) {

            var _next_y = y + _dy * spd;

            if (
                _next_y >= floor_top &&
                _next_y <= room_height - 3 &&
                pode_pisar(x, _next_y)
            ) {
                y = _next_y;
                _moved = true;
            }
        }

        if (_moved) {

            if (
                abs(_dx) > 0 &&
                abs(target_x - x) >= abs(target_y - y)
            ) {

                sprite_index = spr_perfil;
                image_xscale = _dx * escala;

            } else if (_dy != 0) {

                sprite_index = (_dy < 0)
                    ? spr_costas
                    : spr_frente;

                image_xscale = escala;
            }

            _moving = true;
            stuck_timer = 0;

        } else {

            stuck_timer++;
        }

        if (stuck_timer > 10) {
            has_target = false;
            stuck_timer = 0;
        }

    } else {

        has_target = false;
    }
}


// =====================================
// LIMITES DO CENARIO
// =====================================

x = clamp(x, 8, room_width - 8);
y = clamp(y, floor_top, room_height - 3);

// Saida pelo centro da borda inferior do beco
// Saída do beco: alinhada com o caminho da cutscene
if (room == rm_beco_interno) {
    var _centro_saida = 158;
    var _na_passagem = abs(x - _centro_saida) <= 25;
    var _no_fim_do_chao = y >= room_height - 8;
    var _andou_para_baixo = y > _y_antes_de_andar;

    if (_na_passagem && _no_fim_do_chao && _andou_para_baixo) {
        has_target = false;
        global.indo_para_porta = false;
        global.porta_alvo = noone;

        // Reaparece na calçada, em frente à entrada do beco.
        global.spawn_room = rua_beco;
        global.spawn_x = 138;
        global.spawn_y = 114;

        room_goto(rua_beco);
        exit;
    }
}

last_x = x;
last_y = y;


// =====================================
// ANIMACAO E SOM DE PASSOS
// =====================================

if (_moving) {

    image_speed = 0.15;

    passo_timer++;

    if (passo_timer >= passo_intervalo) {

        if (
            passo_som_id == -1 ||
            !audio_is_playing(passo_som_id)
        ) {

            passo_som_id = audio_play_sound(
                snd_passo,
                1,
                false,
                global.volume_sfx
            );
        }

        passo_timer = 0;
    }

} else {

    image_speed = 0;
    image_index = 0;

    passo_timer = passo_intervalo;

    if (
        passo_som_id != -1 &&
        audio_is_playing(passo_som_id)
    ) {
        audio_stop_sound(passo_som_id);
    }

    passo_som_id = -1;
}


// =====================================
// SISTEMA DE PORTAS
// =====================================

if (global.indo_para_porta) {

    if (instance_exists(global.porta_alvo)) {

        var _dist_porta = point_distance(
            x, y,
            global.porta_alvo.x,
            global.porta_alvo.y
        );

        if (_dist_porta <= 120) {

            global.indo_para_porta = false;
            has_target = false;

            // Despedida antes de sair da cozinha
            if (
                room == rm_cozinha &&
                global.room_alvo == rm_patio &&
                global.tem_livro
            ) {

                global.despedida_etapa = 1;

                global.caixa_aberta = true;

                global.caixa_texto =
                    "Mãe, vou levar o livro pra Hope! Tchau!";

            } else {

                // Outras portas continuam normais
                if (
                    global.room_alvo != noone &&
                    room_exists(global.room_alvo)
                ) {

                    room_goto(global.room_alvo);
                    exit;
                }
            }
        }

    } else {

        global.indo_para_porta = false;
    }
}



// =====================================
// PATIO -> RUA
// =====================================

if (room == rm_patio) {

    if (!variable_global_exists("bloquear_saida_patio")) {
        global.bloquear_saida_patio = false;
    }

    var _perto_saida = (
        x >= room_width - 10 ||
        place_meeting(x, y, obj_saida_rua)
    );

    // Protecao quando acabou de voltar da rua
    if (global.bloquear_saida_patio) {

        // Precisa sair da area da passagem
        // antes de poder entrar novamente
        if (!_perto_saida) {
            global.bloquear_saida_patio = false;
        }

    } else if (_perto_saida) {

        global.spawn_room = rm_rua;
			global.spawn_x = 25;
			global.spawn_y = 103;
			global.bloquear_retorno_patio = true;

        has_target = false;
        global.indo_para_porta = false;

        room_goto(rm_rua);
        exit;
    }
}


// =====================================
// RUA -> BECO
// =====================================

if (room == rm_rua) {

    var _perto_beco = place_meeting(
        x, y, obj_saida_beco
    );

    // Protecao depois de voltar do beco
    if (global.bloquear_entrada_beco) {

        // Libera nova entrada quando se afastar
        if (!_perto_beco) {
            global.bloquear_entrada_beco = false;
        }

    } else if (_perto_beco) {

        global.spawn_room = rua_beco;
        global.spawn_x = 18;
        global.spawn_y = 110;

        has_target = false;
        global.indo_para_porta = false;

        room_goto(rua_beco);
        exit;
    }
}



// =====================================
// RUA -> PATIO
// =====================================
// RUA -> PATIO
if (room == rm_rua) {
    if (!variable_global_exists("bloquear_retorno_patio")) {
        global.bloquear_retorno_patio = false;
    }

    // Lado do cercadinho, logo depois da faixa
    var _perto_do_cercado = (x <= 65 && y >= 122 && y <= 150);

    if (!_perto_do_cercado) {
        global.bloquear_retorno_patio = false;
    } else if (!global.bloquear_retorno_patio) {
        global.spawn_room = rm_patio;
        global.spawn_x = 438;
        global.spawn_y = 109;
        global.bloquear_saida_patio = true;

        has_target = false;
        global.indo_para_porta = false;

        room_goto(rm_patio);
        exit;
    }
}
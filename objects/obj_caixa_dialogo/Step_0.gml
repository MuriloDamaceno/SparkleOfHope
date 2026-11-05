
if (!variable_global_exists("despedida_etapa")) {
    global.despedida_etapa = 0;
}


// =====================================
// CUTSCENE: DESPEDIDA DA MAE
// =====================================

if (
    global.despedida_etapa == 2 ||
    global.despedida_etapa == 3 ||
    global.despedida_etapa == 5
) {

    tempo_cutscene--;

    if (tempo_cutscene <= 0) {

        // TERMINOU A PRIMEIRA VIRADA
        if (global.despedida_etapa == 2) {

            // Continua de perfil para a esquerda
            // enquanto espera a mae responder
            global.despedida_etapa = 3;

            tempo_cutscene = max(
                1,
                round(game_get_speed(gamespeed_fps) * 2)
            );

        }

        // A MAE NAO RESPONDEU
        else if (global.despedida_etapa == 3) {

            global.despedida_etapa = 4;

            global.caixa_texto =
                "Ué? Ela não deve ter me escutado. . .";

            letras_visiveis = 0;
            ultimo_texto = "";

        }

        // TERMINOU DE VIRAR PARA A DIREITA
        else if (global.despedida_etapa == 5) {

            global.despedida_etapa = 0;
            global.caixa_aberta = false;
            global.caixa_texto = "";

            // Agora sim vai para o patio
            room_goto(rm_patio);
        }
    }
}


// =====================================
// ANIMACAO DAS LETRAS
// =====================================

if (global.caixa_aberta && global.caixa_texto != "") {

    if (global.caixa_texto != ultimo_texto) {

        ultimo_texto = global.caixa_texto;
        letras_visiveis = 0;

        if (som_dialogo_id != -1) {
            audio_stop_sound(som_dialogo_id);
            som_dialogo_id = -1;
        }
    }

    letras_visiveis = min(
        letras_visiveis + velocidade_texto,
        string_length(global.caixa_texto)
    );

    // Espaco completa as letras
    if (keyboard_check_pressed(vk_space)) {
        letras_visiveis = string_length(global.caixa_texto);
    }

    // Som da escrita
    if (letras_visiveis < string_length(global.caixa_texto)) {

        if (som_dialogo_id == -1) {

            som_dialogo_id = audio_play_sound(
                Sound4, 1, true, global.volume_sfx
            );
        }

    } else {

        if (som_dialogo_id != -1) {
            audio_stop_sound(som_dialogo_id);
            som_dialogo_id = -1;
        }
    }

} else {

    letras_visiveis = 0;
    ultimo_texto = "";

    if (som_dialogo_id != -1) {
        audio_stop_sound(som_dialogo_id);
        som_dialogo_id = -1;
    }
}


// =====================================
// CLIQUES NA CAIXA DE DIALOGO
// =====================================

if (
    global.caixa_aberta &&
    global.caixa_texto != "" &&
    dialogo_estava_aberto &&
    mouse_check_button_pressed(mb_left)
) {

    var _gui_w = display_get_gui_width();
    var _gui_h = display_get_gui_height();

    var _escala = clamp(
        floor(_gui_h / 200), 1, 6
    );

    var _box_w = sprite_width * _escala;
    var _box_h = sprite_height * _escala;

    var _box_x = floor(
        (_gui_w - _box_w) / 2
    );

    var _box_y = floor(
        _gui_h - _box_h - 10 * _escala
    );

    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);

    if (point_in_rectangle(
        _mx, _my,
        _box_x, _box_y,
        _box_x + _box_w,
        _box_y + _box_h
    )) {

        // Revela o texto completo
        // antes de avancar a despedida
        if (
            global.despedida_etapa > 0 &&
            letras_visiveis < string_length(global.caixa_texto)
        ) {

            letras_visiveis =
                string_length(global.caixa_texto);

        }

        // PRIMEIRA FALA TERMINOU
        else if (global.despedida_etapa == 1) {

            global.caixa_texto = "";
            global.despedida_etapa = 2;

            tempo_cutscene = max(
                1,
                round(game_get_speed(gamespeed_fps) * 0.25)
            );

            // VIRA PARA A ESQUERDA
            if (instance_exists(obj_jogador)) {

                with (obj_jogador) {

                    sprite_index = spr_perfil;
                    image_xscale = -escala;
                    image_yscale = escala;

                    image_speed = 0;
                    image_index = 0;
                }
            }
        }

        // ULTIMA FALA TERMINOU
        else if (global.despedida_etapa == 4) {

            // Esconde o dialogo, mas mantem
            // a personagem bloqueada
            global.caixa_texto = "";
            global.despedida_etapa = 5;

            // VIRA PARA A DIREITA
            if (instance_exists(obj_jogador)) {

                with (obj_jogador) {

                    sprite_index = spr_perfil;
                    image_xscale = escala;
                    image_yscale = escala;

                    image_speed = 0;
                    image_index = 0;
                }
            }

            // Mostra a virada por meio segundo
            tempo_cutscene = max(
                1,
                round(game_get_speed(gamespeed_fps) * 0.5)
            );
        }

        // DIALOGOS NORMAIS
        else if (global.despedida_etapa == 0) {

            global.caixa_aberta = false;
        }
    }
}


// Impede fechar no mesmo clique
dialogo_estava_aberto = global.caixa_aberta;

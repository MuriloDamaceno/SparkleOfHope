
/// OBJ_CAIXA_DIALOGO - STEP COMPLETO CORRIGIDO

if (!variable_global_exists("despedida_etapa")) {
    global.despedida_etapa = 0;
}

if (!variable_global_exists("hope_conversa_ativa")) {
    global.hope_conversa_ativa = false;
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

        if (global.despedida_etapa == 2) {

            global.despedida_etapa = 3;

            tempo_cutscene = max(
                1,
                round(game_get_speed(gamespeed_fps) * 2)
            );

        }
        else if (global.despedida_etapa == 3) {

            global.despedida_etapa = 4;

            global.caixa_texto =
                "Ué, ela não deve ter me escutado. . ";

            letras_visiveis = 0;
            ultimo_texto = "";

        }
        else if (global.despedida_etapa == 5) {

            global.despedida_etapa = 0;
            global.caixa_aberta = false;
            global.caixa_texto = "";

            room_goto(rm_patio);
            exit;
        }
    }
}


// =====================================
// ANIMACAO DAS LETRAS E SOM
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

    // Espaco completa a fala
    if (keyboard_check_pressed(vk_space)) {
        letras_visiveis =
            string_length(global.caixa_texto);
    }

    // Som enquanto as letras aparecem
    if (
        letras_visiveis <
        string_length(global.caixa_texto)
    ) {

        // Nao cria varios sons simultaneos
        if (
            som_dialogo_id == -1 ||
            !audio_is_playing(som_dialogo_id)
        ) {

            som_dialogo_id = audio_play_sound(
                Sound4,
                1,
                false,
                global.volume_sfx
            );
        }

    } else {

        // Para o som quando a fala termina
        if (som_dialogo_id != -1) {
            audio_stop_sound(som_dialogo_id);
            som_dialogo_id = -1;
        }
    }

} else {

    // Caixa fechada
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

var _box_w = sprite_width * _escala * 1.35;
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
        _mx,
        _my,
        _box_x,
        _box_y,
        _box_x + _box_w,
        _box_y + _box_h
    )) {

        // =====================================
        // COMPLETA AS LETRAS ANTES DE AVANCAR
        // =====================================

        if (
            (
                global.despedida_etapa > 0 ||
                global.hope_conversa_ativa
            ) &&
            letras_visiveis <
            string_length(global.caixa_texto)
        ) {

            letras_visiveis =
                string_length(global.caixa_texto);

        }

        // =====================================
        // PRIMEIRA FALA DA DESPEDIDA
        // =====================================

        else if (global.despedida_etapa == 1) {

            global.caixa_texto = "";
            global.despedida_etapa = 2;

            tempo_cutscene = max(
                1,
                round(game_get_speed(gamespeed_fps) * 0.25)
            );

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

        // =====================================
        // ULTIMA FALA DA DESPEDIDA
        // =====================================

        else if (global.despedida_etapa == 4) {

            global.caixa_texto = "";
            global.despedida_etapa = 5;

            if (instance_exists(obj_jogador)) {

                with (obj_jogador) {

                    sprite_index = spr_perfil;
                    image_xscale = escala;
                    image_yscale = escala;

                    image_speed = 0;
                    image_index = 0;
                }
            }

            tempo_cutscene = max(
                1,
                round(game_get_speed(gamespeed_fps) * 0.5)
            );
        }

        // =====================================
        // CONVERSA COM HOPE
        // =====================================

        else if (
            global.despedida_etapa == 0 &&
            global.hope_conversa_ativa
        ) {

            global.hope_etapa++;

            // Celeste entrega o livro
            if (global.hope_etapa == 3) {
                global.tem_livro = false;
            }

            // Proxima fala
            if (
                global.hope_etapa <
                array_length(global.hope_falas)
            ) {

                global.caixa_texto =
                    global.hope_falas[global.hope_etapa];

                letras_visiveis = 0;
                ultimo_texto = "";

            } else {

                // FIM DA CONVERSA
                global.hope_conversa_ativa = false;
                global.hope_concluida = true;

                global.caixa_aberta = false;
                global.caixa_texto = "";

                global.hope_etapa = 0;
                global.indo_para_porta = false;

                if (instance_exists(obj_jogador)) {

                    with (obj_jogador) {

                        has_target = false;
                        image_speed = 0;
                        image_index = 0;
                    }
                }
            }
        }

        // =====================================
        // DIALOGOS NORMAIS
        // =====================================

        else if (global.despedida_etapa == 0) {

            global.caixa_aberta = false;
        }
    }
}


// =====================================
// IMPEDE FECHAR NO MESMO CLIQUE
// =====================================

dialogo_estava_aberto = global.caixa_aberta;

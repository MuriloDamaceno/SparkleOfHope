
if (!variable_global_exists("despedida_etapa")) {
    global.despedida_etapa = 0;
}


// ANIMAÇÃO DAS LETRAS

if (global.caixa_aberta && global.caixa_texto != "") {

    // Detecta quando o texto muda
    if (global.caixa_texto != ultimo_texto) {

        ultimo_texto = global.caixa_texto;
        letras_visiveis = 0;

        // Para o som anterior
        if (som_dialogo_id != -1) {
            audio_stop_sound(som_dialogo_id);
            som_dialogo_id = -1;
        }
    }

    // Faz as letras aparecerem aos poucos
    letras_visiveis = min(
        letras_visiveis + velocidade_texto,
        string_length(global.caixa_texto)
    );

    // Espaço revela o texto completo
    if (keyboard_check_pressed(vk_space)) {
        letras_visiveis = string_length(global.caixa_texto);
    }

    // Enquanto as letras aparecem
    if (letras_visiveis < string_length(global.caixa_texto)) {

        if (som_dialogo_id == -1) {

            som_dialogo_id = audio_play_sound(
                Sound4,
                1,
                true,
                global.volume_sfx
            );
        }

    } else {

        // Terminou de escrever
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


// CONTROLE DE CLIQUES NA CAIXA

if (
    global.caixa_aberta &&
    dialogo_estava_aberto &&
    mouse_check_button_pressed(mb_left)
) {

    var _gui_w = display_get_gui_width();
    var _gui_h = display_get_gui_height();

    var _escala = clamp(
        floor(_gui_h / 200),
        1,
        6
    );

    // Tamanho da caixa
    var _box_w = sprite_width * _escala;
    var _box_h = sprite_height * _escala;

    // Posição da caixa
    var _box_x = floor(
        (_gui_w - _box_w) / 2
    );

    var _box_y = floor(
        _gui_h - _box_h - 10 * _escala
    );

    // Mouse na interface
    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);

    // Só aceita clique dentro da caixa
    if (
        point_in_rectangle(
            _mx,
            _my,
            _box_x,
            _box_y,
            _box_x + _box_w,
            _box_y + _box_h
        )
    ) {

        // DESPEDIDA ANTES DE IR PARA O PÁTIO

        if (global.despedida_etapa > 0) {

            // Se o texto não terminou,
            // o clique revela todas as letras
            if (
                letras_visiveis <
                string_length(global.caixa_texto)
            ) {

                letras_visiveis =
                    string_length(global.caixa_texto);

            }

            // PRIMEIRA FALA TERMINOU
            // Agora é a vez da mãe
            else if (global.despedida_etapa == 1) {

                global.despedida_etapa = 2;

                global.caixa_texto =
              "Ué? Ela não deve ter me escutado. . .";

                letras_visiveis = 0;
                ultimo_texto = "";

            }

            // SEGUNDA FALA TERMINOU
            // Fecha e vai para o pátio
            else if (global.despedida_etapa == 2) {

                global.despedida_etapa = 0;

                global.caixa_aberta = false;
                global.caixa_texto = "";

                // Agora sim muda de cenário
                room_goto(rm_patio);

            }

        } else {

            // DIÁLOGOS NORMAIS

            global.caixa_aberta = false;

        }
    }
}


// Impede que o clique que abriu
// a caixa também a feche
dialogo_estava_aberto = global.caixa_aberta;

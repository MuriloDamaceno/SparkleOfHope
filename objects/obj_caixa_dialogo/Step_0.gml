
if (global.caixa_aberta && global.caixa_texto != "") {

    // Detecta um novo diálogo
    if (global.caixa_texto != ultimo_texto) {
        ultimo_texto = global.caixa_texto;
        letras_visiveis = 0;

        // Para o som anterior
        if (som_dialogo_id != -1) {
            audio_stop_sound(som_dialogo_id);
            som_dialogo_id = -1;
        }
    }

    // Faz as letras aparecerem
    letras_visiveis = min(
        letras_visiveis + velocidade_texto,
        string_length(global.caixa_texto)
    );

    // Espaço revela tudo
    if (keyboard_check_pressed(vk_space)) {
        letras_visiveis = string_length(global.caixa_texto);
    }

    // Enquanto as letras aparecem
    if (letras_visiveis < string_length(global.caixa_texto)) {

        // Começa a tocar o som
        if (som_dialogo_id == -1) {
            som_dialogo_id = audio_play_sound(
                snd_fim_dialogo, 1, true, global.volume_sfx
            );
        }

    } else {

        // Terminou a escrita: para o som
        if (som_dialogo_id != -1) {
            audio_stop_sound(som_dialogo_id);
            som_dialogo_id = -1;
        }
    }

} else {

    // Caixa fechada: para tudo
    letras_visiveis = 0;
    ultimo_texto = "";

    if (som_dialogo_id != -1) {
        audio_stop_sound(som_dialogo_id);
        som_dialogo_id = -1;
    }
}

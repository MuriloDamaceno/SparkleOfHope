
if (global.caixa_aberta && global.caixa_texto != "") {

    if (global.caixa_texto != ultimo_texto) {
        ultimo_texto = global.caixa_texto;
        letras_visiveis = 0;
        som_fim_tocado = false;
    }

    // Animação das letras
    letras_visiveis = min(
        letras_visiveis + velocidade_texto,
        string_length(global.caixa_texto)
    );

    // Espaço revela o texto inteiro
    if (keyboard_check_pressed(vk_space)) {
        letras_visiveis = string_length(global.caixa_texto);
    }

    // Toca o som quando a escrita terminar
    if (letras_visiveis >= string_length(global.caixa_texto)
        && !som_fim_tocado) {

        audio_play_sound(snd_fim_dialogo, 1, false);
        som_fim_tocado = true;
    }

} else {
    letras_visiveis = 0;
    ultimo_texto = "";
    som_fim_tocado = false;
}

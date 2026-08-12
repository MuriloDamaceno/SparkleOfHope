if (!global.opcoes_aberta) exit; // não faz nada se o painel estiver fechado

if (arrastando) {
    // barra_x0 e comprimento são definidos no Create de cada filho (música/efeitos)
    nivel = clamp((mouse_x - barra_x0) / comprimento, 0, 1);

    if (object_index == obj_slider_musica) {
        global.volume_musica = nivel;
        if (variable_global_exists("music_id") && audio_exists(mus_tema) && audio_is_playing(global.music_id)) {
            audio_sound_gain(global.music_id, global.volume_musica, 0);
        }
    } else if (object_index == obj_slider_som) {
        global.volume_sfx = nivel;
    }
}
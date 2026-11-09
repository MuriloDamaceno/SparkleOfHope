
/// OBJ_ANDANTE - STEP

var _proximo_x = x - velocidade;

// Para apenas se encontrar a protagonista
if (!place_meeting(_proximo_x, y, obj_jogador)) {

    // Continua andando para a esquerda
    x = _proximo_x;

    image_speed = 0.12;

} else {

    // Para quando encontra a protagonista
    image_speed = 0;
    image_index = 0;
}

// Quando sair da sala, reaparece pela direita
if (bbox_right < 0) {
    x = room_width + sprite_width * escala;
}

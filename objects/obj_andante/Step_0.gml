
/// NPC ANDANTE - STEP

var _proximo_x = x - velocidade;

// Verifica se ha alguem ou algo bloqueando
if (
    !place_meeting(_proximo_x, y, obj_jogador) &&
    !place_meeting(_proximo_x, y, obj_solido)
) {

    // Caminha para a esquerda
    x = _proximo_x;

    // Continua a animacao
    image_speed = 0.12;

} else {

    // Para ao encontrar um obstaculo
    image_speed = 0;
    image_index = 0;
}

// Quando sair inteiramente da sala,
// reaparece pelo lado direito
if (bbox_right < 0) {
    x = room_width + sprite_width * escala;
}

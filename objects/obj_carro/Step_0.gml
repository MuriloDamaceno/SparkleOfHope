
x += velocidade;

// Carro indo para a esquerda
if (velocidade < 0 && bbox_right < 0) {
    instance_destroy();
}

// Carro indo para a direita
if (velocidade > 0 && bbox_left > room_width) {
    instance_destroy();
}

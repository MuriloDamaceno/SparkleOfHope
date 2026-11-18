
/// OBJ_BICHINHO - CREATE

// 1 = gato
// 2 = cachorro
animal = 0;

// Comeca assustado
calmo = false;

// Posicao inicial no beco
x = 120;
y = 140;

// Configuracao visual
image_speed = 0;
visible = true;

// Define qual animal permaneceu
if (global.animal_escolhido == 1) {

    // Celeste afastou o gato
    // O cachorro permanece
    animal = 2;
    sprite_index = cachorrobravo;

} else if (global.animal_escolhido == 2) {

    // Celeste afastou o cachorro
    // O gato permanece
    animal = 1;
    sprite_index = gatobravo;
}


// Diminui o tamanho do bichinho
image_xscale = 0.35;
image_yscale = 0.35;

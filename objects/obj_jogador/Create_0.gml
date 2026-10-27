spd = 1.5;
image_speed = 0;
image_index = 0;


target_x = x;
target_y = y;
has_target = false;

stuck_timer = 0;
last_x = x;
last_y = y;

// controle do som de passo
passo_timer = 0;
passo_intervalo = 20; 
passo_som_id = -1; 

// No pátio quem limita são os obj_solido; nas outras salas mantém o limite antigo
if (room == rm_patio) {
    floor_top = 0;
} else if (room == rm_rua) {
    floor_top = 0;   // ajuste esse valor conforme o chão do rm_rua
} else {
    floor_top = 161;
}
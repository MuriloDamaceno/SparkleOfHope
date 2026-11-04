// Proteção para escala
if (!variable_instance_exists(id, "escala")) {
    escala = 1;
}

// ==========================================
// MOVIMENTAÇÃO DO JOGADOR
// ==========================================

var _moving = false;

var _kb_input =
    keyboard_check(vk_right) ||
    keyboard_check(vk_left) ||
    keyboard_check(vk_up) ||
    keyboard_check(vk_down) ||
    keyboard_check(ord("D")) ||
    keyboard_check(ord("A")) ||
    keyboard_check(ord("W")) ||
    keyboard_check(ord("S"));

image_yscale = escala;

if (_kb_input) {
    has_target = false;
}

// DIREITA
if (keyboard_check(vk_right) || keyboard_check(ord("D"))) {
    if (!place_meeting(x + spd, y, obj_solido)) {
        x += spd;
    }

    sprite_index = spr_perfil;
    image_xscale = escala;
    _moving = true;
}

// ESQUERDA
if (keyboard_check(vk_left) || keyboard_check(ord("A"))) {
    if (!place_meeting(x - spd, y, obj_solido)) {
        x -= spd;
    }

    sprite_index = spr_perfil;
    image_xscale = -escala;
    _moving = true;
}

// CIMA
if (keyboard_check(vk_up) || keyboard_check(ord("W"))) {
    if (!place_meeting(x, y - spd, obj_solido)) {
        y -= spd;
    }

    sprite_index = spr_costas;
    image_xscale = escala;
    _moving = true;
}

// BAIXO
if (keyboard_check(vk_down) || keyboard_check(ord("S"))) {
    if (!place_meeting(x, y + spd, obj_solido)) {
        y += spd;
    }

    sprite_index = spr_frente;
    image_xscale = escala;
    _moving = true;
}

// ==========================================
// MOVIMENTAÇÃO AUTOMÁTICA
// ==========================================

if (!_kb_input && has_target) {

    var _dist = point_distance(
        x, y,
        target_x, target_y
    );

    if (_dist > spd) {

        var _dx = sign(target_x - x);
        var _dy = sign(target_y - y);
        var _moved = false;

        if (_dx != 0) {

            var _next_x = x + _dx * spd;

            if (
                _next_x >= 8 &&
                _next_x <= room_width - 8 &&
                !place_meeting(_next_x, y, obj_solido)
            ) {
                x = _next_x;
                _moved = true;
            }
        }

        if (_dy != 0) {

            var _next_y = y + _dy * spd;

            if (
                _next_y >= floor_top &&
                _next_y <= room_height - 3 &&
                !place_meeting(x, _next_y, obj_solido)
            ) {
                y = _next_y;
                _moved = true;
            }
        }

        if (_moved) {

            if (
                abs(_dx) > 0 &&
                abs(target_x - x) >= abs(target_y - y)
            ) {
                sprite_index = spr_perfil;
                image_xscale = _dx * escala;

            } else if (_dy != 0) {

                sprite_index = (_dy < 0)
                    ? spr_costas
                    : spr_frente;

                image_xscale = escala;
            }

            _moving = true;
            stuck_timer = 0;

        } else {
            stuck_timer++;
        }

        if (stuck_timer > 10) {
            has_target = false;
            stuck_timer = 0;
        }

    } else {
        has_target = false;
    }
}

// ==========================================
// LIMITES DO CENÁRIO
// ==========================================

x = clamp(x, 8, room_width - 8);
y = clamp(y, floor_top, room_height - 3);

last_x = x;
last_y = y;

// ==========================================

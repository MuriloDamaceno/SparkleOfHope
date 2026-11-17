
/// OBJ_CUTSCENE_TARDE - STEP

if (espera_clique > 0) {
    espera_clique--;
}

var _fps = game_get_speed(gamespeed_fps);


// =====================================
// ETAPA 0 - ESCURECER
// =====================================

if (etapa == 0) {

    cobertura = min(cobertura + 0.035, 1);

    if (cobertura >= 1) {
        etapa = 1;
        letras_narracao = 0;
        espera_clique = 15;
    }

    exit;
}


// =====================================
// ETAPA 1 - NARRACAO NA TELA PRETA
// =====================================

if (etapa == 1) {

    letras_narracao = min(
        letras_narracao + 0.5,
        string_length(texto_narracao)
    );

    if (
        espera_clique <= 0 &&
        mouse_check_button_pressed(mb_left)
    ) {

        if (
            letras_narracao <
            string_length(texto_narracao)
        ) {

            // Primeiro clique completa a fala
            letras_narracao =
                string_length(texto_narracao);

        } else {

            // Segundo clique avanca a cena
            etapa = 2;
        }
    }

    exit;
}


// =====================================
// ETAPA 2 - PREPARAR A RUA DO BECO
// =====================================

if (etapa == 2) {

    global.caixa_aberta = false;
    global.caixa_texto = "";

    // Celeste aparece do lado esquerdo
    global.spawn_room = rua_beco;
    global.spawn_x = 25;
    global.spawn_y = 110;

    etapa = 3;

    room_goto(rua_beco);
    exit;
}


// =====================================
// ETAPA 3 - REVELAR NOVO CENARIO
// =====================================

if (etapa == 3) {

    // Aguarda a room estar pronta
    if (room != rua_beco) exit;
    if (!instance_exists(obj_jogador)) exit;

    // Troca o fundo da rua do beco
    var _fundo = layer_get_id("Background");

    if (_fundo != -1) {
        layer_background_sprite(
            _fundo,
            spr_ruabeco_depois
        );
    }

    // Descobre o marcador da entrada
    if (instance_exists(obj_marcador_beco)) {

        var _marcador =
            instance_find(obj_marcador_beco, 0);

        entrada_x = _marcador.x;

        // Para antes da passagem
        destino_x = max(40, entrada_x - 35);
    }

    // Deixa Celeste olhando para a direita
    with (obj_jogador) {
        sprite_index = spr_perfil;
        image_xscale = abs(escala);
        image_speed = 0;
        has_target = false;
    }

    // Revela a cena gradualmente
    cobertura = max(cobertura - 0.035, 0);

    if (cobertura <= 0) {
        etapa = 4;
    }

    exit;
}


// =====================================
// ETAPA 4 - CELESTE CAMINHA
// =====================================

if (etapa == 4) {

    if (!instance_exists(obj_jogador)) exit;

    with (obj_jogador) {

        has_target = false;

        sprite_index = spr_perfil;
        image_xscale = abs(escala);

        // Caminhada automatica para direita
        if (x < other.destino_x) {

            x = min(x + 0.8, other.destino_x);
            image_speed = 0.15;

        } else {

            image_speed = 0;
            image_index = 0;
        }
    }

    if (obj_jogador.x >= destino_x) {
        etapa = 5;
        fala_iniciada = false;
    }

    exit;
}


// =====================================
// ETAPA 5 - PRIMEIRA REACAO
// =====================================

if (etapa == 5) {

    if (!fala_iniciada) {

        if (!instance_exists(obj_caixa_dialogo)) {
            instance_create_depth(
                0, 0, -1000,
                obj_caixa_dialogo
            );
        }

        global.caixa_texto = "Celeste: Hm...?";
        global.caixa_aberta = true;

        fala_iniciada = true;

    } else if (!global.caixa_aberta) {

        etapa = 6;
        fala_iniciada = false;
    }

    exit;
}


// =====================================
// ETAPA 6 - VIRA E PERGUNTA
// =====================================

if (etapa == 6) {

    if (!fala_iniciada) {

        if (instance_exists(obj_jogador)) {

            with (obj_jogador) {
                sprite_index = spr_costas;
                image_xscale = abs(escala);
                image_speed = 0;
                image_index = 0;
            }
        }

        global.caixa_texto =
            "Celeste: Ué... Que barulho foi esse?";

        global.caixa_aberta = true;

        fala_iniciada = true;

    } else if (!global.caixa_aberta) {

        etapa = 7;
    }

    exit;
}


// =====================================
// ETAPA 7 - APROXIMA DA ENTRADA
// =====================================

if (etapa == 7) {

    if (!instance_exists(obj_jogador)) exit;

    // Caminha ate o marcador do beco
    with (obj_jogador) {

        has_target = false;

        sprite_index = spr_perfil;
        image_xscale = abs(escala);

        if (x < other.entrada_x) {

            x = min(x + 0.6, other.entrada_x);
            image_speed = 0.15;

        } else {

            image_speed = 0;
            image_index = 0;
        }
    }

    if (obj_jogador.x >= entrada_x) {
        etapa = 8;
    }

    exit;
}


// =====================================
// ETAPA 8 - ENTRAR NO BECO
// =====================================

if (etapa == 8) {

    cobertura = min(cobertura + 0.04, 1);

    if (cobertura >= 1) {

        etapa = 9;

        global.spawn_room = rm_beco_interno;
        global.spawn_x = 40;
        global.spawn_y = 170;

        room_goto(rm_beco_interno);
    }

    exit;
}


// =====================================
// ETAPA 9 - FINALIZAR
// =====================================

if (etapa == 9) {

    if (room != rm_beco_interno) exit;

    global.cutscene_bloqueio = false;
    global.cutscene_finalizada = true;

    instance_destroy();
    exit;
}

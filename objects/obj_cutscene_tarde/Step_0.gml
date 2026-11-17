
/// OBJ_CUTSCENE_TARDE - STEP COMPLETO
/// SEM TRANSICAO

// =====================================
// ETAPA 0 - IR PARA A RUA DO BECO
// =====================================

if (etapa == 0) {

    global.caixa_aberta = false;
    global.caixa_texto = "";

    global.spawn_room = rua_beco;
    global.spawn_x = 25;
    global.spawn_y = 110;

    etapa = 1;

    room_goto(rua_beco);
    exit;
}


// =====================================
// ETAPA 1 - PREPARAR O CENARIO
// =====================================

if (etapa == 1) {

    if (room != rua_beco) exit;
    if (!instance_exists(obj_jogador)) exit;

    if (!preparado) {

        // Troca o fundo pelo novo beco
        var _fundo = layer_get_id("Background");

        if (_fundo != -1) {
            layer_background_sprite(
                _fundo,
                spr_ruabeco_depois
            );
        }

        // Esconde o primeiro plano antigo
        var _frente = layer_get_id("Primeiro_Plano");

        if (_frente != -1) {
            layer_set_visible(_frente, false);
        }

        // Remove elementos da rua antiga
        with (obj_carro) {
            instance_destroy();
        }

        with (obj_gerador_carros) {
            instance_destroy();
        }

        with (obj_andante) {
            instance_destroy();
        }

        // Encontra a entrada do beco
        if (instance_exists(obj_marcador_beco)) {

            var _marcador =
                instance_find(obj_marcador_beco, 0);

            // Centro do sprite de 64 pixels
            entrada_x = _marcador.x + 32;
            entrada_y = 94;

            destino_x = entrada_x;
        }

        // Posiciona Celeste a esquerda
        with (obj_jogador) {

            x = 25;
            y = 110;

            target_x = x;
            target_y = y;
            has_target = false;

            sprite_index = spr_perfil;
            image_xscale = abs(escala);

            image_speed = 0;
            image_index = 0;
        }

        preparado = true;
        indice_fala = 0;
        fala_ativa = false;
    }

    etapa = 2;
    exit;
}


// =====================================
// ETAPA 2 - TIME SKIP
// =====================================

if (etapa == 2) {

    // Inicia a fala atual
    if (!fala_ativa) {

        if (!instance_exists(obj_caixa_dialogo)) {
            instance_create_depth(
                0, 0, -1000,
                obj_caixa_dialogo
            );
        }

        global.caixa_texto =
            falas_time_skip[indice_fala];

        global.caixa_aberta = true;
        fala_ativa = true;

    }
    // Espera o jogador fechar a fala
    else if (!global.caixa_aberta) {

        indice_fala++;
        fala_ativa = false;

        // Terminou todas as falas
        if (
            indice_fala >=
            array_length(falas_time_skip)
        ) {

            etapa = 3;
        }
    }

    exit;
}


// =====================================
// ETAPA 3 - CELESTE CAMINHA
// =====================================

if (etapa == 3) {

    if (!instance_exists(obj_jogador)) exit;

    with (obj_jogador) {

        has_target = false;

        sprite_index = spr_perfil;
        image_xscale = abs(escala);

        if (x < other.destino_x) {

            x = min(
                x + 0.45,
                other.destino_x
            );

            image_speed = 0.12;

        } else {

            image_speed = 0;
            image_index = 0;
        }
    }

    if (obj_jogador.x >= destino_x) {

        etapa = 4;
        fala_ativa = false;
    }

    exit;
}


// =====================================
// ETAPA 4 - ELA ESCUTA UM BARULHO
// =====================================

if (etapa == 4) {

    if (!fala_ativa) {

        if (!instance_exists(obj_caixa_dialogo)) {
            instance_create_depth(
                0, 0, -1000,
                obj_caixa_dialogo
            );
        }

        global.caixa_texto = "Celeste: Hm...?";
        global.caixa_aberta = true;

        fala_ativa = true;

    } else if (!global.caixa_aberta) {

        etapa = 5;
        fala_ativa = false;
    }

    exit;
}


// =====================================
// ETAPA 5 - VIRA DE COSTAS
// =====================================

if (etapa == 5) {

    if (!fala_ativa) {

        if (instance_exists(obj_jogador)) {

            with (obj_jogador) {

                sprite_index = spr_costas;
                image_xscale = abs(escala);

                image_speed = 0;
                image_index = 0;
                has_target = false;
            }
        }

        if (!instance_exists(obj_caixa_dialogo)) {
            instance_create_depth(
                0, 0, -1000,
                obj_caixa_dialogo
            );
        }

        global.caixa_texto =
            "Celeste: Ue... Que barulho foi esse?";

        global.caixa_aberta = true;
        fala_ativa = true;

    } else if (!global.caixa_aberta) {

        etapa = 6;
    }

    exit;
}


// =====================================
// ETAPA 6 - APROXIMA DO BECO
// =====================================

if (etapa == 6) {

    if (!instance_exists(obj_jogador)) exit;

    with (obj_jogador) {

        has_target = false;

        var _dx = other.entrada_x - x;
        var _dy = other.entrada_y - y;

        var _dist = point_distance(
            x, y,
            other.entrada_x,
            other.entrada_y
        );

        if (_dist > 0.45) {

            var _passo = min(0.45, _dist);

            x += (_dx / _dist) * _passo;
            y += (_dy / _dist) * _passo;

            sprite_index = spr_costas;
            image_xscale = abs(escala);
            image_speed = 0.12;

        } else {

            x = other.entrada_x;
            y = other.entrada_y;

            image_speed = 0;
            image_index = 0;
        }
    }

    if (
        point_distance(
            obj_jogador.x,
            obj_jogador.y,
            entrada_x,
            entrada_y
        ) <= 0.45
    ) {

        etapa = 7;
    }

    exit;
}


// =====================================
// ETAPA 7 - ENTRAR NO BECO
// =====================================

if (etapa == 7) {

    global.caixa_aberta = false;
    global.caixa_texto = "";

    global.spawn_room = rm_beco_interno;
    global.spawn_x = 40;
    global.spawn_y = 170;

    global.cutscene_finalizada = true;
    global.cutscene_bloqueio = false;

    // Remove o controlador da cutscene
    instance_destroy();

    room_goto(rm_beco_interno);
    exit;
}

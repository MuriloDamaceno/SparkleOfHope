
/// OBJ_CUTSCENE_TARDE - STEP COMPLETO
/// SEM TRANSICAO, COM TIME SKIP

// =====================================
// ETAPA 0 - CORTAR PARA O NOVO BECO
// =====================================

if (etapa == 0) {

    global.caixa_aberta = false;
    global.caixa_texto = "";

    global.spawn_room = rua_beco;
    global.spawn_x = 25;
    global.spawn_y = 110;

    // Esconde a Celeste anterior
    with (obj_jogador) {
        visible = false;
        has_target = false;
    }

    etapa = 1;

    room_goto(rua_beco);
    exit;
}


// =====================================
// ETAPA 1 - PREPARAR O NOVO CENARIO
// =====================================

if (etapa == 1) {

    if (room != rua_beco) exit;
    if (!instance_exists(obj_jogador)) exit;

    if (!preparado) {

        // Fundo novo
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

        // Remove os carros e o andante
        with (obj_carro) {
            instance_destroy();
        }

        with (obj_gerador_carros) {
            instance_destroy();
        }

        with (obj_andante) {
            instance_destroy();
        }

        // Localiza o beco
        if (instance_exists(obj_marcador_beco)) {

            var _marcador =
                instance_find(obj_marcador_beco, 0);

            entrada_x = _marcador.x + 32;
            entrada_y = 94;
            destino_x = entrada_x;
        }

        // Prepara a Celeste invisivel
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

            // NAO APARECE NO TIME SKIP
            visible = false;
        }

        indice_fala = 0;
        fala_ativa = false;
        preparado = true;
    }

    etapa = 2;
    exit;
}


// =====================================
// ETAPA 2 - TIME SKIP SEM CELESTE
// =====================================

if (etapa == 2) {

    // Celeste continua invisivel
    with (obj_jogador) {
        visible = false;
    }

    if (!fala_ativa) {

        // Garante que a caixa exista
        if (!instance_exists(obj_caixa_dialogo)) {

            instance_create_depth(
                0, 0, -1000,
                obj_caixa_dialogo
            );
        }

        // Fala atual
        global.caixa_texto =
            falas_time_skip[indice_fala];

        global.caixa_aberta = true;
        fala_ativa = true;

    } else if (!global.caixa_aberta) {

        // Jogador terminou a fala
        indice_fala++;
        fala_ativa = false;

        // Todas as falas terminaram
        if (
            indice_fala >=
            array_length(falas_time_skip)
        ) {

            etapa = 3;

            // Celeste finalmente aparece
            with (obj_jogador) {

                visible = true;

                sprite_index = spr_perfil;
                image_xscale = abs(escala);

                image_speed = 0;
                image_index = 0;
            }
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

        visible = true;
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
// ETAPA 4 - PRIMEIRO BARULHO
// =====================================

if (etapa == 4) {

    if (!fala_ativa) {

        if (!instance_exists(obj_caixa_dialogo)) {
            instance_create_depth(
                0, 0, -1000,
                obj_caixa_dialogo
            );
        }

        global.caixa_texto =
            "Celeste: Hm...?";

        global.caixa_aberta = true;
        fala_ativa = true;

    } else if (!global.caixa_aberta) {

        etapa = 5;
        fala_ativa = false;
    }

    exit;
}


// =====================================
// ETAPA 5 - VIRA DE COSTAS E PERGUNTA
// =====================================

if (etapa == 5) {

    if (!fala_ativa) {

        with (obj_jogador) {

            sprite_index = spr_costas;
            image_xscale = abs(escala);

            image_speed = 0;
            image_index = 0;
            has_target = false;
        }

        if (!instance_exists(obj_caixa_dialogo)) {
            instance_create_depth(
                0, 0, -1000,
                obj_caixa_dialogo
            );
        }

        global.caixa_texto =
            "Celeste: Ué... Que barulho foi esse?";

        global.caixa_aberta = true;
        fala_ativa = true;

    } else if (!global.caixa_aberta) {

        etapa = 6;
        fala_ativa = false;
    }

    exit;
}


// =====================================
// ETAPA 6 - CAMINHA PARA DENTRO DO BECO
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
// ETAPA 7 - ENTRA NO BECO
// =====================================

if (etapa == 7) {

    global.caixa_aberta = false;
    global.caixa_texto = "";

    global.spawn_room = rm_beco_interno;
    global.spawn_x = 40;
    global.spawn_y = 170;

    global.cutscene_finalizada = true;
    global.cutscene_bloqueio = false;

    instance_destroy();

    room_goto(rm_beco_interno);
    exit;
}

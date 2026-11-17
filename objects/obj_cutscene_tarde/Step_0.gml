
/// OBJ_CUTSCENE_TARDE - STEP

if (espera_clique > 0) {
    espera_clique--;
}


// =====================================
// 0 - ESCURECE RAPIDAMENTE
// =====================================

if (etapa == 0) {

    cobertura = min(cobertura + 0.15, 1);

    if (cobertura >= 1) {
        etapa = 1;
        espera_clique = 8;
        letras_narracao = 0;
    }

    exit;
}


// =====================================
// 1 - NARRACAO NA TELA PRETA
// =====================================

if (etapa == 1) {

    letras_narracao = min(
        letras_narracao + 2,
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

            letras_narracao =
                string_length(texto_narracao);

        } else {

            etapa = 2;
        }
    }

    exit;
}


// =====================================
// 2 - TRANSPORTA PARA O BECO
// =====================================

if (etapa == 2) {

    global.caixa_aberta = false;
    global.caixa_texto = "";

    global.spawn_room = rua_beco;
    global.spawn_x = 25;
    global.spawn_y = 110;

    preparado = false;
    etapa = 3;

    room_goto(rua_beco);
    exit;
}


// =====================================
// 3 - PREPARA E REVELA O NOVO BECO
// =====================================

if (etapa == 3) {

    if (room != rua_beco) exit;
    if (!instance_exists(obj_jogador)) exit;

    if (!preparado) {

        // Troca o fundo
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

        // Remove carros antigos
        with (obj_carro) {
            instance_destroy();
        }

        // Impede novos carros
        with (obj_gerador_carros) {
            instance_destroy();
        }

        // Remove o andante antigo
        with (obj_andante) {
            instance_destroy();
        }

        // Localiza a entrada marcada
        if (instance_exists(obj_marcador_beco)) {

            var _marcador =
                instance_find(obj_marcador_beco, 0);

            entrada_x = _marcador.x;
            entrada_y = _marcador.y + 22;

            // Para antes de entrar
            destino_x = max(
                40,
                entrada_x - 35
            );
        }

        // Prepara a Celeste
        with (obj_jogador) {

            x = 25;
            y = 110;

            has_target = false;

            sprite_index = spr_perfil;
            image_xscale = abs(escala);
            image_speed = 0;
            image_index = 0;
        }

        preparado = true;
    }

    // Abre a tela
    cobertura = max(cobertura - 0.15, 0);

    if (cobertura <= 0) {
        etapa = 4;
    }

    exit;
}


// =====================================
// 4 - CELESTE ANDA PARA A DIREITA
// =====================================

if (etapa == 4) {

    if (!instance_exists(obj_jogador)) exit;

    with (obj_jogador) {

        has_target = false;

        sprite_index = spr_perfil;
        image_xscale = abs(escala);

        if (x < other.destino_x) {

            x = min(
                x + 1.1,
                other.destino_x
            );

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
// 5 - ELA ESCUTA ALGUMA COISA
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
// 6 - ELA VIRA PARA O BECO
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
// 7 - CAMINHA ATE A ENTRADA DO BECO
// =====================================

if (etapa == 7) {

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

        if (_dist > 0.8) {

            var _passo = min(0.8, _dist);

            x += (_dx / _dist) * _passo;
            y += (_dy / _dist) * _passo;

            // Olha para o beco
            sprite_index = spr_costas;
            image_xscale = abs(escala);
            image_speed = 0.15;

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
        ) <= 0.8
    ) {

        etapa = 8;
    }

    exit;
}


// =====================================
// 8 - ESCURECE PARA ENTRAR NO BECO
// =====================================

if (etapa == 8) {

    cobertura = min(cobertura + 0.15, 1);

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
// 9 - TERMINA A CUTSCENE
// =====================================

if (etapa == 9) {

    if (room != rm_beco_interno) exit;

    global.cutscene_bloqueio = false;
    global.cutscene_finalizada = true;

    instance_destroy();
    exit;
}

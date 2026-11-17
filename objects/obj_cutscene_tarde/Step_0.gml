
/// OBJ_CUTSCENE_TARDE - STEP COMPLETO

if (espera_clique > 0) {
    espera_clique--;
}

/// TESTE TEMPORARIO DA CUTSCENE

if (etapa == 0 && cobertura == 0) {
    show_debug_message("TESTE: cutscene comecou");
}

if (etapa == 1 && letras_narracao == 0) {
    show_debug_message("TESTE: entrou no time skip");
}

if (etapa == 3 && !preparado) {
    show_debug_message("TESTE: preparando rua beco depois");
}

if (etapa == 4 && obj_jogador.x < 27) {
    show_debug_message("TESTE: Celeste comecou a andar");
}


// =====================================
// ETAPA 0 - ESCURECE A TELA
// =====================================


if (cobertura >= 1) {

    etapa = 1;

    indice_time_skip = 0;
    texto_narracao = falas_time_skip[0];

    letras_narracao = 0;
    tempo_narracao = 0;

    show_debug_message(
        "CUTSCENE: entrou na narracao do time skip"
    );
}


   exit;




// =====================================
// ETAPA 1 - TIME SKIP NA TELA PRETA
// =====================================

if (etapa == 1) {

    // Mantem a tela preta
    cobertura = 1;

    // Conta os frames da fala atual
    tempo_narracao++;

    // Letras aparecem gradualmente
    letras_narracao = min(
        letras_narracao + 1.2,
        string_length(texto_narracao)
    );

    // Evita pular a fala imediatamente
    if (tempo_narracao < 30) {
        exit;
    }

    // Avanca somente com clique
    if (mouse_check_button_pressed(mb_left)) {

        // Primeiro completa as letras
        if (
            letras_narracao <
            string_length(texto_narracao)
        ) {

            letras_narracao =
                string_length(texto_narracao);

        } else {

            // Passa para a proxima fala
            indice_time_skip++;

            if (
                indice_time_skip <
                array_length(falas_time_skip)
            ) {

                texto_narracao =
                    falas_time_skip[indice_time_skip];

                letras_narracao = 0;
                tempo_narracao = 0;

            } else {

                // Todas as falas terminaram
                // Agora pode revelar a rua
                etapa = 2;
            }
        }
    }

    exit;
}


// =====================================
// ETAPA 2 - TRANSPORTA PARA RUA_BECO
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
// ETAPA 3 - PREPARA O NOVO CENARIO
// =====================================

if (etapa == 3) {

    if (room != rua_beco) exit;
    if (!instance_exists(obj_jogador)) exit;

    if (!preparado) {

        // =================================
        // TROCA O FUNDO
        // =================================

        var _fundo = layer_get_id("Background");

        if (_fundo != -1) {

            layer_background_sprite(
                _fundo,
                spr_ruabeco_depois
            );
        }

        // =================================
        // ESCONDE PRIMEIRO PLANO ANTIGO
        // =================================

        var _frente =
            layer_get_id("Primeiro_Plano");

        if (_frente != -1) {
            layer_set_visible(_frente, false);
        }

        // =================================
        // REMOVE ELEMENTOS ANTIGOS
        // =================================

        with (obj_carro) {
            instance_destroy();
        }

        with (obj_gerador_carros) {
            instance_destroy();
        }

        with (obj_andante) {
            instance_destroy();
        }

        // =================================
        // IDENTIFICA A ENTRADA DO BECO
        // =================================

        if (instance_exists(obj_marcador_beco)) {

            var _marcador =
                instance_find(obj_marcador_beco, 0);

            // Centro da passagem de 64 pixels
            entrada_x = _marcador.x + 32;

            // Ponto para entrar no beco
            entrada_y = 94;

            // Para alinhada horizontalmente
            // com a entrada
            destino_x = entrada_x;

        } else {

            // Valores de seguranca
            entrada_x = 159;
            entrada_y = 94;
            destino_x = 159;
        }

        // =================================
        // POSICIONA CELESTE
        // =================================

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
    }

    // Revela o cenario
    cobertura = max(cobertura - 0.15, 0);

    if (cobertura <= 0) {
        etapa = 4;
    }

    exit;
}


// =====================================
// ETAPA 4 - CELESTE CAMINHA DEVAGAR
// =====================================

if (etapa == 4) {

    if (!instance_exists(obj_jogador)) exit;

    with (obj_jogador) {

        has_target = false;

        sprite_index = spr_perfil;
        image_xscale = abs(escala);

        if (x < other.destino_x) {

            // Caminhada mais lenta
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

    // Chegou na frente da entrada
    if (obj_jogador.x >= destino_x) {

        etapa = 5;
        fala_iniciada = false;
    }

    exit;
}


// =====================================
// ETAPA 5 - CELESTE ESCUTA ALGO
// =====================================

if (etapa == 5) {

    if (!fala_iniciada) {

        if (!instance_exists(obj_caixa_dialogo)) {

            instance_create_depth(
                0, 0, -1000,
                obj_caixa_dialogo
            );
        }

        global.caixa_texto =
            "Celeste: Hm...?";

        global.caixa_aberta = true;

        fala_iniciada = true;

    } else if (!global.caixa_aberta) {

        etapa = 6;
        fala_iniciada = false;
    }

    exit;
}


// =====================================
// ETAPA 6 - VIRA DE COSTAS
// =====================================

if (etapa == 6) {

    if (!fala_iniciada) {

        if (instance_exists(obj_jogador)) {

            with (obj_jogador) {

                sprite_index = spr_costas;
                image_xscale = abs(escala);

                image_speed = 0;
                image_index = 0;

                has_target = false;
            }
        }

        global.caixa_texto =
            "Celeste: Ué... Que barulho foi esse?";

        global.caixa_aberta = true;

        fala_iniciada = true;

    } else if (!global.caixa_aberta) {

        etapa = 7;
        fala_iniciada = false;
    }

    exit;
}


// =====================================
// ETAPA 7 - ENTRA NO BECO
// =====================================

if (etapa == 7) {

    if (!instance_exists(obj_jogador)) exit;

    with (obj_jogador) {

        has_target = false;

        var _dx = other.entrada_x - x;
        var _dy = other.entrada_y - y;

        var _dist = point_distance(
            x,
            y,
            other.entrada_x,
            other.entrada_y
        );

        if (_dist > 0.45) {

            // Movimento lento em direcao
            // ao interior do beco
            var _passo = min(0.45, _dist);

            x += (_dx / _dist) * _passo;
            y += (_dy / _dist) * _passo;

            sprite_index = spr_costas;
            image_xscale = abs(escala);
            image_speed = 0.12;

        } else {

            x = other.entrada_x;
            y = other.entrada_y;

            sprite_index = spr_costas;
            image_speed = 0;
            image_index = 0;
        }
    }

    // Chegou na entrada
    if (
        point_distance(
            obj_jogador.x,
            obj_jogador.y,
            entrada_x,
            entrada_y
        ) <= 0.45
    ) {

        etapa = 8;
    }

    exit;
}


// =====================================
// ETAPA 8 - ESCURECE AO ENTRAR
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
// ETAPA 9 - FINALIZA
// =====================================

if (etapa == 9) {

    if (room != rm_beco_interno) exit;

    global.cutscene_bloqueio = false;
    global.cutscene_finalizada = true;

    instance_destroy();
    exit;
}

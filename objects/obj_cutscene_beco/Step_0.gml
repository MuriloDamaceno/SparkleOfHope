
if (etapa == 0) {
    show_debug_message(
        "ROOM ATUAL: " + room_get_name(room)
    );

    show_debug_message(
        "TAMANHO: " +
        string(room_width) + " x " +
        string(room_height)
    );
}



/// OBJ_CUTSCENE_BECO - STEP

// =====================================
// ETAPA 0 - PREPARA A CENA
// =====================================

if (etapa == 0) {

    if (!instance_exists(obj_jogador)) {
        exit;
    }

    // Posiciona Celeste na entrada
    with (obj_jogador) {

        x = other.inicio_x;
        y = other.inicio_y;

        target_x = x;
        target_y = y;

        has_target = false;
        visible = true;

        sprite_index = spr_costas;
        image_xscale = abs(escala);

        image_speed = 0;
        image_index = 0;
    }

    // Inicia os sons em loop
    if (som_briga_id == -1) {

        som_briga_id = audio_play_sound(
            snd_briga,
            1,
            true,
            global.volume_sfx
        );
    }

    if (som_nuvem_id == -1) {

        som_nuvem_id = audio_play_sound(
            snd_fightcloud,
            1,
            true,
            global.volume_sfx
        );
    }

    etapa = 1;
    exit;
}


// =====================================
// ETAPA 1 - CAMINHA ATE A BRIGA
// =====================================

if (etapa == 1) {

    if (!instance_exists(obj_jogador)) {
        exit;
    }

    with (obj_jogador) {

        has_target = false;

        // Mantem Celeste de costas
        sprite_index = spr_costas;
        image_xscale = abs(escala);

        var _dist = point_distance(
            x,
            y,
            other.parada_x,
            other.parada_y
        );

        if (_dist > other.velocidade) {

            var _dir = point_direction(
                x,
                y,
                other.parada_x,
                other.parada_y
            );

            var _passo = min(
                other.velocidade,
                _dist
            );

            x += lengthdir_x(_passo, _dir);
            y += lengthdir_y(_passo, _dir);

            image_speed = 0.12;

        } else {

            x = other.parada_x;
            y = other.parada_y;

            image_speed = 0;
            image_index = 0;
        }
    }

    // Chegou perto da nuvem
    if (
        point_distance(
            obj_jogador.x,
            obj_jogador.y,
            parada_x,
            parada_y
        ) <= velocidade
    ) {

        etapa = 2;
        indice_fala = 0;
        fala_ativa = false;
    }

    exit;
}


// =====================================
// ETAPA 2 - CELESTE OBSERVA E FALA
// =====================================

if (etapa == 2) {

    if (!instance_exists(obj_jogador)) {
        exit;
    }

    // Mantem Celeste parada de costas
    with (obj_jogador) {

        has_target = false;
        sprite_index = spr_costas;
        image_xscale = abs(escala);

        image_speed = 0;
        image_index = 0;
    }

    if (!fala_ativa) {

        // Cria a caixa caso nao exista
        if (!instance_exists(obj_caixa_dialogo)) {

            instance_create_depth(
                0,
                0,
                -1000,
                obj_caixa_dialogo
            );
        }

        // Exibe a fala atual
        global.caixa_texto =
            falas[indice_fala];

        global.caixa_aberta = true;
        fala_ativa = true;

    } else if (!global.caixa_aberta) {

        indice_fala++;
        fala_ativa = false;

        if (indice_fala >= array_length(falas)) {

            etapa = 3;
        }
    }

    exit;
}




// =====================================
// ETAPA 3 - ABRIR A ESCOLHA
// =====================================

if (etapa == 3) {

    global.cutscene_bloqueio = true;

    // Mantem Celeste parada
    if (instance_exists(obj_jogador)) {

        with (obj_jogador) {
            has_target = false;
            sprite_index = spr_costas;
            image_speed = 0;
            image_index = 0;
        }
    }

    // Abre a interface de escolha
    if (!instance_exists(obj_escolha_animal)) {

        instance_create_depth(
            0, 0, -2000,
            obj_escolha_animal
        );
    }

    etapa = 4;
    exit;
}


// =====================================
// ETAPA 4 - AGUARDAR A DECISAO
// =====================================

if (etapa == 4) {

    global.cutscene_bloqueio = true;

    // Espera o jogador escolher
    if (global.animal_escolhido != 0) {

        etapa = 5;
        fala_ativa = false;
    }

    exit;
}


// =====================================
// ETAPA 5 - REAGIR A ESCOLHA
// =====================================

if (etapa == 5) {

    if (!fala_ativa) {

        if (!instance_exists(obj_caixa_dialogo)) {

            instance_create_depth(
                0, 0, -1000,
                obj_caixa_dialogo
            );
        }

        if (global.animal_escolhido == 1) {

            global.caixa_texto =
                "Celeste: Vou tentar afastar o gato!";

        } else {

            global.caixa_texto =
                "Celeste: Vou tentar afastar o cachorro!";
        }

        global.caixa_aberta = true;
        fala_ativa = true;

    } else if (!global.caixa_aberta) {

        etapa = 6;
    }

    exit;
}


// =====================================
// ETAPA 6 - AGUARDA A CONSEQUENCIA
// =====================================

if (etapa == 6) {

    // A escolha foi salva.
    // A briga continua ate criarmos
    // a cena que separa os animais.

    global.cutscene_bloqueio = true;

    exit;
}


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
// ETAPA 6 - PISCADA E FIM DA BRIGA
// =====================================

if (etapa == 6) {

    global.cutscene_bloqueio = true;

    piscada_tempo++;

    // Quando a tela estiver escura
    if (piscada_tempo == 10) {

        // Esconde a nuvem de briga
        var _camada = layer_get_id("Assets_1");

        if (_camada != -1) {
            layer_set_visible(_camada, false);
        }

        // Para os dois sons
        if (som_briga_id != -1) {
            audio_stop_sound(som_briga_id);
            som_briga_id = -1;
        }

        if (som_nuvem_id != -1) {
            audio_stop_sound(som_nuvem_id);
            som_nuvem_id = -1;
        }

        // Mostra o animal que permaneceu
        if (!instance_exists(obj_bichinho)) {

            instance_create_depth(
                120,
                140,
                50,
                obj_bichinho
            );
        }
    }

    // Termina a piscada
    if (piscada_tempo >= piscada_duracao) {
        etapa = 7;
    }

    exit;
}



// =====================================
// ETAPA 7 - PRIMEIRA INTERACAO
// =====================================

if (etapa == 7) {

    global.cutscene_bloqueio = true;

    // Abre a escolha de aproximacao
    if (!instance_exists(obj_escolha_aproximacao)) {

        instance_create_depth(
            0,
            0,
            -2000,
            obj_escolha_aproximacao
        );
    }

    etapa = 8;
    exit;
}


// =====================================
// ETAPA 8 - AGUARDA A ESCOLHA
// =====================================

if (etapa == 8) {

    global.cutscene_bloqueio = true;

    // Espera o jogador decidir
    if (global.escolha_aproximacao != 0) {

        etapa = 9;
    }

    exit;
}



// =====================================
// ETAPA 9 - PREPARA A REACAO
// =====================================

if (etapa == 9) {

    global.cutscene_bloqueio = true;

    // Zera o controle do dialogo
    fala_ativa = false;

    // Se escolheu aproximar-se
    if (global.escolha_aproximacao == 1) {

        // Celeste vai andar apenas 7 pixels
        passo_restante = 7;

        etapa = 10;

    } else {

        // Ficou parada, sem se aproximar
        etapa = 11;
    }

    exit;
}


// =====================================
// ETAPA 10 - CELESTE DA UM PASSINHO
// =====================================

if (etapa == 10) {

    if (!instance_exists(obj_jogador)) {
        exit;
    }

    if (!instance_exists(obj_bichinho)) {
        exit;
    }

    var _jogador = instance_find(obj_jogador, 0);
    var _bichinho = instance_find(obj_bichinho, 0);

    // Direcao do animal
    var _direcao = point_direction(
        _jogador.x,
        _jogador.y,
        _bichinho.x,
        _bichinho.y
    );

    // Passo pequeno e lento
    var _passo = min(0.45, passo_restante);

    _jogador.x += lengthdir_x(_passo, _direcao);
    _jogador.y += lengthdir_y(_passo, _direcao);

    _jogador.has_target = false;
    _jogador.sprite_index = spr_costas;
    _jogador.image_speed = 0.12;

    passo_restante -= _passo;

    // Terminou o passo
    if (passo_restante <= 0) {

        _jogador.image_speed = 0;
        _jogador.image_index = 0;

        etapa = 11;
    }

    exit;
}


// =====================================
// ETAPA 11 - REACAO DO ANIMAL
// =====================================

if (etapa == 11) {

    global.cutscene_bloqueio = true;

    if (!instance_exists(obj_bichinho)) {
        exit;
    }

    var _animal = instance_find(obj_bichinho, 0);

    // ---------------------------------
    // ESCOLHA 1 - APROXIMAR-SE
    // ---------------------------------

    if (global.escolha_aproximacao == 1) {

        // O animal continua assustado
        _animal.calmo = false;

        if (_animal.animal == 1) {

            // GATO
            _animal.sprite_index = gatobravo;

            audio_play_sound(
                snd_gatobravo,
                1,
                false,
                global.volume_sfx
            );

        } else {

            // CACHORRO
            _animal.sprite_index = cachorrobravo;

            audio_play_sound(
                snd_cachorrobravo,
                1,
                false,
                global.volume_sfx
            );
        }

        global.caixa_texto =
            "Celeste: Opa! Ta bom, nao vou chegar mais perto...";

    }

    // ---------------------------------
    // ESCOLHA 2 - FICAR ONDE ESTA
    // ---------------------------------

    else {

        // O animal comeca a confiar
        _animal.calmo = true;

        if (_animal.animal == 1) {

            // GATO
            _animal.sprite_index = spr_gatocalmo;

        } else {

            // CACHORRO
            _animal.sprite_index = spr_cachorrocalmo;
        }

        global.caixa_texto =
            "Celeste: Isso... Nao precisa ter medo.";
    }

    // Abre o dialogo da Celeste
    if (!instance_exists(obj_caixa_dialogo)) {

        instance_create_depth(
            0,
            0,
            -1000,
            obj_caixa_dialogo
        );
    }

    global.caixa_aberta = true;
    fala_ativa = true;

    etapa = 12;
    exit;
}


// =====================================
// ETAPA 12 - ESPERA O DIALOGO TERMINAR
// =====================================

if (etapa == 12) {

    global.cutscene_bloqueio = true;

    // Jogador terminou de ler a fala
    if (fala_ativa && !global.caixa_aberta) {

        fala_ativa = false;
        etapa = 13;
    }

    exit;
}



// =====================================
// ETAPA 13 - SEGUNDA ESCOLHA
// =====================================

if (etapa == 13) {

    global.cutscene_bloqueio = true;

    // Cria a interface de confianca
    if (!instance_exists(obj_escolha_confianca)) {

        instance_create_depth(
            0,
            0,
            -2000,
            obj_escolha_confianca
        );
    }

    etapa = 14;
    exit;
}


// =====================================
// ETAPA 14 - AGUARDA A ESCOLHA
// =====================================

if (etapa == 14) {

    global.cutscene_bloqueio = true;

    // Espera o jogador escolher
    if (global.escolha_confianca != 0) {

        etapa = 15;
    }

    exit;
}


// ETAPA 15 - O ANIMAL RECEBE CARINHO

if (etapa == 15) {
    global.cutscene_bloqueio = true;

    var _bichinho = instance_find(obj_bichinho, 0);

    if (_bichinho == noone) {
        global.cutscene_bloqueio = false;
        instance_destroy();
        exit;
    }

    _bichinho.calmo = true;

    var _nome;
    var _nome_som;

    if (_bichinho.animal == 1) {
        _nome = "O gato";
        _bichinho.sprite_index = spr_gatocalmo;
        _nome_som = "snd_gato_ronronando";
    } else {
        _nome = "O cachorro";
        _bichinho.sprite_index = spr_cachorrocalmo;
        _nome_som = "snd_cachorro_carinho";
    }

    if (global.escolha_confianca == 1) {
        global.caixa_texto =
            "Você estendeu a mão. " + _nome +
            " veio cheirá-la e se esfregou nos seus dedos. Você fez carinho nele.";
    } else {
        global.caixa_texto =
            "Você falou baixinho. " + _nome +
            " se aproximou ao ouvir sua voz. Você o acariciou de leve.";
    }

    // SOM DO CARINHO - toca uma vez quando a mensagem aparece.
    if (_bichinho.animal == 1) {
    falas_carinho = [
        "No segundo carinho, o gato se encolhe. Entre os pelos, você vê uma ferida fina em volta do pescoço.",
        "Celeste: Opa... Foi aí que doeu?",
        "Celeste: Parece marca de corda. Será que alguém amarrou você?",
        "Celeste: Tá bom. Só na testa, então.",
        "Você deixa a mão parada. Depois de um instante, o gato encosta a testa nos seus dedos outra vez."
    ];
} else {
    falas_carinho = [
        "No segundo carinho, sua mão passa pelo ombro do cachorro. Ele solta um ganido.",
        "Celeste: Ai, desculpa... Eu encostei bem em cima.",
        "Entre os pelos, você vê duas marcas compridas, uma ao lado da outra.",
        "Celeste: Que marcas são essas...? Alguém bateu em você?",
        "Você oferece a mão de novo. O cachorro cheira seus dedos e inclina a cabeça.",
        "Celeste: Atrás da orelha, né? Aqui você gosta."
    ];
}

indice_carinho = 0;
	var _som_carinho = asset_get_index(_nome_som);

    if (_som_carinho != -1) {
        audio_play_sound(_som_carinho, 1, false, global.volume_sfx);
    }

    if (!instance_exists(obj_caixa_dialogo)) {
        instance_create_depth(0, 0, -1000, obj_caixa_dialogo);
    }

    global.caixa_aberta = true;
    etapa = 16;
    exit;
}

// ETAPA 16 - Celeste percebe o machucado durante o carinho
if (etapa == 16) {
    global.cutscene_bloqueio = true;

    // Espera o jogador fechar a mensagem atual.
    if (global.caixa_aberta) exit;

    if (indice_carinho < array_length(falas_carinho)) {
        global.caixa_texto = falas_carinho[indice_carinho];
        indice_carinho++;
        global.caixa_aberta = true;
        exit;
    }

    global.caixa_texto =
        "Celeste: Vem, vamos sair daqui. Eu vou te ajudar.";
    global.caixa_aberta = true;
    etapa = 17;
    exit;
}


// ETAPA 17 - Espera o jogador terminar de ler a fala da Celeste
if (etapa == 17) {
    if (global.caixa_aberta) exit;
    if (!instance_exists(obj_jogador)) exit;

    companheiro = instance_find(obj_bichinho, 0);
    global.destino_bichinhos = 0;

    with (obj_jogador) {
    has_target = false;
    sprite_index = spr_frente;
    image_xscale = abs(escala);
    image_index = 0;
    image_speed = 0.12;
}

    etapa = 18;
    exit;
}


// ETAPA 18 - Celeste recua até sair pela parte de baixo do beco
if (etapa == 18) {
    var _celeste = instance_find(obj_jogador, 0);
    if (_celeste == noone) exit;

    // Mantém o mesmo X: ela só dá passos para trás.
    _celeste.y += 0.7;

    // Espera a Celeste desaparecer pela borda da tela.
    if (_celeste.bbox_top <= room_height) exit;

    // Na rua, ela reaparece na mesma entrada usada na ida.
    global.spawn_room = rua_beco;
    global.spawn_x = 138;
    global.spawn_y = 94;

    // O controlador da cena precisa acompanhar a troca de sala.
    persistent = true;
    etapa = 19;
    room_goto(rua_beco);
    exit;
}


// ETAPA 19 - Prepara a mesma rua noturna da ida
if (etapa == 19) {
    if (room != rua_beco) exit;

    var _celeste = instance_find(obj_jogador, 0);
    if (_celeste == noone) exit;

    persistent = false;

    var _camada = layer_get_id("Background");
    if (_camada != -1) {
        var _fundo = layer_background_get_id(_camada);
        if (_fundo != -1) {
            layer_background_sprite(_fundo, spr_ruabeco_depois);
            layer_background_visible(_fundo, true);
        }
    }

    var _frente = layer_get_id("Primeiro_Plano");
    if (_frente != -1) {
        layer_set_visible(_frente, false);
    }

    with (obj_gerador_carros) instance_destroy();
    with (obj_carro) instance_destroy();
    with (obj_andante) instance_destroy();

    _celeste.visible = true;
	_celeste.has_target = false;
	_celeste.sprite_index = spr_frente;
	_celeste.image_xscale = abs(_celeste.escala);
	_celeste.image_index = 0;
	_celeste.image_speed = 0.12;

    etapa = 20;
    exit;
}


// ETAPA 20 - Celeste para na calçada, pensa e escolhe o destino
if (etapa == 20) {
    var _celeste = instance_find(obj_jogador, 0);
    if (_celeste == noone) exit;

    if (!variable_instance_exists(id, "pensamento_calcada")) {
        pensamento_calcada = 0;
    }

    // Celeste termina de andar antes de abrir a primeira fala.
    if (pensamento_calcada == 0) {
        _celeste.y = min(_celeste.y + 0.5, 110);
        if (_celeste.y < 110) exit;

        _celeste.sprite_index = spr_frente;
        _celeste.image_xscale = abs(_celeste.escala);
        _celeste.image_speed = 0;
        _celeste.image_index = 0;

        if (!instance_exists(obj_caixa_dialogo)) {
            instance_create_depth(0, 0, -1000, obj_caixa_dialogo);
        }

        global.caixa_texto =
            "Celeste: A Hope deve saber o que fazer com esse machucado. Mas será que você aguenta andar até lá?";
        global.caixa_aberta = true;
        pensamento_calcada = 1;
        exit;
    }

    // Espera a caixa fechar e o jogador soltar o botão.
    // Assim o clique da fala não escolhe uma casa sem querer.
    if (global.caixa_aberta || mouse_check_button(mb_left)) exit;

    if (pensamento_calcada == 1) {
        global.caixa_texto = "Celeste: Mas minha casa é mais perto...";
        global.caixa_aberta = true;
        pensamento_calcada = 2;
        exit;
    }

    global.destino_bichinhos = 0;
    instance_create_depth(
        0, 0, -2000, obj_escolha_confianca,
        { modo_destino: true }
    );

    etapa = 21;
    exit;
}


// ETAPA 21 - Guarda a escolha e vira para a casa escolhida
if (etapa == 21) {
    if (global.destino_bichinhos == 0) exit;

    with (obj_jogador) {
        sprite_index = spr_perfil;
        image_speed = 0;
        image_index = 0;
        has_target = false;

        if (global.destino_bichinhos == 1) {
            image_xscale = -abs(escala); // Casa da Celeste: esquerda
        } else {
            image_xscale = abs(escala);  // Casa da Hope: direita
        }
    }

    // Celeste continua parada para a próxima parte da história.
    global.cutscene_bloqueio = true;
		tempo_final = 0;
		fade_final = 0;
		etapa = 22;
	exit;
}
// ETAPA 22 - Celeste olha para o lado escolhido por 2 segundos
if (etapa == 22) {
    tempo_final += delta_time / 1000000;

    if (tempo_final >= 2) {
        etapa = 23;
    }

    exit;
}

// ETAPA 23 - Escurece a tela e volta ao menu inicial
if (etapa == 23) {
    if (fade_final < 1) {
        fade_final = min(1, fade_final + delta_time / 1000000);
        exit;
    }

    // Prepara as missões para quem clicar em Iniciar de novo.
    global.cutscene_bloqueio = false;
    global.cutscene_iniciada = false;
    global.cutscene_finalizada = false;
    global.hope_concluida = false;
    global.lia_concluida = false;
    global.npc_beco_concluido = false;

    audio_stop_all();
    game_restart();
    exit;
}



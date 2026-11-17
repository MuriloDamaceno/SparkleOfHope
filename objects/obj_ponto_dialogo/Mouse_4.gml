
/// LEFT PRESSED - PONTO DE DIALOGO

if (global.caixa_aberta || instance_exists(Obj_inventario)) {
    exit;
}

if (!instance_exists(obj_jogador)) exit;

var _dist = point_distance(
    obj_jogador.x,
    obj_jogador.y,
    x, y
);

if (_dist > 75) exit;

// Garante que existe uma caixa
if (!instance_exists(obj_caixa_dialogo)) {
    instance_create_depth(0, 0, -1000, obj_caixa_dialogo);
}

// Para Celeste
with (obj_jogador) {
    has_target = false;
    image_speed = 0;
}

global.indo_para_porta = false;


// =====================================
// MORADOR DO BECO
// =====================================

if (room == rua_beco) {

    // Ainda nao recebeu a missao
    if (
        !variable_global_exists("hope_concluida") ||
        !global.hope_concluida
    ) {
        global.caixa_texto =
            "Parece que tem alguém em casa.";
        global.caixa_aberta = true;
        exit;
    }

    // Inicializa estado da missao
    if (!variable_global_exists("npc_beco_concluido")) {
        global.npc_beco_concluido = false;
    }

    // Conversa ja realizada
    if (global.npc_beco_concluido) {
        global.caixa_texto =
            "Morador: Já falei que devolvo amanhã!";
        global.caixa_aberta = true;
        exit;
    }

    // Sequencia de dialogos
    global.npc_beco_falas = [
        "Celeste: Oi! Estou ajudando a Hope, da biblioteca.",
        "Morador: Biblioteca? O que vocês querem agora?",
        "Celeste: Parece que o senhor está com um livro atrasado.",
        "Morador: Ah, aquele livro... Ainda nem terminei.",
        "Celeste: Já faz um tempo que o prazo venceu.",
        "Morador: Tá, tá. Não precisa fazer esse drama todo.",
        "Celeste: Então posso avisar que vai devolver?",
        "Morador: Pode. Amanhã eu passo lá. Agora me deixa em paz.",
        "Celeste: Certo... Obrigada."
    ];

    global.npc_beco_etapa = 0;
    global.npc_beco_ativo = true;

    global.caixa_texto = global.npc_beco_falas[0];
    global.caixa_aberta = true;

    exit;
}


// =====================================
// OUTROS PONTOS DE DIALOGO
// =====================================

global.caixa_texto = texto_dialogo;
global.caixa_aberta = true;

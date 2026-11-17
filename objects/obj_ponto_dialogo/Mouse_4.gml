
/// OBJ_PONTO_DIALOGO - LEFT PRESSED

if (global.caixa_aberta || instance_exists(Obj_inventario)) {
    exit;
}

if (!instance_exists(obj_jogador)) exit;

// Distancia de interacao
var _dist = point_distance(
    obj_jogador.x,
    obj_jogador.y,
    x, y
);

if (_dist > 75) exit;

// Garante a caixa de dialogo
if (!instance_exists(obj_caixa_dialogo)) {
    instance_create_depth(
        0, 0, -1000, obj_caixa_dialogo
    );
}

// Para Celeste
with (obj_jogador) {
    has_target = false;
    image_speed = 0;
}

global.indo_para_porta = false;


// =====================================
// CONVERSA COM LIA NO PATIO
// =====================================

if (
    room == rm_patio &&
    variable_global_exists("hope_concluida") &&
    global.hope_concluida
) {

    if (!variable_global_exists("lia_concluida")) {
        global.lia_concluida = false;
    }

    // Depois da primeira conversa
    if (global.lia_concluida) {

        global.caixa_texto =
            "Lia: Espero que os bichinhos estejam bem...";
        global.caixa_aberta = true;
        exit;
    }

    global.lia_falas = [
        "Celeste: Oi. Não sabia que você gostava de ler aqui.",
        "Lia: É mais tranquilo. Dentro de casa sempre tem alguém falando alguma coisa.",
        "Celeste: Que livro é esse?",
        "Lia: Um sobre animais. Peguei na biblioteca da Hope.",
        "Celeste: Engraçado... Acabei de sair de lá. Estou ajudando ela a cobrar uns livros atrasados.",
        "Lia: Então espero que não tenha vindo atrás do meu.",
        "Celeste: Não, não. Pelo menos acho que não.",
        "Lia: Ainda bem. Estou tentando terminar.",
        "Celeste: É interessante?",
        "Lia: É. Mas tem umas partes que me deixam triste.",
        "Celeste: Por quê?",
        "Lia: Porque fala de como os animais dependem da gente.",
        "Lia: E, mesmo assim, tem gente que trata eles como se fossem coisas.",
        "Celeste: É... Eu vi alguns cachorros na rua hoje.",
        "Lia: Eu também vejo. Todo dia.",
        "Lia: O estranho é que, depois de um tempo, a gente quase para de reparar.",
        "Celeste: Como assim?",
        "Lia: Sei lá. Um cachorro dormindo na calçada vira parte da paisagem.",
        "Lia: As pessoas desviam dele como desviam de uma pedra.",
        "Celeste: Nunca tinha pensado desse jeito.",
        "Lia: Ontem vi um cachorro esperando na frente de uma casa.",
        "Lia: Ficou horas lá. Talvez estivesse esperando alguém que nunca ia voltar.",
        "Celeste: Que triste...",
        "Lia: O pior é que eu passei por ele também. Não fiz nada.",
        "Celeste: Mas você não pode ajudar todos.",
        "Lia: Eu sei. Só fico pensando se a gente usa isso como desculpa para não ajudar nenhum.",
        "Celeste: Talvez... Mas fazer alguma coisa pequena ainda é melhor do que não fazer nada.",
        "Lia: É. Acho que sim.",
        "Celeste: Bom, preciso continuar com os livros. A Hope está contando comigo.",
        "Lia: Vai lá. E, Celeste... presta atenção nos bichinhos pelo caminho, tá?",
        "Celeste: Pode deixar."
    ];

    global.lia_etapa = 0;
    global.lia_ativa = true;

    global.caixa_texto = global.lia_falas[0];
    global.caixa_aberta = true;

    exit;
}


// =====================================
// CONVERSA COM MORADOR DO BECO
// =====================================

if (room == rua_beco) {

    if (
        !variable_global_exists("hope_concluida") ||
        !global.hope_concluida
    ) {

        global.caixa_texto =
            "Parece que tem alguém em casa.";
        global.caixa_aberta = true;
        exit;
    }

    if (!variable_global_exists("npc_beco_concluido")) {
        global.npc_beco_concluido = false;
    }

    if (global.npc_beco_concluido) {

        global.caixa_texto =
            "Morador: Já falei que devolvo amanhã!";
        global.caixa_aberta = true;
        exit;
    }

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
// DIALOGO ANTIGO DOS OUTROS CENARIOS
// =====================================

global.caixa_texto = texto_dialogo;
global.caixa_aberta = true;


/// LEFT PRESSED - HOPE

// Bloqueios
if (global.caixa_aberta) exit;
if (instance_exists(Obj_inventario)) exit;
if (!instance_exists(obj_jogador)) exit;

// Distancia ate a Hope
var _dist = point_distance(
    x, y,
    obj_jogador.x,
    obj_jogador.y
);

// Precisa estar perto
if (_dist > 180) {
    global.caixa_aberta = true;
    global.caixa_texto =
        "Preciso chegar mais perto da Hope.";
    exit;
}

// Se ja entregou o livro
if (global.hope_concluida) {

    global.caixa_aberta = true;
    global.caixa_texto =
        "Hope: Obrigada pela ajuda, querida!";

    exit;
}

// Verifica se possui o livro
if (!global.tem_livro) {

    global.caixa_aberta = true;
    global.caixa_texto =
        "Ainda preciso encontrar o livro para Hope.";

    exit;
}

// Dialogos da historia
global.hope_falas = [
    "Hope: Celeste! Que bom que chegou. Já estava começando a achar que tinha esquecido de mim.",
    "Celeste: Desculpa a demora... Tive que procurar aquele livro.",
    "Hope: Ah, então você trouxe! Sabia que podia contar com você.",
    "Celeste: Aqui está.",
    "Hope: Obrigada, querida. Aliás, será que pode me ajudar com mais uma coisinha?",
    "Celeste: O quê?",
    "Hope: Alguns livros estão atrasados. Você poderia passar nas casas aqui perto e lembrar o pessoal de devolver?",
    "Celeste: Claro, posso fazer isso.",
    "Hope: Ótimo! Tenho uma lista com os endereços. Não precisa ter pressa, está bem?",
    "Celeste: Tá bom. Já volto.",
    "Hope: Tome cuidado na rua, Celeste!"
];

// Inicia a conversa
global.hope_etapa = 0;
global.hope_conversa_ativa = true;

global.caixa_texto = global.hope_falas[0];
global.caixa_aberta = true;

// Interrompe movimento
with (obj_jogador) {
    has_target = false;
    image_speed = 0;
    image_index = 0;
}

global.indo_para_porta = false;

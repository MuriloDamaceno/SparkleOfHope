
/// LEFT PRESSED - CONVERSA COM HOPE

// Impede interacao durante outros dialogos
if (global.caixa_aberta) exit;

// Impede interacao com inventario aberto
if (instance_exists(Obj_inventario)) exit;

// Verifica se Celeste existe
if (!instance_exists(obj_jogador)) exit;

// So permite conversar se estiver perto
var _dist = point_distance(
    x, y,
    obj_jogador.x,
    obj_jogador.y
);

if (_dist > 120) exit;

// Se a entrega ja aconteceu, nao repete
if (global.hope_concluida) exit;

// Precisa ter o livro
if (!global.tem_livro) {
    global.caixa_aberta = true;
    global.caixa_texto =
        "Ainda preciso encontrar o livro para Hope.";
    exit;
}

// Sequencia completa de dialogos
global.hope_falas = [
    "Hope: Celeste! Que bom que chegou. Já estava começando a achar que tinha esquecido de mim.",
    " Desculpa a demora... Tive que procurar aquele livro.",
    "Hope: Ah, então você trouxe! Sabia que podia contar com você.",
    " Aqui está.",
    "Hope: Obrigada, querida. Aliás, será que pode me ajudar com mais uma coisinha?",
    ": O quê?",
    "Hope: Alguns livros estão atrasados. Você poderia passar nas casas aqui perto e lembrar o pessoal de devolver?",
    " Claro, posso fazer isso.",
    "Hope: Ótimo! Tenho uma lista com os endereços. Não precisa ter pressa, está bem?",
    " Tá bom. Já volto.",
    "Hope: Tome cuidado na rua, Celeste!"
];

// Comeca na primeira fala
global.hope_etapa = 0;
global.hope_conversa_ativa = true;

global.caixa_texto = global.hope_falas[0];
global.caixa_aberta = true;

// Para o movimento da Celeste
with (obj_jogador) {
    has_target = false;
    image_speed = 0;
    image_index = 0;
}

global.indo_para_porta = false;

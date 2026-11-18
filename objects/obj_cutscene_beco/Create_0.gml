
/// OBJ_CUTSCENE_BECO - CREATE

// 0 = preparar
// 1 = caminhar
// 2 = dialogos
// 3 = aguardando continuacao
etapa = 0;

// Posicoes
inicio_x = 158;
inicio_y = 244;

parada_x = 158;
parada_y = 226;

// Velocidade da caminhada
velocidade = 0.45;

// Dialogos
falas = [
    "Celeste: Mas o que está acontecendo aqui...?",
    "Celeste: Espera... São dois bichinhos brigando?",
    "Celeste: Ei! Vocês vão acabar se machucando!",
    "Celeste: Preciso fazer alguma coisa..."
];

indice_fala = 0;
fala_ativa = false;

// Controle dos sons
som_briga_id = -1;
som_nuvem_id = -1;

// Impede que o jogador controle a Celeste
global.cutscene_bloqueio = true;
global.caixa_aberta = false;
global.caixa_texto = "";
global.indo_para_porta = false;
global.porta_alvo = noone;


piscada_tempo = 0;
piscada_duracao = 22;

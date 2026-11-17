
/// OBJ_CUTSCENE_TARDE - CREATE


/// Mantem a cutscene viva durante a troca de rooms
persistent = true;

// Fundo novo atras da Celeste
depth = 250;



// Etapas da cutscene
etapa = 0;

preparado = false;
fala_ativa = false;
indice_fala = 0;

// Falas antes da caminhada
falas_time_skip = [
    "Celeste: Passei o resto da tarde visitando as casas da lista da Hope.",
    "Celeste: Algumas pessoas foram gentis. Outras nem quiseram me ouvir...",
    "Celeste: Pelo menos consegui resolver boa parte dos livros atrasados.",
    "Celeste: Acho que ta ficando tarde... Melhor voltar pra casa."
];

// Posicoes iniciais
destino_x = 159;
entrada_x = 159;
entrada_y = 94;

// Bloqueia o controle do jogador
global.cutscene_bloqueio = true;
global.indo_para_porta = false;

global.caixa_aberta = false;
global.caixa_texto = "";

if (instance_exists(obj_jogador)) {
    with (obj_jogador) {
        has_target = false;
        image_speed = 0;
    }
}

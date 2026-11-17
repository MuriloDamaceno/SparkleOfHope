
/// OBJ_CUTSCENE_TARDE - CREATE

persistent = true;
depth = -100000;

// 0 escurecer
// 1 narracao
// 2 mudar de room
// 3 revelar novo beco
// 4 caminhar
// 5 primeira reacao
// 6 olhar para o beco
// 7 entrar
// 8 escurecer
// 9 finalizar
etapa = 0;

cobertura = 0;
preparado = false;
fala_iniciada = false;

texto_narracao =
    "Celeste: Acho que tá ficando tarde... Melhor voltar pra casa.";

letras_narracao = 0;
espera_clique = 0;

destino_x = 90;
entrada_x = 127;
entrada_y = 105;

global.cutscene_bloqueio = true;
global.indo_para_porta = false;
global.porta_alvo = noone;

global.caixa_aberta = false;
global.caixa_texto = "";

if (instance_exists(obj_jogador)) {
    with (obj_jogador) {
        has_target = false;
        image_speed = 0;

        if (passo_som_id != -1) {
            audio_stop_sound(passo_som_id);
            passo_som_id = -1;
        }
    }
}

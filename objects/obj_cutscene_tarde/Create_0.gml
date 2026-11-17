
/// OBJ_CUTSCENE_TARDE - CREATE

persistent = true;
depth = -100000;

// 0 = escurecer
// 1 = fala na tela preta
// 2 = trocar para rua_beco
// 3 = revelar o cenario
// 4 = caminhar ate a entrada
// 5 = primeira reacao
// 6 = segunda reacao
// 7 = aproximar da entrada
// 8 = escurecer e entrar
// 9 = terminar
etapa = 0;

// 0 = transparente, 1 = preto
cobertura = 0;

// Texto da tela preta
texto_narracao =
    "Celeste: Acho que tá ficando tarde... Melhor voltar pra casa.";

letras_narracao = 0;

// Evita que um clique antigo avance a cena
espera_clique = 15;

// Ponto de parada
destino_x = 260;
entrada_x = 285;

// Controle das falas na rua
fala_iniciada = false;

// Bloqueia controles normais
global.cutscene_bloqueio = true;
global.indo_para_porta = false;

// Fecha qualquer interface remanescente
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

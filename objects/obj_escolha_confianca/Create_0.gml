
/// OBJ_ESCOLHA_CONFIANCA - CREATE

// Controle da escolha
// 0 = nenhuma
// 1 = estender a mao
// 2 = falar baixinho

if (!variable_instance_exists(id, "modo_destino")) {
    modo_destino = false;
}

if (modo_destino) {
    pergunta = "Para onde levar o bichinho?";
    texto_esquerda = "Casa da Celeste";
    texto_direita = "Casa da Hope";
} else {
    global.escolha_confianca = 0;
    pergunta = "Como tentar tranquilizá-lo?";
    texto_esquerda = "Estender a mão";
    texto_direita = "Falar baixinho";
}

// Impede Celeste de andar
global.cutscene_bloqueio = true;

// Tamanho da interface
var _w = display_get_gui_width();
var _h = display_get_gui_height();

// =====================================
// CAIXA PRINCIPAL
// =====================================

principal_w = _w * 0.48;
principal_h = _h * 0.10;

principal_x = (_w - principal_w) / 2;
principal_y = _h * 0.56;

// =====================================
// CAIXAS DAS OPCOES
// =====================================

opcao_w = _w * 0.23;
opcao_h = _h * 0.085;

// Posicoes horizontais
esquerda_x = _w * 0.26;
direita_x = _w * 0.51;

// Posicao vertical
opcoes_y = _h * 0.68;

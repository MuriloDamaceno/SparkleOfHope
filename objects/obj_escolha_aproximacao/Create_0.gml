
/// OBJ_ESCOLHA_APROXIMACAO - CREATE

// Controle da escolha
global.escolha_aproximacao = 0;
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

// Um pouco mais para baixo
principal_y = _h * 0.56;

// =====================================
// CAIXAS MENORES
// =====================================

opcao_w = _w * 0.23;
opcao_h = _h * 0.085;

// Posicoes horizontais
esquerda_x = _w * 0.26;
direita_x = _w * 0.51;

// Um pouco mais para baixo
opcoes_y = _h * 0.68;

if (room == rm_beco_interno) {
    var _descer = display_get_gui_height() * 0.10;
    principal_y += _descer;
    opcoes_y += _descer;
}
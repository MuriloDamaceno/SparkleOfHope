
/// OBJ_ESCOLHA_APROXIMACAO - CREATE

// 0 = nenhuma escolha
// 1 = aproximar-se
// 2 = ficar onde esta
global.escolha_aproximacao = 0;

global.cutscene_bloqueio = true;

// Tamanho da interface
var _w = display_get_gui_width();
var _h = display_get_gui_height();

// Caixa principal
principal_w = _w * 0.67;
principal_h = _h * 0.15;

principal_x = (_w - principal_w) / 2;
principal_y = _h * 0.43;

// Caixas das escolhas
opcao_w = _w * 0.31;
opcao_h = _h * 0.12;

esquerda_x = _w * 0.17;
direita_x = _w * 0.52;

opcoes_y = _h * 0.63;


/// OBJ_ESCOLHA_APROXIMACAO - CREATE

global.escolha_aproximacao = 0;
global.cutscene_bloqueio = true;

var _w = display_get_gui_width();
var _h = display_get_gui_height();

// Caixa principal
principal_w = _w * 0.48;
principal_h = _h * 0.10;

principal_x = (_w - principal_w) / 2;
principal_y = _h * 0.50;

// Caixas menores
opcao_w = _w * 0.23;
opcao_h = _h * 0.085;

esquerda_x = _w * 0.26;
direita_x = _w * 0.51;

opcoes_y = _h * 0.62;

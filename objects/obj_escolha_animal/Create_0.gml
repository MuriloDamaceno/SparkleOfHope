
/// OBJ_ESCOLHA_ANIMAL - CREATE

// Ainda nao foi feita nenhuma escolha
global.animal_escolhido = 0;

// Bloqueia o movimento durante a decisao
global.cutscene_bloqueio = true;

// Dimensoes da interface em coordenadas GUI
var _w = display_get_gui_width();
var _h = display_get_gui_height();

// Caixa principal
principal_w = _w * 0.67;
principal_h = _h * 0.15;
principal_x = (_w - principal_w) / 2;
principal_y = _h * 0.43;

// Duas caixas menores
opcao_w = _w * 0.31;
opcao_h = _h * 0.12;

gato_x = _w * 0.17;
cachorro_x = _w * 0.52;

opcoes_y = _h * 0.63;

if (room == rm_beco_interno) {
    var _descer = display_get_gui_height() * 0.10;
    principal_y += _descer;
    opcoes_y += _descer;
}
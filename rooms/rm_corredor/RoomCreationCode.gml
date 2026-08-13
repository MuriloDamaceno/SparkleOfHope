// Pega o tamanho real da janela/monitor em que o jogo está rodando
var _win_w = window_get_width();
var _win_h = window_get_height();
var _aspect = _win_w / _win_h;

// Altura da view fixa (mesma altura da room, pra nunca cortar o chão/teto)
var _view_h = 200;
var _view_w = _view_h * _aspect;

// Não deixa a view ficar maior que a própria room (senão aparece fundo vazio)
_view_w = min(_view_w, room_width);

view_enabled = true;
view_visible[0] = true;

view_wview[0] = _view_w;
view_hview[0] = _view_h;
view_wport[0] = _win_w;
view_hport[0] = _win_h;
view_xport[0] = 0;
view_yport[0] = 0;

camera_set_view_size(view_camera[0], _view_w, _view_h);
camera_set_view_target(view_camera[0], obj_jogador);
camera_set_view_border(view_camera[0], _view_w * 0.3, 0);

window_set_size(_win_w, _win_h);
surface_resize(application_surface, _win_w, _win_h);	

// OBJ_PONTO_DIALOGO - MOUSE LEFT PRESSED

// Impede interacao durante outros dialogos
// ou com o inventario aberto
if (global.caixa_aberta || instance_exists(Obj_inventario)) {
    exit;
}

// Para o movimento da protagonista
if (instance_exists(obj_jogador)) {
    with (obj_jogador) {
        has_target = false;
    }
}

global.indo_para_porta = false;

// Abre o dialogo
global.caixa_aberta = true;
global.caixa_texto = texto_dialogo;

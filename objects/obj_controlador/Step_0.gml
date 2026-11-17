
/// OBJ_CONTROLADOR - STEP
/// VERIFICA O INICIO DA CUTSCENE

if (!variable_global_exists("cutscene_iniciada")) {
    global.cutscene_iniciada = false;
}

if (!variable_global_exists("lia_concluida")) {
    global.lia_concluida = false;
}

if (!variable_global_exists("npc_beco_concluido")) {
    global.npc_beco_concluido = false;
}

if (!variable_global_exists("cutscene_bloqueio")) {
    global.cutscene_bloqueio = false;
}

// As duas conversas precisam estar concluidas
if (
    global.lia_concluida &&
    global.npc_beco_concluido &&
    !global.cutscene_iniciada &&
    !global.caixa_aberta
) {

    // Impede que aconteca duas vezes
    global.cutscene_iniciada = true;

    // Inicia a cutscene nesta room
    instance_create_depth(
        0, 0, -100000,
        obj_cutscene_tarde
    );
}

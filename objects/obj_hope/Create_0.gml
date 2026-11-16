
/// CREATE - HOPE

// Inicializa os estados apenas uma vez
if (!variable_global_exists("hope_concluida")) {
    global.hope_concluida = false;
}

if (!variable_global_exists("hope_conversa_ativa")) {
    global.hope_conversa_ativa = false;
}

global.hope_etapa = 0;

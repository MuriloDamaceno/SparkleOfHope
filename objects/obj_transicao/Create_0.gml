persistent = true;          // sobrevive à troca de room
global.em_transicao = true;
window_set_cursor(cr_default);

// ===== CONFIGURAÇÃO =====
dur_cobrir  = 0.55;   // segundos para cobrir a tela
dur_revelar = 0.55;   // segundos para revelar
linhas      = 12;     // quantidade de linhas (as colunas se ajustam para os blocos ficarem quadrados)

estado    = 0;        // 0 = cobrindo, 1 = trocando room, 2 = revelando
progresso = 0;        // 0 a 1
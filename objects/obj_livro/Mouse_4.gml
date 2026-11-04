
if (visible && !global.caixa_aberta) {

    // Registra que o livro foi coletado
    global.tem_livro = true;

    // Abre a caixa de diálogo
    global.caixa_aberta = true;

    // Texto que aparece ao pegar o livro
    global.caixa_texto = "Ah! O livro do urso marrom. . . Preciso devolver para a Hope!";

    // Remove o livro do cenário
    instance_destroy();
}

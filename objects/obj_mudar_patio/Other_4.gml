
/// OBJ_MUDAR_PATIO - ROOM START

if (room == rm_patio) {

    // Verifica se Celeste ja conversou com Hope
    if (
        variable_global_exists("hope_concluida") &&
        global.hope_concluida
    ) {

        // Muda o sprite do objeto que cobre o cenario
        with (obj_patio) {
            sprite_index = spr_patio_depois;
            image_index = 0;
        }

        // Muda tambem a imagem de fundo
        layer_background_sprite(
            layer_get_id("Background"),
            spr_patio_depois
        );

    } else {

        // Mantem o patio original antes da missao
        with (obj_patio) {
            sprite_index = spr_patio;
            image_index = 0;
        }

        layer_background_sprite(
            layer_get_id("Background"),
            spr_patio
        );
    }
}


// OBJ_CUTSCENE_BECO - CLEAN UP

// Para o primeiro som
if (som_briga_id != -1) {
    audio_stop_sound(som_briga_id);
}

// Para o segundo som
if (som_nuvem_id != -1) {
    audio_stop_sound(som_nuvem_id);
}

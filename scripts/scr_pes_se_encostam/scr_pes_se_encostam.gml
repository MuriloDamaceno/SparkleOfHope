function scr_pes_se_encostam(_a, _dx, _dy, _b) {
    var _ax = (_a.bbox_left + _a.bbox_right) * 0.5 + _dx;
    var _bx = (_b.bbox_left + _b.bbox_right) * 0.5;

    var _ay = _a.bbox_bottom + _dy;
    var _by = _b.bbox_bottom;

    var _raio_a = max(2, (_a.bbox_right - _a.bbox_left) * 0.30);
    var _raio_b = max(2, (_b.bbox_right - _b.bbox_left) * 0.30);

    return abs(_ax - _bx) < _raio_a + _raio_b
        && abs(_ay - _by) < 4;
}
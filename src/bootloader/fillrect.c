static const int pixelwidth = 1;
static const int pitch = 1;

static void fillrect(unsigned char *vram, unsigned char r, unsigned char g, unsigned char b, unsigned char w, unsigned char h) {
    unsigned char *where = vram;
    int i, j;
 
    for (i = 0; i < w; i++) {
        for (j = 0; j < h; j++) {
            //putpixel(vram, 64 + j, 64 + i, (r << 16) + (g << 8) + b);
            where[j*pixelwidth] = r;
            where[j*pixelwidth + 1] = g;
            where[j*pixelwidth + 2] = b;
        }
        where+=pitch;
    }
}

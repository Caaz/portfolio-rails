export class Artist {
    constructor(canvas, art) {
        this.canvas = canvas;
        this.ctx = canvas.getContext('2d');
        this.running = false;
        this.fps = 30;
        this.art = art;
        this.frame = 0;
    }
    
    begin() {
        if (!this.running) {
            this.running = true;
            this.draw();
        }
    }
    
    draw() {
        this.assertSize();
        this.ctx.clearRect(0, 0, this.canvas.width, this.canvas.height);
        this.art(this);
        if (this.running) {
            setTimeout(() => {
                this.frame++;
                requestAnimationFrame(() => this.draw());
            }, 1000 / this.fps);
        }
    }
    assertSize() {
        if(this.canvas.height !== this.canvas.offsetHeight) {
            this.canvas.height = this.canvas.offsetHeight;
        }
        if (this.canvas.width !== this.canvas.offsetWidth) {
            this.canvas.width = this.canvas.offsetWidth;
        }
    }
}
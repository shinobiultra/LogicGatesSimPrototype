WorkBench bench;

void setup() {
  size(1280, 720);
  bench = new WorkBench(0, 0);
  bench.displayGrid();
  bench.addPart(new Constant(new PVector(20, 20), 80, 100));
  bench.addPart(new Constant(new PVector(200, 20), 80, 100));
  bench.addPart(new AND(new PVector(200, 200), 80, 100));



  frameRate(30);
}

void draw() {
  background(255);
  bench.displayGrid();
  bench.renderAll();
}

void mouseDragged() {
  if (!bench.selectionActive) {
    bench.moveGrid(pmouseX - mouseX, pmouseY - mouseY);
  } else {
    bench.onDrag(mouseX - pmouseX, mouseY - pmouseY);
  }
  bench.dragging = true;
}

void mousePressed() {
  bench.onClick(mouseX, mouseY);
}

void mouseReleased() {
  bench.onRelease();
}

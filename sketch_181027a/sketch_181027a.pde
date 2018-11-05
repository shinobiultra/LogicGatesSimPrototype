WorkBench bench;

void setup() {
  size(1280, 720, P2D);
  bench = new WorkBench(0, 0);
  bench.displayGrid();
  bench.addPart(new Constant(new PVector(20, 20), 80, 100));
  bench.addPart(new Constant(new PVector(200, 20), 80, 100));
  bench.addPart(new AND(new PVector(200, 200), 80, 100));
  bench.addPart(new AND(new PVector(200, 400), 80, 100));
}

void draw() {
  background(255);
  bench.displayGrid();
  bench.renderAll();
}

void mouseDragged() {
  if (!bench.selectionActive && mouseButton == LEFT) {
    bench.moveGrid(pmouseX - mouseX, pmouseY - mouseY);
  } else if(mouseButton == LEFT) {
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

void keyPressed() {
  if (key == 'a' || key == 'A') {
    bench.addPart(new AND(new PVector(mouseX, mouseY).add(bench.origin), 80, 100));
  } else if (key == 'x' || key == 'X') {
    bench.addPart(new XOR(new PVector(mouseX, mouseY).add(bench.origin), 80, 100));
  } else if (key == 'o' || key == 'O') {
    bench.addPart(new OR(new PVector(mouseX, mouseY).add(bench.origin), 80, 100));
  } else if (key == 'n' || key == 'N') {
    bench.addPart(new NOT(new PVector(mouseX, mouseY).add(bench.origin), 80, 100));
  } else if (key == 'c' || key == 'C') {
    bench.addPart(new Constant(new PVector(mouseX, mouseY).add(bench.origin), 80, 100));
  } else if (key == 'p' || key == 'P') {
    bench.addPart(new Clock(new PVector(mouseX, mouseY).add(bench.origin), 80, 100, 1));
    bench.clocked = true;
    bench.clocks++;
  } else if (key == ' ') {
    bench.shouldTransmit = !bench.shouldTransmit;
  }
}

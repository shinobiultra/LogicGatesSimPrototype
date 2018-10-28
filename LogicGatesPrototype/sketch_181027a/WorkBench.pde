class WorkBench {
  PVector origin;
  float gridSpacing = 20;
  ArrayList<Chip> parts;
  ArrayList<Wire> wires;

  boolean selectionActive;
  Chip selectedChip;
  boolean dragging;
  boolean wiring;

  WorkBench(float initX, float initY) {
    origin = new PVector(initX, initY);
    parts = new ArrayList<Chip>();
    wires = new ArrayList<Wire>();
  }

  void addPart(Chip chip) {
    parts.add(chip);
  }

  void removePart(Chip remChip) {
    for (int i = 0; i < parts.size(); i++) {
      if (parts.get(i) == remChip) {
        parts.remove(i);
        break;
      }
    }
  }

  void renderAll() {
    for (Chip chip : parts) {
      chip.offsetPosition(origin);
      chip.render(origin);
      chip.calculateOutput();
    }
    displayWires();
  }

  void displayGrid() {
    stroke(60, 100);
    for (int x = 0 - int(origin.x % gridSpacing); x < width; x += gridSpacing) {
      line(x, 0, x, height);
    }

    for (int y = 0 - int(origin.y % gridSpacing); y < height; y += gridSpacing) {
      line(0, y, width, y);
    }
  }

  void displayWires() {
    for (Wire wire : wires) {
      wire.render();
      wire.transmit();
    }
  }

  void moveGrid(float dx, float dy) {
    origin.x += dx;
    origin.y += dy;
  }

  void onClick(float x, float y) {
    for (Chip chip : parts) {
      IOPort clicked = chip.IOPortClick(x, y);

      if (clicked != null && mouseButton == LEFT) {
        if (!wiring) {
          if (clicked.in) {
            wires.add(new Wire(chip.input[clicked.idx], false, chip));
          } else {
            wires.add(new Wire(chip.output[clicked.idx], true, chip));
          }
          wiring = true;
        } else {
          if (clicked.in) {
            wires.get(wires.size()-1).finish(chip.input[clicked.idx], true);
          } else {
            wires.get(wires.size()-1).finish(chip.output[clicked.idx], false);
          }
          wiring = false;
        }
      } else if (chip.isPointIn(x, y)) {
        selectedChip = chip;
        selectionActive = true;
        break;
      }
    }
    if (wiring && mouseButton == RIGHT) {
      wires.remove(wires.size()-1);
      wiring = false;
    }
  }

  void onDrag(float x, float y) {
    selectedChip.origPosition.add(x, y);
  }

  void onRelease() {
    if (!dragging && selectionActive) {
      selectedChip.onClick(mouseX, mouseY);
    }

    selectionActive = false;
    selectedChip = null;
    dragging = false;
  }
}

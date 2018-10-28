class WorkBench {
  PVector origin;
  float gridSpacing = 20;
  ArrayList<Chip> parts;
  ArrayList<Wire> wires;

  boolean selectionActive;
  Chip selectedChip;
  boolean dragging;
  boolean wiring;
  boolean shouldTransmit;
  boolean clocked;

  float timeScale;
  int time;
  WorkBench(float initX, float initY) {
    origin = new PVector(initX, initY);
    parts = new ArrayList<Chip>();
    wires = new ArrayList<Wire>();
    shouldTransmit = true;
    timeScale = 800;
    time = millis();
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
    strokeWeight(1);
    for (int x = 0 - int(origin.x % gridSpacing); x < width; x += gridSpacing) {
      line(x, 0, x, height);
    }

    for (int y = 0 - int(origin.y % gridSpacing); y < height; y += gridSpacing) {
      line(0, y, width, y);
    }
  }

  void displayWires() {
    int nowT = millis();
    boolean paused = !shouldTransmit;
    if (shouldTransmit && nowT - timeScale > time) {
      paused = false;
      time = nowT;
    }
    for (Wire wire : wires) {
      wire.render();
      if (!paused && clocked) {
        wire.transmit();
      }
    }
  }

  void moveGrid(float dx, float dy) {
    origin.x += dx;
    origin.y += dy;
  }

  void onClick(float x, float y) {
    Chip toDelete = null;
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
      } else if (chip.isPointIn(x, y) && mouseButton == LEFT) {
        selectedChip = chip;
        selectionActive = true;
        break;
      } else if (chip.isPointIn(x, y) && mouseButton == RIGHT) {
        toDelete = chip;
      }
    }
    if (wiring && mouseButton == RIGHT) {
      wires.remove(wires.size()-1);
      wiring = false;
    }
    if (toDelete != null) {
      parts.remove(toDelete);
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

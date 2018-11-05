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
  int clocks;

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
      chip.render();
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
    boolean paused = true;
    if (shouldTransmit && nowT - timeScale > time) {
      paused = false;
      time = nowT;
    }
    for (Wire wire : wires) {
      wire.render();
      if (!paused || (clocked && shouldTransmit)) {
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
            wires.get(wires.size()-1).finish(chip.input[clicked.idx], true, chip);
          } else {
            wires.get(wires.size()-1).finish(chip.output[clicked.idx], false, chip);
          }
          wiring = false;
        }
      } else if (chip.isPointIn(x, y)) {
        if (mouseButton == LEFT) {
          selectedChip = chip;
          selectionActive = true;
          break;
        } else if (mouseButton == RIGHT) {
          if (clicked == null) {
            toDelete = chip;
            if (chip instanceof Clock) {
              clocks--;
              if (clocks == 0) {
                clocked = false;
              }
            }
          } else {
            Wire wireToDelete = null;
            for (Wire wire : wires) {
              if (clicked == wire.input || clicked == wire.output) {
                wireToDelete = wire;
                break;
              }
            }
            if (wireToDelete != null) {
              wires.remove(wireToDelete);
            }
          }
        }
      }
    }
    if (wiring && mouseButton == RIGHT) {
      wires.remove(wires.size()-1);
      wiring = false;
    }
    if (toDelete != null) {
      ArrayList<Wire> toDeletes = new ArrayList<Wire>();
      for (Wire wire : wires) {
        if (wire.inpChip == toDelete || wire.outChip == toDelete) {
          toDeletes.add(wire);
        }
      }
      for (Wire wire : toDeletes) {
        wires.remove(wire);
      }
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
  
  ArrayList<Chip> partsInRegion(PVector topLeft, PVector bottomRight){
    ArrayList<Chip> partsInReg = new ArrayList<Chip>();
    for(Chip chip : parts){
      if(chip.position.x >= topLeft.x && chip.position.x <= bottomRight.x && chip.position.y >= topLeft.y && chip.position.y <= bottomRight.y){
        partsInReg.add(chip);
      }
    }
    return partsInReg;
  }
  
}

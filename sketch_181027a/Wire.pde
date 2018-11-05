class Wire {
  IOPort output;
  IOPort input;
  Chip inpChip;
  Chip outChip;

  int thickness = 8;
  color wireColor;
  boolean finished;
  boolean active;
  Wire(IOPort inputs, boolean fromStart, Chip startChip) {
    if (fromStart) { //drawing from output to input of a chip
      input = inputs;
      inpChip = startChip;
    } else {
      output = inputs;
      outChip = startChip;
    }
    finished = false;
    active = false;
    
    wireColor = color(random(200), 255, random(200)); // maybe leave this decision to someone less colorblind and anti-artistic
    /*int colChoice = int(random(3));
    if (colChoice == 0) {
      wireColor = color(255, random(255), random(255));
    } else if (colChoice == 1) {
      wireColor = color(random(255), 255, random(255)); // TO COLORFUL :/
    } else {
      wireColor = color(random(255), random(255), 255);
    }*/
  }

  boolean finish(IOPort outputs, boolean ending, Chip outputChip) {
    if (ending) {
      if (input == null) {
        return false;
      }
      output = outputs;
      outChip = outputChip;
    } else {
      if (output == null) {
        return false;
      }
      input = outputs;
      inpChip = outputChip;
    }
    finished = true;
    return true;
  }

  void render() {
    if (input != null) {
      active = input.state;
    }
    if (active) {
      stroke(255, 255, 0, 200);
    } else {
      stroke(wireColor, 200);
    }
    strokeWeight(thickness);
    if (!finished) {
      if (input != null) {
        line(input.position.x, input.position.y, mouseX, mouseY);
      } else {
        line(output.position.x, output.position.y, mouseX, mouseY);
      }
    } else {
      float xdiff = output.position.x - input.position.x;
      float ydiff = abs(output.position.y - input.position.y);
      if (xdiff >= abs(ydiff)) {
        line(input.position.x, input.position.y, output.position.x - ydiff, input.position.y);
        line(output.position.x - ydiff, input.position.y, output.position.x, output.position.y);
      } else {
        if (output.position.y >= input.position.y) {
          line(input.position.x, input.position.y, input.position.x, input.position.y - (xdiff - ydiff));
          line(input.position.x, input.position.y - (xdiff - ydiff), output.position.x, output.position.y);
        } else {
          line(input.position.x, input.position.y, input.position.x, input.position.y + (xdiff - ydiff));
          line(input.position.x, input.position.y + (xdiff - ydiff), output.position.x, output.position.y);
        }
      }
    }
    strokeWeight(1);
  }

  void transmit() {
    if (finished) {
      output.state = input.state;
    }
  }
}

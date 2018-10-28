class Wire {
  IOPort output;
  IOPort input;
  Chip inpChip;
  Chip outChip;

  int thickness = 8;
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
  }

  boolean finish(IOPort outputs, boolean ending) {
    if (ending) {
      if (input == null) {
        return false;
      }
      output = outputs;
    } else {
      if (output == null) {
        return false;
      }
      input = outputs;
    }
    finished = true;
    return true;
  }

  void render() {
    if (input != null) {
      active = input.state;
    }
    if (active) {
      stroke(255, 255, 0);
    } else {
      stroke(60);
    }
    strokeWeight(thickness);
    if (!finished) {
      if (input != null) {
        line(input.position.x, input.position.y, mouseX, mouseY);
      } else {
        line(output.position.x, output.position.y, mouseX, mouseY);
      }
    } else {
      line(input.position.x, input.position.y, output.position.x, output.position.y);
    }
    strokeWeight(1);
  }

  void transmit() {
    if (finished) {
      output.state = input.state;
    }
  }
}

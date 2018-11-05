class Constant extends Chip {
  float thick;
  Constant(PVector initPosition, float initWidth, float initHeight) {
    origPosition = initPosition;
    position = origPosition.copy();
    Width = initWidth;
    Height = initHeight;
    thick = Width / 10;

    inputs = 0;
    outputs = 1;

    createIOPorts();
    output[0].state = false;
  }

  void render() {
    fill(100);
    stroke(0);
    strokeWeight(1);
    rect(position.x, position.y, Width, Height);
    if (output[0].state) {
      fill(#FFF062);
    } else {
      fill(255);
    }
    rect(position.x + thick, position.y + thick, Width - thick*2, Height - thick*2);

    renderIOPorts();
  }

  void state(boolean out) {
    output[0].state = out;
  }

  boolean isPointIn(float x, float y) {
    if ((x <= position.x + Width + IOSize/2 && x > position.x - IOSize/2) && (y <= position.y + Width + IOSize/2 && y > position.y - IOSize/2)) {
      return true;
    }
    return false;
  }

  void onClick(float x, float y) {
    if (IOPortClick(x, y) == null) {
      state(!output[0].state);
    } else {
    }
  }

  void calculateOutput() {
    //nothing cuz it's constant ya know
  }
}

class AND extends Chip {
  AND(PVector initPosition, float initWidth, float initHeight) {
    origPosition = initPosition;
    position = origPosition.copy();
    Width = initWidth;
    Height = initHeight;

    inputs = 2;
    outputs = 1;

    createIOPorts();
    output[0].state = false;
  }

  void render() {
    int divRatio = 2;
    fill(100);
    stroke(0);
    strokeWeight(1);
    if (output[0].state) {
      fill(#FFF062);
    } else {
      fill(255);
    }
    rect(position.x, position.y, Width / divRatio, Height);
    arc(position.x + Width / divRatio, position.y + Height / 2, Width, Height, -PI/2, PI/2);

    renderIOPorts();
  }

  void calculateOutput() {
    output[0].state = input[0].state && input[1].state;
  }

  boolean isPointIn(float x, float y) {
    if ((x <= position.x + Width + IOSize/2 && x > position.x - IOSize/2) && (y <= position.y + Width + IOSize/2 && y > position.y - IOSize/2)) {
      return true;
    }
    return false;
  }

  void onClick(float x, float y) {
    //pass
  }
}

class OR extends Chip {
  OR(PVector initPosition, float initWidth, float initHeight) {
    origPosition = initPosition;
    position = origPosition.copy();
    Width = initWidth;
    Height = initHeight;

    inputs = 2;
    outputs = 1;

    createIOPorts();
    output[0].state = false;
  }

  void render() { //TO FUCKING DO!!!
    stroke(0);
    strokeWeight(1);
    if (output[0].state) {
      fill(#FFF062);
    } else {
      fill(255);
    }
    arc(position.x, position.y + Height / 2, Width * 2, Height, -PI/2, PI/2);
    noFill();
    arc(position.x - Width / 4, position.y + Height / 2, Width, Height, -PI/3, PI/3);
    renderIOPorts();
  }

  void calculateOutput() {
    output[0].state = input[0].state || input[1].state;
  }

  boolean isPointIn(float x, float y) {
    if ((x <= position.x + Width + IOSize/2 && x > position.x - IOSize/2) && (y <= position.y + Width + IOSize/2 && y > position.y - IOSize/2)) {
      return true;
    }
    return false;
  }

  void onClick(float x, float y) {
    //pass
  }
}

class XOR extends Chip {
  XOR(PVector initPosition, float initWidth, float initHeight) {
    origPosition = initPosition;
    position = origPosition.copy();
    Width = initWidth;
    Height = initHeight;

    inputs = 2;
    outputs = 1;

    createIOPorts();
    output[0].state = false;
  }

  void render() {
    float thick = 20;
    fill(0, 255, 255);
    stroke(0);
    strokeWeight(1);
    rect(position.x, position.y, Width, Height);
    if (output[0].state) {
      fill(#FFF062);
    } else {
      fill(255);
    }
    rect(position.x + thick, position.y + thick, Width - thick*2, Height - thick*2);

    renderIOPorts();
  }

  void calculateOutput() {
    output[0].state = !(input[0].state && input[1].state) && (input[0].state || input[1].state);
  }

  boolean isPointIn(float x, float y) {
    if ((x <= position.x + Width + IOSize/2 && x > position.x - IOSize/2) && (y <= position.y + Width + IOSize/2 && y > position.y - IOSize/2)) {
      return true;
    }
    return false;
  }

  void onClick(float x, float y) {
    //pass
  }
}

class NOT extends Chip {
  NOT(PVector initPosition, float initWidth, float initHeight) {
    origPosition = initPosition;
    position = origPosition.copy();
    Width = initWidth;
    Height = initHeight;

    inputs = 1;
    outputs = 1;

    createIOPorts();
    output[0].state = false;
  }

  void render() {
    stroke(0);
    strokeWeight(2);
    if (output[0].state) {
      fill(#FFF062);
    } else {
      fill(255);
    }
    triangle(position.x, position.y, position.x, position.y + Height, position.x + Width, position.y + Height/2);

    renderIOPorts();
  }

  void calculateOutput() {
    output[0].state = !input[0].state;
  }

  boolean isPointIn(float x, float y) {
    if ((x <= position.x + Width + IOSize/2 && x > position.x - IOSize/2) && (y <= position.y + Width + IOSize/2 && y > position.y - IOSize/2)) {
      return true;
    }
    return false;
  }

  void onClick(float x, float y) {
    //pass
  }
}

class Clock extends Chip {
  float thick;
  int time;
  float frequency;
  Clock(PVector initPosition, float initWidth, float initHeight, float initFrequency) {
    origPosition = initPosition;
    position = origPosition.copy();
    Width = initWidth;
    Height = initHeight;
    thick = Width / 10;
    frequency = initFrequency;
    time = millis();

    inputs = 0;
    outputs = 1;

    createIOPorts();
    output[0].state = false;
  }

  void render() {
    fill(255, 80, 255);
    stroke(0);
    strokeWeight(1);
    rect(position.x, position.y, Width, Height);
    if (output[0].state) {
      fill(#FFF062);
    } else {
      fill(255);
    }
    rect(position.x + thick, position.y + thick, Width - thick*2, Height - thick*2);

    renderIOPorts();
  }

  void state(boolean out) {
    output[0].state = out;
  }

  boolean isPointIn(float x, float y) {
    if ((x <= position.x + Width + IOSize/2 && x > position.x - IOSize/2) && (y <= position.y + Width + IOSize/2 && y > position.y - IOSize/2)) {
      return true;
    }
    return false;
  }

  void onClick(float x, float y) {
    // pass
  }

  void calculateOutput() {
    int nowT = millis();
    if (nowT - time > 1000 / frequency) {
      output[0].state = !output[0].state; 
      time = nowT;
    }
  }
}

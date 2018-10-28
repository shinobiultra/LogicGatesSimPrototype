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

  void render(PVector origin) {
    fill(100);
    stroke(0);
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
  
  void calculateOutput(){
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

  void render(PVector origin) {
    float thick = 20;
    fill(100);
    stroke(0);
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

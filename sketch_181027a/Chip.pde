public abstract class Chip {
  PVector position;
  PVector origPosition;
  PImage sprite;
  String name;

  float Width;
  float Height;

  int inputs;
  int outputs;

  float IOSize = 15;

  IOPort input[];
  IOPort output[];

  abstract void render();
  abstract boolean isPointIn(float x, float y);
  abstract void onClick(float x, float y);
  abstract void calculateOutput();

  protected void createIOPorts() {
    input = new IOPort[inputs];
    output = new IOPort[outputs];

    int inpSpacing = int(Height / (inputs + 1));
    int idx = 0;
    for (int y = int(position.y) + inpSpacing; y < position.y + Height-1; y += inpSpacing) {
      input[idx] = new IOPort(position, 0, inpSpacing*(idx+1), idx);
      input[idx].in = true;
      idx++;
    }

    int outSpacing = int(Height / (outputs + 1));
    idx = 0;
    for (int y = int(position.y) + outSpacing; y < position.y + Height-1; y += outSpacing) {
      output[idx] = new IOPort(position, Width, outSpacing*(idx+1), idx);
      output[idx].in = false;
      idx++;
    }
  }

  protected void renderIOPorts() {
    for (IOPort inPort : input) {
      inPort.render();
    }

    for (IOPort outPort : output) {
      outPort.render();
    }
  }

  protected void offsetPosition(PVector origin) {
    position.set(PVector.sub(origPosition, origin));
  }

  IOPort IOPortClick(float x, float y) {
    for (IOPort port : input) {
      if ((x <= port.position.x + port.radius/2 && x > port.position.x - port.radius/2) && (y <= port.position.y + port.radius/2 && y > port.position.y - port.radius/2)) {
        return port;
      }
    }
    for (IOPort port : output) {
      if ((x <= port.position.x + port.radius/2 && x > port.position.x - port.radius/2) && (y <= port.position.y + port.radius/2 && y > port.position.y - port.radius/2)) {
        return port;
      }
    }
    return null;
  }
}

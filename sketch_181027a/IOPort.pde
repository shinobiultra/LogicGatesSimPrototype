class IOPort {
  PVector position;
  PVector origPosition;
  float xoff, yoff;
  boolean state;
  boolean in;
  float radius;
  color col;
  int idx;

  IOPort(PVector initPosition, float xOffset, float yOffset, int initIdx) {
    origPosition = initPosition;
    xoff = xOffset;
    yoff = yOffset;
    idx = initIdx;

    radius = 15;
    col = color(255);
  }

  void render() {
    position = origPosition.copy().add(xoff, yoff);

    fill(col);
    stroke(60);
    ellipse(position.x, position.y, radius, radius);
  }
}

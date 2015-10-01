boolean circlesDrawn = false; // create flag to only draw cirles one time
boolean polygonsDrawn = false; // create flag to only polygons cirles one time
color backgroundColor = color(220, 227, 228); // background color for the sketch

void setup() {
  size(800, 800); // determine how large sketch should be
  background(backgroundColor); //gray background
  smooth(); // standard value in processing 2 so actually not needed
  frameRate(30); // setup frame rate
}

void draw() {

  //println(circlesDrawn);

  if (!circlesDrawn) { // if circles haven't been drawn yet -> draw them!
    drawCirclesWithPattern();
  }

  if (!polygonsDrawn) { // if polygons haven't been drawn yet -> draw them!
    drawPolygonPattern(50); // draw polygons with size of 50
  }
}

color[] generateColorsWithVariation(color[] myColors) { // generate rgb color with slight offset from given rgb color

  for (int i = 0; i < myColors.length; i++) {

    float variationValue = random(0.8, 1.2);

    int minValue = 50;
    int maxValue = 200;

    float newColorR = constrain(red(myColors[i]) * variationValue, minValue, maxValue);
    float newColorG = constrain(green(myColors[i]) * variationValue, minValue, maxValue);
    float newColorB = constrain(blue(myColors[i]) * variationValue, minValue, maxValue);

    color newColor = color(newColorR, newColorG, newColorB, alpha(myColors[i]));

    myColors[i] = newColor;
  }

  return myColors; // return calculated new colors
}

void drawCirclesWithPattern() {
  
  int circleAmount = 6; // how many circles do we want
  color[] circleColors = { // setup colors to start with
    color(88, 198, 147) /*grün*/, color(216, 63, 170) /*pink*/, color(78, 144, 218) /*blau*/, color(255, 226, 0) /*gelb*/, color(216, 63, 63) /*rot*/, color(13, 255, 231) /*türkis*/
  }   
;

  for (int i=0; i < circleAmount; i++) {

    float circleDiameter = random(200, 400); // random value between 200 & 400
    float posX = random(circleDiameter/2, width - circleDiameter/2); // random xValue on screen -> but takes care that circle is fully on screen
    float posY = random(circleDiameter/2, height - circleDiameter/2); // random yValue on screen -> but takes care that circle is fully on screen
    color[] variatedColors = generateColorsWithVariation(circleColors); // generate new colors with variation utilizing the helper method generateColorsWithVariation()

    fill(generateColorsWithVariation(circleColors)[int(random(0, 5))], int(random(50, 150))); // fill with slighty randomized colors
    stroke(255); // set white stroke
    ellipse(posX, posY, circleDiameter, circleDiameter); // finally draw circles
  }

  circlesDrawn = true; // set flag to true, so circles will only be drawn once
}

// helper method to draw polygon
void polygon(int n, float cx, float cy, float r) { // takes arguments: n = number of edges, cx = xPosition, cy = yPosition, r = radius
  float angle = 360.0 / n;

  beginShape();
  for (int i = 0; i < n; i++)
  {
    vertex(cx + r * cos(radians(angle * i)), 
    cy + r * sin(radians(angle * i)));
  }
  endShape(CLOSE);
}

void drawPolygonPattern(int polygonSize) { // draw polygons on the whole screen with given size

  float screenWidth = width; // get width of sketch
  float screenHeight = width; // get height of sketch
  float offset = polygonSize * 2; // set how far polygons should be away from each other
 
  int polygonAmountX = int(screenWidth / polygonSize) / 2; // calculate how many polygons we need in X direction and divide by 2
  int polygonAmountY= int(screenHeight / polygonSize); // calculate how many polygons we need in Y direction

  // create loop and draw polygons with calculated offset until calculated polygon amount is reached
  for (int i = 1; i < polygonAmountX; i++) {

    float xOffset = int(offset * (i-1)) * 2 * random(0.8, 1.2);

    for (int j = 1; j < polygonAmountY; j++) {

      int yOffset = int(offset * (j-1));
      float randomize = random(1, 1); // generate some offset if wanted -> currently deactivated

      noFill(); // don't fill pur polygons
      stroke(backgroundColor); // give same stroke as background color
      polygon(4, xOffset * randomize, yOffset * randomize, polygonSize); // draw our polygons
    }
  }
  
  polygonsDrawn = true; // set flag to true, so polygons will only be drawn once
}


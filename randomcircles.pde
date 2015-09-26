boolean circlesDrawn = false;
boolean polygonsDrawn = false;
color backgroundColor = color(220, 227, 228);

  // setup background

void setup() {
  size(800, 800);
  background(backgroundColor); //gray background
  smooth(); // standard value in processing 2 so actually not needed
  frameRate(30);
}

void draw() {

  //println(circlesDrawn);

  if (!circlesDrawn) {
    drawCirclesWithPattern();
  }

  if (!polygonsDrawn) {
    drawPolygonPattern(50);
  }
}

color[] generateColorsWithVariation(color[] myColors) {

  for (int i = 0; i < myColors.length; i++) {

      //create almost random place


    float variationValue = random(0.8, 1.2);

      //create values for colors

    int minValue = 50;
    int maxValue = 200;

      //create randomized colors

    float newColorR = constrain(red(myColors[i]) * variationValue, minValue, maxValue);
    float newColorG = constrain(green(myColors[i]) * variationValue, minValue, maxValue);
    float newColorB = constrain(blue(myColors[i]) * variationValue, minValue, maxValue);

    color newColor = color(newColorR, newColorG, newColorB, alpha(myColors[i]));

    myColors[i] = newColor;
  }

  return myColors;
}

void drawCirclesWithPattern() {
  
  int circleAmount = 6;
  color[] circleColors = {
    color(88, 198, 147) /*grün*/, color(216, 63, 170) /*pink*/, color(78, 144, 218) /*blau*/, color(255, 226, 0) /*gelb*/, color(216, 63, 63) /*rot*/, color(13, 255, 231) /*türkis*/
  }   
;

  for (int i=0; i < circleAmount; i++) {

    float circleDiameter = random(200, 400);
    float posX = random(circleDiameter/2, width - circleDiameter/2);
    float posY = random(circleDiameter/2, height - circleDiameter/2);
    color[] variatedColors = generateColorsWithVariation(circleColors);  

    fill(generateColorsWithVariation(circleColors)[int(random(0, 5))], int(random(50, 150)));
    stroke(255);
    ellipse(posX, posY, circleDiameter, circleDiameter);
  }

  circlesDrawn = true;
}

void polygon(int n, float cx, float cy, float r) {
  float angle = 360.0 / n;

  beginShape();
  for (int i = 0; i < n; i++)
  {
    vertex(cx + r * cos(radians(angle * i)), 
    cy + r * sin(radians(angle * i)));
  }
  endShape(CLOSE);
}

void drawPolygonPattern(int polygonSize) {

  float screenWidth = width;
  float screenHeight = width;
  float offset = polygonSize * 2;

  int polygonAmountX = int(screenWidth / polygonSize) / 2;
  int polygonAmountY= int(screenHeight / polygonSize);

  for (int i = 1; i < polygonAmountX; i++) {

    float xOffset = int(offset * (i-1)) * 2 * random(0.8, 1.2);

    for (int j = 1; j < polygonAmountY; j++) { // draw vertical

      int yOffset = int(offset * (j-1));
      float randomize = random(1, 1);

      noFill();
      stroke(backgroundColor);
      polygon(4, xOffset * randomize, yOffset * randomize, polygonSize);
    }
  }
  
  polygonsDrawn = true; // comment out to show awesomeness
}

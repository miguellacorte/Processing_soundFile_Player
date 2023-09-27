import ddf.minim.*;

Minim minim;
AudioPlayer player;


PFont hRegular, hItalic;
String trackLabel = "";
String textLabel = "";
boolean displayTitle = true;
int trackDuration;
int trackPosition;

void setup() {
  fullScreen();
  smooth();
  fill(0);
  hRegular = createFont("Helvetica", 60, false); // Regular font
  hItalic = loadFont("HelveticaItalic-60.vlw");
  textFont(hRegular);
  textSize(70);
  minim = new Minim(this);
}

void draw() {
  background(255);
  fill(0);  // Ensure text color is black
 
  if (displayTitle) {  
    textFont(createFont("Helvetica", 100));
    text("Collective silence", 40, 120);  
  }

  if (player != null && player.isPlaying()) {
    textFont(hRegular);
    displayTrackInfo();
    displayPlaybackAnimation();
  }

  if (!textLabel.equals("")) {
    fill(0);
    textFont(hRegular);

    String[] lines = splitTextLabel(textLabel);
    for (int i = 0; i < lines.length; i++) {
      text(lines[i], 80, height - 525 + i * 70);  // 70 is the text size, adjust if needed
    }
  }
}

void keyPressed() {
  if (player != null) {
    player.close();
    trackLabel = "";
  }


  switch (Character.toUpperCase(key)) {
  case 'E':
    textLabel = "Etel Adnan, Shifting the Silence, p.8."; 
     resetSound();
    break;
  case 'C':
    textLabel = "Claudia Rankine, Citizen, p.69.";
     resetSound();
    break;
  case 'L':
    textLabel = "Solmaz Sharif, Look, p.69.";
     resetSound();
    break;
  case 'H':
    textLabel = "Hn. Lyonga, The so-called Anglophone Problem - snapshots of a city in a predominantly English-speaking region— in the west of Cameroon.";
     resetSound();
    break;
  case 'A':
    textLabel = "Anne Carson, Autobiography of Red. p.66,67 and 71.";
     resetSound();
    break;
  case 'B':
    textLabel = "Bernard P. Dauenhauer, Silence, p.47.";
     resetSound();
    break;
  case 'D':
    textLabel = "Etel Adnan, Shifting the Silence, p.51.";
     resetSound();
    break;
  case 'W':
    textLabel = "David Wojnarowicz, Closer the Knives, In the Shadow of the American Dream, p .64,65 and 66.";
     resetSound();
    break;
  default:
    break;
  }

  switch(key) {
  case '1':
    player = minim.loadFile("01_geschwister (gedicht) charlotte milsch.wav");
    trackLabel = "Geschwister by Charlotte Milsch ";
    textLabel = "";  
    displayTitle = true;
    break;
  case '2':
    player = minim.loadFile("Beinen.wav");
    trackLabel = "Wie sagt Schwester mit den langen Beinen by Sgl";
    textLabel = "";  
    displayTitle = true;
    break;
  case '3':
    player = minim.loadFile("SWEEPING.wav");
    trackLabel = "Sweeping by Hn. Lyonga ";
    textLabel = "";  
    displayTitle = true;
    break;
  case '4':
    player = minim.loadFile("silence_substance");
    trackLabel = "Silence substance by Sylee Gore";
    textLabel = "";  
    displayTitle = true;
    break;
  case '5':
    player = minim.loadFile("180923.wav");
    trackLabel = "Schweigen by Inana Othman";
    textLabel = "";  
    displayTitle = true;
    break;
  case '6':
    player = minim.loadFile("Silence Dilution");
    trackLabel = "Silence Dilution by Sylee Gore";
    textLabel = "";  
    displayTitle = true;
    break;
  case '0':
    if (player != null) {
      player.pause();
      player.rewind();
    }
    trackLabel = "";
    displayTitle = false;  // Hide the title
    break;
  }

  if (player != null && key >= '1' && key <= '6') {
    player.play();
  }
}

void displayTrackInfo() {
  String[] parts = split(trackLabel, "by");

  if (parts.length == 2) {
    textFont(hItalic); // Set font to italic
    text(parts[0].trim(), 80, height - 475); // Displayed higher to accommodate two lines

    textFont(hRegular); // Set font back to regular
    text("by " + parts[1].trim(), 80, height - 400);
  } else {
    textFont(hRegular);
    text(trackLabel, 80, height - 525);
  }
}

String[] splitTextLabel(String label) {
  String[] words = split(label, ' ');
  ArrayList<String> lines = new ArrayList<String>();
  String currentLine = "";

  for (int i = 0; i < words.length; i++) {
    if (textWidth(currentLine + words[i]) < width - 160) {
      currentLine += words[i] + " ";
    } else {
      lines.add(currentLine);
      currentLine = words[i] + " ";
    }
  }
  lines.add(currentLine);  // Add the last line

  return lines.toArray(new String[0]);
}

void resetSound() {
    if (player != null) {
        player.pause();
        player.rewind();
    }
    trackLabel = "";
}


void displayPlaybackAnimation() {
  int barWidth = width - 200;
  int barHeight = 3;
  int barX = 100;
  int barY = int(height * 0.9);  // Positioned 10% higher on the canvas

  fill(230);
  rect(barX, barY, barWidth, barHeight, barHeight/2, barHeight/2, barHeight/2, barHeight/2); // Rounded edges

  trackPosition = player.position();
  trackDuration = player.length();
  float playbackRatio = float(trackPosition) / float(trackDuration);

  fill(150);
  rect(barX, barY, barWidth * playbackRatio, barHeight, barHeight/2, barHeight/2, barHeight/2, barHeight/2); // Rounded edges

  // Displaying time elapsed and time remaining
  textSize(25);
  fill(0);
  text(nf(trackPosition / 60000, 2) + ":" + nf((trackPosition / 1000) % 60, 2, 0), barX, barY + 30);
  text("-" + nf((trackDuration - trackPosition) / 60000, 2) + ":" + nf(((trackDuration - trackPosition) / 1000) % 60, 2, 0), barX + barWidth - 68, barY + 30);
}

import ddf.minim.*;

Minim minim;
AudioPlayer player;

PFont h;
String trackLabel = "";
int trackDuration;
int trackPosition;

void setup() {
  fullScreen();
  smooth();
  fill(0);
  h = createFont("Helvetica", 100);
  textFont(h);
  textSize(100);

  minim = new Minim(this);
}

void draw() {
  background(255);
  text("Collective silence", 40, 100);
  
  if (player != null && player.isPlaying()) {
    displayTrackInfo();
    displayPlaybackAnimation();
  }
}

void keyPressed() {
  if (player != null) {
    player.close();
    trackLabel = "";
  }
  
  switch(key) {
    case '1':
      player = minim.loadFile("01_geschwister (gedicht) charlotte milsch.wav");
      trackLabel = "track 1";
      break;
    case '2':
      player = minim.loadFile("Sgl - wie sagt Schwester mit den langen Beinen.m4a");
      trackLabel = "track 2";
      break;
    case '3':
      player = minim.loadFile("hn. lyonga - SWEEPING.wav");
      trackLabel = "track 3";
      break;
    case '4':
      player = minim.loadFile("silence_substance");
      trackLabel = "track 4";
      break;
    case '5':
      player = minim.loadFile("Inana_Schweigen_180923.m4a - maybe expert?");
      trackLabel = "track 5";
      break;
    case '6':
      player = minim.loadFile("Silence Dilution");
      trackLabel = "track 6";
      break;
    case '0':
      if (player != null) {
        player.pause();
        player.rewind();
      }
      trackLabel = "";
      break;
  }
  
  if (player != null && key >= '1' && key <= '6') {
    player.play();
  }
}

void displayTrackInfo() {
  text(trackLabel, 40, height - 200);
}

void displayPlaybackAnimation() {
  int barWidth = width - 200;
  int barHeight = 20;
  int barX = 100;
  int barY = height - 100;
  
  fill(200);
  rect(barX, barY, barWidth, barHeight);
  
  trackPosition = player.position();
  trackDuration = player.length();
  float playbackRatio = float(trackPosition) / float(trackDuration);
  
  fill(50);
  rect(barX, barY, barWidth * playbackRatio, barHeight);
  
  // Displaying time elapsed and time remaining
  int elapsedSeconds = trackPosition / 1000;
  int remainingSeconds = (trackDuration - trackPosition) / 1000;
  text(nf(elapsedSeconds / 60, 2) + ":" + nf(elapsedSeconds % 60, 2), barX - 100, barY + 15);
  text("-" + nf(remainingSeconds / 60, 2) + ":" + nf(remainingSeconds % 60, 2), barX + barWidth + 10, barY + 15);
}

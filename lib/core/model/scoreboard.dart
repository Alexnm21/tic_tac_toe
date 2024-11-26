class Scoreboard {
  int xScore;
  int oScore;
  int drawScore;

  Scoreboard({
    this.xScore = 0,
    this.oScore = 0,
    this.drawScore = 0,
  });

  void xWins() {
    xScore++;
  }

  void oWins() {
    oScore++;
  }

  void draw() {
    drawScore++;
  }

  void reset() {
    xScore = 0;
    oScore = 0;
    drawScore = 0;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'xScore': xScore,
      'oScore': oScore,
      'drawScore': drawScore,
    };
  }

  factory Scoreboard.fromMap(Map<String, dynamic> map) {
    return Scoreboard(
      xScore: map['xScore'] as int,
      oScore: map['oScore'] as int,
      drawScore: map['drawScore'] as int,
    );
  }
}

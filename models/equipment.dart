class Equipment {
  int level;
  int currentStar;
  bool isDestroyed;

  Equipment(this.level, this.currentStar) : isDestroyed = false;

  void upgradeStar() {
    if (currentStar < 25) {
      currentStar++;
    }
  }

  void decreaseStar() {
    if (currentStar > 0) {
      currentStar--;
    }
  }

  void destroy() {
    isDestroyed = true;
  }
}

class Equipment {
  int level;
  int currentStar;
  bool isDestroyed;

  Equipment(this.level, this.currentStar) : isDestroyed = false;

  void incrementStar() {
    if (currentStar < 25) {
      currentStar++;
    }
  }

  void decrementStar() {
    if (currentStar > 0) {
      currentStar--;
    }
  }

  void destroy() {
    isDestroyed = true;
  }
}

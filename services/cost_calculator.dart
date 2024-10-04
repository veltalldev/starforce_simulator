import 'dart:math';

class CostCalculator {
  static int calculateCost(int equipmentLevel, int currentStar) {
    double scale;
    int base;

    if (currentStar <= 9) {
      scale = 0.5;
      base = 2500;
    } else if (currentStar <= 14) {
      scale = 2.7;
      base = getBaseForStar(currentStar);
    } else {
      scale = 2.7;
      base = 20000;
    }

    return (100 *
            (pow(equipmentLevel, 3) * pow((currentStar + 1), scale) / base +
                10))
        .round();
  }

  static int getBaseForStar(int star) {
    switch (star) {
      case 10:
        return 40000;
      case 11:
        return 22000;
      case 12:
        return 15000;
      case 13:
        return 11000;
      case 14:
        return 7500;
      default:
        return 0;
    }
  }
}

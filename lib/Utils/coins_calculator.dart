class CoinCalculator {
  static int getCoins({required int id}) {
    if (id == 1)
      return 10;
    else if (id == 2)
      return 20;
    else if (id == 3)
      return 30;
    else if (id == 4)
      return 35;
    else if (id == 5)
      return 40;
    else if (id == 6)
      return 45;
    else if (id == 7) return 50;
    return 0;
  }
}

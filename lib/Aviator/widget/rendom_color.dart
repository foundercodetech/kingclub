import 'dart:math';
import 'dart:ui';

class RandomColor {
  Random random = Random();
  Color getColor() {
    return Color.fromARGB(random.nextInt(900), random.nextInt(900),
        random.nextInt(900), random.nextInt(900));
  }
}

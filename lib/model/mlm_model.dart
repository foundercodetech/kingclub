class Mlm {
  final String totalcommission;
  final List<Levelwisecommission> levelwisecommission;
  final String userId;
  final Userdata userdata;

  Mlm({
    required this.totalcommission,
    required this.levelwisecommission,
    required this.userId,
    required this.userdata,
  });

}

class Levelwisecommission {
  final String name;
  final double commission;

  Levelwisecommission({
    required this.name,
    required this.commission,
  });

}

class Userdata {
  final List<Level> level1;
  final List<Level> level2;
  final List<Level> level3;

  Userdata({
    required this.level1,
    required this.level2,
    required this.level3,
  });

}

class Level {
  final String userId;
  final String username;
  final String turnover;
  final double commission;

  Level({
    required this.userId,
    required this.username,
    required this.turnover,
    required this.commission,
  });

}

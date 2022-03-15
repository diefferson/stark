enum Level {
  DEBUG,
  INFO,
  ERROR,
  NONE,
}

class Logger {
  Logger({this.level = Level.INFO, this.customLogger});

  final Level level;
  final Function(dynamic)? customLogger;

  void log(Level level, msg) {
    if (canLog(level)) {
      if (customLogger != null) {
        customLogger!.call('Stark: $msg');
      } else {
        print('Stark: $msg');
      }
    }
  }

  bool canLog(Level level) => this.level == level || this.level == Level.DEBUG;

  void debug(msg) {
    log(Level.DEBUG, 'DEBUG - $msg');
  }

  void info(msg) {
    log(Level.INFO, 'INFO - $msg');
  }

  void error(msg) {
    log(Level.ERROR, 'ERROR - $msg');
  }
}

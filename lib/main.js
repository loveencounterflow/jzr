// Generated by CoffeeScript 1.12.4
(function() {
  var CND, TAP, _copy_regex, alert, badge, debug, echo, help, info, log, rpr, urge, warn, whisper, ƒ;

  CND = require('cnd');

  rpr = CND.rpr;

  badge = 'JZR/tests';

  log = CND.get_logger('plain', badge);

  info = CND.get_logger('info', badge);

  whisper = CND.get_logger('whisper', badge);

  alert = CND.get_logger('alert', badge);

  debug = CND.get_logger('debug', badge);

  warn = CND.get_logger('warn', badge);

  help = CND.get_logger('help', badge);

  urge = CND.get_logger('urge', badge);

  echo = CND.echo.bind(CND);

  ƒ = Array.from;

  TAP = require('tap');

  _copy_regex = function(regex, flags) {
    return new RegExp(regex.source, flags);
  };

  this.show = function(text, pattern) {
    var _, area_abs, area_rel, count, d, d_size, idxs, match, pattern_2, result, text_2, text_size;
    if ((match = text.match(pattern)) == null) {
      warn(text);
      return null;
    }
    _ = match[0], d = match[1];
    idxs = [];
    pattern_2 = RegExp("" + (CND.escape_regex(d)), "g");
    count = 0;
    while (result = pattern_2.exec(text)) {
      count += +1;
    }
    text_size = (Array.from(text)).length;
    d_size = (Array.from(d)).length;
    area_abs = d_size * count;
    area_rel = area_abs / text_size;
    help(CND.lime(d), CND.yellow(count), CND.steel(area_abs), CND.orange(area_rel.toFixed(2)), CND.blue(text));
    text_2 = text.replace(pattern_2, '_'.repeat(d_size));
    show(text_2, pattern);
    return null;
  };

}).call(this);

//# sourceMappingURL=main.js.map
// Generated by CoffeeScript 2.4.1
(function() {
  //###########################################################################################################
  var CND, MultiSet, _ngrams_from_chrs, alert, badge, debug, echo, help, info, log, rpr, urge, warn, whisper;

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

  MultiSet = require('mnemonist/multi-set');

  // #-----------------------------------------------------------------------------------------------------------
  // _copy_regex = ( regex, flags ) -> new RegExp regex.source, flags

  //-----------------------------------------------------------------------------------------------------------
  _ngrams_from_chrs = function(chrs, min, max) {
    var R, count, d, i, idx, idx_0, j, k, last_idx, ref, ref1, ref2, ref3, stop;
    count = chrs.length;
    R = [];
    last_idx = count - 1;
    if (count >= min) {
      for (d = i = ref = min, ref1 = max; (ref <= ref1 ? i <= ref1 : i >= ref1); d = ref <= ref1 ? ++i : --i) {
        if ((stop = count - d) >= 0) {
          for (idx_0 = j = 0, ref2 = count - d; (0 <= ref2 ? j <= ref2 : j >= ref2); idx_0 = 0 <= ref2 ? ++j : --j) {
            R.push(chrs.slice(idx_0, idx_0 + d));
          }
        }
      }
    }
    for (idx = k = 0, ref3 = R.length; (0 <= ref3 ? k < ref3 : k > ref3); idx = 0 <= ref3 ? ++k : --k) {
      //.........................................................................................................
      R[idx] = R[idx].join('');
    }
    //.........................................................................................................
    return R;
  };

  //-----------------------------------------------------------------------------------------------------------
  this.find_repetitions = function(text) {
    var R, area, chrs, d, d_size, degree, hit, ngrams, ref, text_length;
    R = [];
    chrs = Array.from(text);
    text_length = chrs.length;
    if (text_length < 2) {
      return R;
    }
    ngrams = MultiSet.from(_ngrams_from_chrs(chrs, 1, 6));
    // debug '32302', 'chrs', chrs
    debug('32302', 'ngrams', _ngrams_from_chrs(chrs, 1, 6));
    debug('32302', 'ngrams', ngrams);
    ref = (new Set(ngrams)).keys();
    //.........................................................................................................
    for (d of ref) {
      if ((degree = ngrams.multiplicity(d)) < 2) {
        continue;
      }
      d_size = (Array.from(d)).length;
      area = d_size * degree;
      hit = {
        d,
        length: d_size,
        area,
        degree
      };
      R.push(hit);
    }
    //.........................................................................................................
    R.sort(function(a, b) {
      var a_area, a_count, a_length, b_area, b_count, b_length;
      ({
        area: a_area,
        count: a_count,
        length: a_length
      } = a);
      ({
        area: b_area,
        count: b_count,
        length: b_length
      } = b);
      if (a_area < b_area) {
        //.......................................................................................................
        return +1;
      }
      if (a_area > b_area) {
        return -1;
      }
      if (a_length < b_length) {
        //.......................................................................................................
        return -1;
      }
      if (a_length > b_length) {
        return +1;
      }
      if (a_count < b_count) {
        //.......................................................................................................
        return +1;
      }
      if (a_count > b_count) {
        return -1;
      }
      //.......................................................................................................
      return 0;
    });
    //.........................................................................................................
    return R;
  };

}).call(this);

//# sourceMappingURL=main.js.map

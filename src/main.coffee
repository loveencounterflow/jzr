
############################################################################################################
CND                       = require 'cnd'
rpr                       = CND.rpr
badge                     = 'JZR/tests'
log                       = CND.get_logger 'plain',     badge
info                      = CND.get_logger 'info',      badge
whisper                   = CND.get_logger 'whisper',   badge
alert                     = CND.get_logger 'alert',     badge
debug                     = CND.get_logger 'debug',     badge
warn                      = CND.get_logger 'warn',      badge
help                      = CND.get_logger 'help',      badge
urge                      = CND.get_logger 'urge',      badge
echo                      = CND.echo.bind CND
MultiSet                  = require 'mnemonist/multi-set'

# #-----------------------------------------------------------------------------------------------------------
# _copy_regex = ( regex, flags ) -> new RegExp regex.source, flags

#-----------------------------------------------------------------------------------------------------------
_ngrams_from_chrs = ( chrs, min, max ) ->
  count     = chrs.length
  R         = []
  last_idx  = count - 1
  if count >= min
    for d in [ min .. max ]
      if ( stop = count - d ) >= 0
        for idx_0 in [ 0 .. count - d ]
          R.push chrs[ idx_0 ... idx_0 + d ]
  #.........................................................................................................
  R[ idx ] = R[ idx ].join '' for idx in [ 0 ... R.length ]
  #.........................................................................................................
  return R

#-----------------------------------------------------------------------------------------------------------
@find_repetitions = ( text ) ->
  R           = []
  chrs        = Array.from text
  text_length = chrs.length
  return R if text_length < 2
  ngrams      = MultiSet.from _ngrams_from_chrs chrs, 1, 6
  #.........................................................................................................
  for d from ( new Set ngrams ).keys()
    continue if ( degree = ngrams.multiplicity d ) < 2
    pattern_2       = /// #{CND.escape_regex d} ///g
    count           = 0
    count          += +1 while pattern_2.exec text
    continue if count < 2
    d_size          = ( Array.from d ).length
    area            = d_size * count
    coverage        = area / text_length
    hit             = { d, length: d_size, count, area, coverage, }
    R.push hit
  #.........................................................................................................
  R.sort ( a, b ) ->
    { area: a_area, count: a_count, length: a_length, } = a
    { area: b_area, count: b_count, length: b_length, } = b
    #.......................................................................................................
    return +1 if a_area     < b_area
    return -1 if a_area     > b_area
    #.......................................................................................................
    return -1 if a_length   < b_length
    return +1 if a_length   > b_length
    #.......................................................................................................
    return +1 if a_count    < b_count
    return -1 if a_count    > b_count
    #.......................................................................................................
    return  0
  #.........................................................................................................
  return R


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
#...........................................................................................................
JZR                       = require '../..'
TAP                       = require 'tap'

###
#-----------------------------------------------------------------------------------------------------------
TAP.test "additional 5", ( T ) ->
  probes_and_matchers = [
    ["xyz",[]]
    ["barbarbar",[{"d":"bar","length":3,"count":3,"area":9,"coverage":1},{"d":"ar","length":2,"count":3,"area":6,"coverage":0.6666666666666666},{"d":"arb","length":3,"count":2,"area":6,"coverage":0.6666666666666666},{"d":"rba","length":3,"count":2,"area":6,"coverage":0.6666666666666666},{"d":"r","length":1,"count":3,"area":3,"coverage":0.3333333333333333}]]
    ["abcdef",[]]
    ["foobarbarbar",[{"d":"bar","length":3,"count":3,"area":9,"coverage":0.75},{"d":"ar","length":2,"count":3,"area":6,"coverage":0.5},{"d":"arb","length":3,"count":2,"area":6,"coverage":0.5},{"d":"rba","length":3,"count":2,"area":6,"coverage":0.5},{"d":"r","length":1,"count":3,"area":3,"coverage":0.25},{"d":"o","length":1,"count":2,"area":2,"coverage":0.16666666666666666}]]
    ["",[]]
    ["oo",[{"d":"o","length":1,"count":2,"area":2,"coverage":1}]]
    ["foobarbarbarfoo",[{"d":"bar","length":3,"count":3,"area":9,"coverage":0.6},{"d":"ar","length":2,"count":3,"area":6,"coverage":0.4},{"d":"foo","length":3,"count":2,"area":6,"coverage":0.4},{"d":"arb","length":3,"count":2,"area":6,"coverage":0.4},{"d":"rba","length":3,"count":2,"area":6,"coverage":0.4},{"d":"o","length":1,"count":4,"area":4,"coverage":0.26666666666666666},{"d":"oo","length":2,"count":2,"area":4,"coverage":0.26666666666666666},{"d":"r","length":1,"count":3,"area":3,"coverage":0.2}]]
    ["foobarrbarrbarrfoo",[{"d":"barr","length":4,"count":3,"area":12,"coverage":0.6666666666666666},{"d":"arr","length":3,"count":3,"area":9,"coverage":0.5},{"d":"arrb","length":4,"count":2,"area":8,"coverage":0.4444444444444444},{"d":"rrba","length":4,"count":2,"area":8,"coverage":0.4444444444444444},{"d":"rbar","length":4,"count":2,"area":8,"coverage":0.4444444444444444},{"d":"r","length":1,"count":6,"area":6,"coverage":0.3333333333333333},{"d":"rr","length":2,"count":3,"area":6,"coverage":0.3333333333333333},{"d":"foo","length":3,"count":2,"area":6,"coverage":0.3333333333333333},{"d":"o","length":1,"count":4,"area":4,"coverage":0.2222222222222222},{"d":"oo","length":2,"count":2,"area":4,"coverage":0.2222222222222222}]]
    ["bannanana",[{"d":"an","length":2,"count":3,"area":6,"coverage":0.6666666666666666},{"d":"na","length":2,"count":3,"area":6,"coverage":0.6666666666666666},{"d":"n","length":1,"count":4,"area":4,"coverage":0.4444444444444444},{"d":"a","length":1,"count":4,"area":4,"coverage":0.4444444444444444}]]
    ["䀠目几几几",[{"d":"几","length":1,"count":3,"area":3,"coverage":0.6}]]
    ["䀠几乎目几乎几几几几乎",[{"d":"几","length":1,"count":6,"area":6,"coverage":0.5454545454545454},{"d":"几乎","length":2,"count":3,"area":6,"coverage":0.5454545454545454},{"d":"几几","length":2,"count":2,"area":4,"coverage":0.36363636363636365},{"d":"乎","length":1,"count":3,"area":3,"coverage":0.2727272727272727}]]
    ["几乎几乎几乎几乎",[{"d":"几乎","length":2,"count":4,"area":8,"coverage":1},{"d":"几乎几乎","length":4,"count":2,"area":8,"coverage":1},{"d":"乎几","length":2,"count":3,"area":6,"coverage":0.75},{"d":"乎几乎","length":3,"count":2,"area":6,"coverage":0.75},{"d":"乎","length":1,"count":4,"area":4,"coverage":0.5}]]
    ["几几几几乎䀠几乎目几乎",[{"d":"几","length":1,"count":6,"area":6,"coverage":0.5454545454545454},{"d":"几乎","length":2,"count":3,"area":6,"coverage":0.5454545454545454},{"d":"几几","length":2,"count":2,"area":4,"coverage":0.36363636363636365},{"d":"乎","length":1,"count":3,"area":3,"coverage":0.2727272727272727}]]
    ["barONEbarTWObarTHREE",[{"d":"bar","length":3,"count":3,"area":9,"coverage":0.45},{"d":"barT","length":4,"count":2,"area":8,"coverage":0.4},{"d":"ar","length":2,"count":3,"area":6,"coverage":0.3},{"d":"ba","length":2,"count":3,"area":6,"coverage":0.3},{"d":"arT","length":3,"count":2,"area":6,"coverage":0.3},{"d":"rT","length":2,"count":2,"area":4,"coverage":0.2},{"d":"r","length":1,"count":3,"area":3,"coverage":0.15},{"d":"E","length":1,"count":3,"area":3,"coverage":0.15},{"d":"b","length":1,"count":3,"area":3,"coverage":0.15},{"d":"O","length":1,"count":2,"area":2,"coverage":0.1},{"d":"T","length":1,"count":2,"area":2,"coverage":0.1}]]
    ["1baron3baron5baron0KING6KING7",[{"d":"baron","length":5,"count":3,"area":15,"coverage":0.5172413793103449},{"d":"aron","length":4,"count":3,"area":12,"coverage":0.41379310344827586},{"d":"baro","length":4,"count":3,"area":12,"coverage":0.41379310344827586},{"d":"ron","length":3,"count":3,"area":9,"coverage":0.3103448275862069},{"d":"bar","length":3,"count":3,"area":9,"coverage":0.3103448275862069},{"d":"KING","length":4,"count":2,"area":8,"coverage":0.27586206896551724},{"d":"on","length":2,"count":3,"area":6,"coverage":0.20689655172413793},{"d":"ba","length":2,"count":3,"area":6,"coverage":0.20689655172413793},{"d":"ING","length":3,"count":2,"area":6,"coverage":0.20689655172413793},{"d":"NG","length":2,"count":2,"area":4,"coverage":0.13793103448275862},{"d":"n","length":1,"count":3,"area":3,"coverage":0.10344827586206896},{"d":"b","length":1,"count":3,"area":3,"coverage":0.10344827586206896},{"d":"G","length":1,"count":2,"area":2,"coverage":0.06896551724137931}]]
    ["0KING1baron3baron5baron6KING7",[{"d":"baron","length":5,"count":3,"area":15,"coverage":0.5172413793103449},{"d":"baro","length":4,"count":3,"area":12,"coverage":0.41379310344827586},{"d":"aron","length":4,"count":3,"area":12,"coverage":0.41379310344827586},{"d":"bar","length":3,"count":3,"area":9,"coverage":0.3103448275862069},{"d":"ron","length":3,"count":3,"area":9,"coverage":0.3103448275862069},{"d":"KING","length":4,"count":2,"area":8,"coverage":0.27586206896551724},{"d":"ba","length":2,"count":3,"area":6,"coverage":0.20689655172413793},{"d":"on","length":2,"count":3,"area":6,"coverage":0.20689655172413793},{"d":"ING","length":3,"count":2,"area":6,"coverage":0.20689655172413793},{"d":"NG","length":2,"count":2,"area":4,"coverage":0.13793103448275862},{"d":"n","length":1,"count":3,"area":3,"coverage":0.10344827586206896},{"d":"b","length":1,"count":3,"area":3,"coverage":0.10344827586206896},{"d":"G","length":1,"count":2,"area":2,"coverage":0.06896551724137931}]]
    ["XXXOXXX0KING1baron2KING3baron4KING5baron6KING7XOX",[{"d":"KING","length":4,"count":4,"area":16,"coverage":0.32653061224489793},{"d":"baron","length":5,"count":3,"area":15,"coverage":0.30612244897959184},{"d":"ING","length":3,"count":4,"area":12,"coverage":0.24489795918367346},{"d":"KIN","length":3,"count":4,"area":12,"coverage":0.24489795918367346},{"d":"baro","length":4,"count":3,"area":12,"coverage":0.24489795918367346},{"d":"aron","length":4,"count":3,"area":12,"coverage":0.24489795918367346},{"d":"bar","length":3,"count":3,"area":9,"coverage":0.1836734693877551},{"d":"ron","length":3,"count":3,"area":9,"coverage":0.1836734693877551},{"d":"X","length":1,"count":8,"area":8,"coverage":0.16326530612244897},{"d":"KI","length":2,"count":4,"area":8,"coverage":0.16326530612244897},{"d":"NG","length":2,"count":4,"area":8,"coverage":0.16326530612244897},{"d":"on","length":2,"count":3,"area":6,"coverage":0.12244897959183673},{"d":"ba","length":2,"count":3,"area":6,"coverage":0.12244897959183673},{"d":"XOX","length":3,"count":2,"area":6,"coverage":0.12244897959183673},{"d":"XXX","length":3,"count":2,"area":6,"coverage":0.12244897959183673},{"d":"G","length":1,"count":4,"area":4,"coverage":0.08163265306122448},{"d":"K","length":1,"count":4,"area":4,"coverage":0.08163265306122448},{"d":"OX","length":2,"count":2,"area":4,"coverage":0.08163265306122448},{"d":"XX","length":2,"count":2,"area":4,"coverage":0.08163265306122448},{"d":"b","length":1,"count":3,"area":3,"coverage":0.061224489795918366},{"d":"n","length":1,"count":3,"area":3,"coverage":0.061224489795918366},{"d":"O","length":1,"count":2,"area":2,"coverage":0.04081632653061224}]]
    ["𠃊𠃌一",[]]
    ]
  for [ probe, matcher, ] in probes_and_matchers
    results = JZR.find_repetitions probe
    # urge ( JSON.stringify [ probe, results, ] )
    # debug '33021', CND.equals matcher, results
    T.ok CND.equals matcher, results
  T.end()
  return null

#-----------------------------------------------------------------------------------------------------------
TAP.test "demo 1", ( T ) ->
  texts = [
    "䀠几乎目几乎几几几几乎"
    "几乎几乎几乎几乎"
    "几几几几乎䀠几乎目几乎"
    "𠃊𠃌一"
    "凵日𠣏日𠣏"
    "YABAB"
    "YABABCDCD"
    ]
  for text in texts
    info text
    help ( JSON.stringify hit ) for hit in JZR.find_repetitions text
  T.end()
###

MultiSet = require 'mnemonist/multi-set'

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
repetitions_from_text = ( text ) ->
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

#-----------------------------------------------------------------------------------------------------------
TAP.test "demo 2", ( T ) ->
  texts = [
    "YABAB"
    "YABABCDCD"
    "䀠几乎目几乎几几几几乎"
    "几乎几乎几乎几乎"
    "几几几几乎䀠几乎目几乎"
    "𠃊𠃌一"
    "凵日𠣏日𠣏"
    ]
  for text in texts
    help text
    info ( JSON.stringify hit ) for hit in repetitions_from_text text
  T.end()





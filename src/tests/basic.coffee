
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
    ["barbarbar",[{"d":"bar","length":3,"count":3,"area":9},{"d":"ba","length":2,"count":3,"area":6},{"d":"ar","length":2,"count":3,"area":6},{"d":"arb","length":3,"count":2,"area":6},{"d":"rba","length":3,"count":2,"area":6},{"d":"rb","length":2,"count":2,"area":4},{"d":"b","length":1,"count":3,"area":3},{"d":"a","length":1,"count":3,"area":3},{"d":"r","length":1,"count":3,"area":3}]]
    ["abcdef",[]]
    ["foobarbarbar",[{"d":"bar","length":3,"count":3,"area":9},{"d":"ba","length":2,"count":3,"area":6},{"d":"ar","length":2,"count":3,"area":6},{"d":"arb","length":3,"count":2,"area":6},{"d":"rba","length":3,"count":2,"area":6},{"d":"rb","length":2,"count":2,"area":4},{"d":"b","length":1,"count":3,"area":3},{"d":"a","length":1,"count":3,"area":3},{"d":"r","length":1,"count":3,"area":3},{"d":"o","length":1,"count":2,"area":2}]]
    ["",[]]
    ["oo",[{"d":"o","length":1,"count":2,"area":2}]]
    ["foobarbarbarfoo",[{"d":"bar","length":3,"count":3,"area":9},{"d":"ba","length":2,"count":3,"area":6},{"d":"ar","length":2,"count":3,"area":6},{"d":"rba","length":3,"count":2,"area":6},{"d":"foo","length":3,"count":2,"area":6},{"d":"arb","length":3,"count":2,"area":6},{"d":"o","length":1,"count":4,"area":4},{"d":"oo","length":2,"count":2,"area":4},{"d":"fo","length":2,"count":2,"area":4},{"d":"rb","length":2,"count":2,"area":4},{"d":"r","length":1,"count":3,"area":3},{"d":"a","length":1,"count":3,"area":3},{"d":"b","length":1,"count":3,"area":3},{"d":"f","length":1,"count":2,"area":2}]]
    ["foobarrbarrbarrfoo",[{"d":"barr","length":4,"count":3,"area":12},{"d":"arr","length":3,"count":3,"area":9},{"d":"bar","length":3,"count":3,"area":9},{"d":"rbar","length":4,"count":2,"area":8},{"d":"arrb","length":4,"count":2,"area":8},{"d":"rrba","length":4,"count":2,"area":8},{"d":"r","length":1,"count":6,"area":6},{"d":"rr","length":2,"count":3,"area":6},{"d":"ar","length":2,"count":3,"area":6},{"d":"ba","length":2,"count":3,"area":6},{"d":"foo","length":3,"count":2,"area":6},{"d":"rrb","length":3,"count":2,"area":6},{"d":"rba","length":3,"count":2,"area":6},{"d":"o","length":1,"count":4,"area":4},{"d":"fo","length":2,"count":2,"area":4},{"d":"oo","length":2,"count":2,"area":4},{"d":"rb","length":2,"count":2,"area":4},{"d":"a","length":1,"count":3,"area":3},{"d":"b","length":1,"count":3,"area":3},{"d":"f","length":1,"count":2,"area":2}]]
    ["bannanana",[{"d":"an","length":2,"count":3,"area":6},{"d":"na","length":2,"count":3,"area":6},{"d":"a","length":1,"count":4,"area":4},{"d":"n","length":1,"count":4,"area":4}]]
    ["䀠目几几几",[{"d":"几","length":1,"count":3,"area":3}]]
    ["䀠几乎目几乎几几几几乎",[{"d":"几","length":1,"count":6,"area":6},{"d":"几乎","length":2,"count":3,"area":6},{"d":"几几","length":2,"count":2,"area":4},{"d":"乎","length":1,"count":3,"area":3}]]
    ["几乎几乎几乎几乎",[{"d":"几乎","length":2,"count":4,"area":8},{"d":"几乎几乎","length":4,"count":2,"area":8},{"d":"乎几","length":2,"count":3,"area":6},{"d":"几乎几","length":3,"count":2,"area":6},{"d":"乎几乎","length":3,"count":2,"area":6},{"d":"几","length":1,"count":4,"area":4},{"d":"乎","length":1,"count":4,"area":4}]]
    ["几几几几乎䀠几乎目几乎",[{"d":"几","length":1,"count":6,"area":6},{"d":"几乎","length":2,"count":3,"area":6},{"d":"几几","length":2,"count":2,"area":4},{"d":"乎","length":1,"count":3,"area":3}]]
    ["barONEbarTWObarTHREE",[{"d":"bar","length":3,"count":3,"area":9},{"d":"barT","length":4,"count":2,"area":8},{"d":"ba","length":2,"count":3,"area":6},{"d":"ar","length":2,"count":3,"area":6},{"d":"arT","length":3,"count":2,"area":6},{"d":"rT","length":2,"count":2,"area":4},{"d":"E","length":1,"count":3,"area":3},{"d":"a","length":1,"count":3,"area":3},{"d":"r","length":1,"count":3,"area":3},{"d":"b","length":1,"count":3,"area":3},{"d":"T","length":1,"count":2,"area":2},{"d":"O","length":1,"count":2,"area":2}]]
    ["1baron3baron5baron0KING6KING7",[{"d":"baron","length":5,"count":3,"area":15},{"d":"aron","length":4,"count":3,"area":12},{"d":"baro","length":4,"count":3,"area":12},{"d":"ron","length":3,"count":3,"area":9},{"d":"aro","length":3,"count":3,"area":9},{"d":"bar","length":3,"count":3,"area":9},{"d":"KING","length":4,"count":2,"area":8},{"d":"on","length":2,"count":3,"area":6},{"d":"ro","length":2,"count":3,"area":6},{"d":"ba","length":2,"count":3,"area":6},{"d":"ar","length":2,"count":3,"area":6},{"d":"KIN","length":3,"count":2,"area":6},{"d":"ING","length":3,"count":2,"area":6},{"d":"KI","length":2,"count":2,"area":4},{"d":"IN","length":2,"count":2,"area":4},{"d":"NG","length":2,"count":2,"area":4},{"d":"b","length":1,"count":3,"area":3},{"d":"a","length":1,"count":3,"area":3},{"d":"n","length":1,"count":3,"area":3},{"d":"o","length":1,"count":3,"area":3},{"d":"r","length":1,"count":3,"area":3},{"d":"G","length":1,"count":2,"area":2},{"d":"N","length":1,"count":2,"area":2},{"d":"I","length":1,"count":2,"area":2},{"d":"K","length":1,"count":2,"area":2}]]
    ["0KING1baron3baron5baron6KING7",[{"d":"baron","length":5,"count":3,"area":15},{"d":"aron","length":4,"count":3,"area":12},{"d":"baro","length":4,"count":3,"area":12},{"d":"ron","length":3,"count":3,"area":9},{"d":"aro","length":3,"count":3,"area":9},{"d":"bar","length":3,"count":3,"area":9},{"d":"KING","length":4,"count":2,"area":8},{"d":"ba","length":2,"count":3,"area":6},{"d":"on","length":2,"count":3,"area":6},{"d":"ro","length":2,"count":3,"area":6},{"d":"ar","length":2,"count":3,"area":6},{"d":"KIN","length":3,"count":2,"area":6},{"d":"ING","length":3,"count":2,"area":6},{"d":"NG","length":2,"count":2,"area":4},{"d":"IN","length":2,"count":2,"area":4},{"d":"KI","length":2,"count":2,"area":4},{"d":"o","length":1,"count":3,"area":3},{"d":"n","length":1,"count":3,"area":3},{"d":"b","length":1,"count":3,"area":3},{"d":"r","length":1,"count":3,"area":3},{"d":"a","length":1,"count":3,"area":3},{"d":"I","length":1,"count":2,"area":2},{"d":"G","length":1,"count":2,"area":2},{"d":"N","length":1,"count":2,"area":2},{"d":"K","length":1,"count":2,"area":2}]]
    ["XXXOXXX0KING1baron2KING3baron4KING5baron6KING7XOX",[{"d":"KING","length":4,"count":4,"area":16},{"d":"baron","length":5,"count":3,"area":15},{"d":"ING","length":3,"count":4,"area":12},{"d":"KIN","length":3,"count":4,"area":12},{"d":"aron","length":4,"count":3,"area":12},{"d":"baro","length":4,"count":3,"area":12},{"d":"ron","length":3,"count":3,"area":9},{"d":"aro","length":3,"count":3,"area":9},{"d":"bar","length":3,"count":3,"area":9},{"d":"X","length":1,"count":8,"area":8},{"d":"NG","length":2,"count":4,"area":8},{"d":"KI","length":2,"count":4,"area":8},{"d":"IN","length":2,"count":4,"area":8},{"d":"on","length":2,"count":3,"area":6},{"d":"ro","length":2,"count":3,"area":6},{"d":"ba","length":2,"count":3,"area":6},{"d":"ar","length":2,"count":3,"area":6},{"d":"XXX","length":3,"count":2,"area":6},{"d":"XOX","length":3,"count":2,"area":6},{"d":"G","length":1,"count":4,"area":4},{"d":"N","length":1,"count":4,"area":4},{"d":"I","length":1,"count":4,"area":4},{"d":"K","length":1,"count":4,"area":4},{"d":"XX","length":2,"count":2,"area":4},{"d":"XO","length":2,"count":2,"area":4},{"d":"OX","length":2,"count":2,"area":4},{"d":"a","length":1,"count":3,"area":3},{"d":"o","length":1,"count":3,"area":3},{"d":"r","length":1,"count":3,"area":3},{"d":"n","length":1,"count":3,"area":3},{"d":"b","length":1,"count":3,"area":3},{"d":"O","length":1,"count":2,"area":2}]]
    ["𠃊𠃌一",[]]
    ]
  for [ probe, matcher, ] in probes_and_matchers
    results = JZR.find_repetitions probe
    # urge ( JSON.stringify [ probe, results, ] )
    T.ok CND.equals matcher, results
  T.end()
  return null

#-----------------------------------------------------------------------------------------------------------
TAP.test "invariance under reordering", ( T ) ->
  result_1 = JZR.find_repetitions "䀠几乎目几乎几几几几乎"
  result_2 = JZR.find_repetitions "几几几几乎䀠几乎目几乎"
  urge '\n' + ( JSON.stringify result_1 )
  urge '\n' + ( JSON.stringify result_2 )
  T.ok CND.equals result_1, result_2
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
###

#-----------------------------------------------------------------------------------------------------------
TAP.test "results ordering", ( T ) ->
  texts = [
    # '几几几乎䀠几乎目几乎'
    # '几几乎䀠几乎目几乎'
    # '几乎䀠几乎目几乎'
    # 'abc1234567abc'
    # 'xxxxxxxxxabcdabcdabcdabcd'
    # 'ababababABABABAB'
    # 'barONEbarTWObarTHREE'
    # 'foobarbarbar'
    # 'foobarbarbarbar'
    # '⿰(⿱屮兀⿰⿱屮兀⿱屮兀)'
    # '几几几几乎䀠几乎目几乎'
    # '123xxxx456ab,ab,ab,ab'
    # Array.from '几几几几乎䀠几乎目几乎'
    # Array.from '几几乎几乎'
    '几几乎几乎'
    ]
  for text in texts
    # urge ( ( ( CND.grey "#{hit.area} #{hit.count} #{hit.degree} " ) + ( CND.yellow hit.d ) ) for hit in JZR.find_repetitions text ). join ' '
    urge ( ( ( CND.grey "#{hit.area} " ) + ( CND.yellow hit.d ) ) for hit in JZR.find_repetitions text ). join ' '
  T.end()


###
d = Array.from 'abcxxxxxdef'
f = Array.from 'xx'

help d.findIndex ( element, idx ) ->
  debug element, d[ idx ] == f[ 0 ] and d[ idx + 1 ] == f[ 0 + 1 ]
  return false

```
for(var i=0; i< namesArray.length; i++) {
  var count = 0;
  for(var j = 0; j < namesSerieArray.length; j++){
  if(namesSerieArray[i] == namesArray[j])
    count++;
  }
```
###


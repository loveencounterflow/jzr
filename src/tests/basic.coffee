
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
ƒ                         = Array.from
JZR                      = require '../..'
TAP                       = require 'tap'

#-----------------------------------------------------------------------------------------------------------
_copy_regex = ( regex, flags ) -> new RegExp regex.source, flags

#-----------------------------------------------------------------------------------------------------------
@find_repetitions = ( text ) ->
  R           = []
  collector   = {}
  chrs        = Array.from text
  text_length = chrs.length
  #.........................................................................................................
  return R if text_length < 2
  #.........................................................................................................
  for first_idx in [ 0 .. text_length - 2 ] by +1
    sub_text = chrs[ first_idx .. ].join ''
    @_find_repetitions sub_text, text, collector
  # #.........................................................................................................
  # @_find_repetitions text, collector
  R.push hit for _, hit of collector
  R.sort ( a, b ) ->
    { area: a_area, count: a_count, length: a_length, } = a
    { area: b_area, count: b_count, length: b_length, } = b
    return +1 if a_area   < b_area
    return -1 if a_area   > b_area
    return +1 if a_count  < b_count
    return -1 if a_count  > b_count
    return +1 if a_length < b_length
    return -1 if a_length > b_length
    return  0
  return R

#-----------------------------------------------------------------------------------------------------------
@_pattern = /// ( [^_]+ ) (?: .* \1 )+ ///

#-----------------------------------------------------------------------------------------------------------
@_find_repetitions = ( text, reference, collector ) ->
  return null unless ( match = text.match @_pattern )?
  [ _, d, ]       = match
  idxs            = []
  pattern_2       = /// #{CND.escape_regex d} ///g
  count           = 0
  count          += +1 while result = pattern_2.exec reference
  d_size          = ( Array.from d ).length
  area            = d_size * count
  hit             = { d, length: d_size, count, area, }
  collector[ d ] ?= hit
  @_find_repetitions ( text.replace pattern_2, '_'.repeat d_size ), reference, collector
  return null


L = @
#-----------------------------------------------------------------------------------------------------------
TAP.test "additional 5", ( T ) ->
  probes_and_matchers = [
    [ "xyz",[]]
    [ "barbarbar",[]]
    [ "abcdef",[]]
    [ "foobarbarbar",[]]
    [ "",[]]
    [ "oo",[]]
    [ "foobarbarbarfoo",[]]
    [ "foobarrbarrbarrfoo",[]]
    [ "bannanana",[]]
    [ "䀠目几几几",[]]
    [ "䀠几乎目几乎几几几几乎",[]]
    [ "几乎几乎几乎几乎",[]]
    [ "几几几几乎䀠几乎目几乎",[]]
    [ "barONEbarTWObarTHREE",[]]
    [ "1baron3baron5baron0KING6KING7",[]]
    [ "0KING1baron3baron5baron6KING7",[]]
    [ "XXXOXXX0KING1baron2KING3baron4KING5baron6KING7XOX",[]]
    [ "xxxo|xxx|xxo",[]]
    [ "xxo|xxx|xxo",[]]
    [ "xo|xxx|xxo",[]]
    [ "o|xxx|xxo",[]]
    [ "|xxx|xxo",[]]
    [ "xxx|xxo",[]]
    [ "xx|xxo",[]]
    [ "x|xxo",[]]
    [ "|xxo",[]]
    [ "xxo",[]]
    [ "xo",[]]
    [ "o",[]]
    ]
  for [ probe, matcher, ] in probes_and_matchers
    hits = L.find_repetitions probe
    urge ( JSON.stringify [ probe, hits, ] )
  # urge ( JSON.stringify hit ) for hit in L.find_repetitions "xyz"
  # urge ( JSON.stringify hit ) for hit in L.find_repetitions "barbarbar"
  # urge ( JSON.stringify hit ) for hit in L.find_repetitions "abcdef"
  # urge ( JSON.stringify hit ) for hit in L.find_repetitions "foobarbarbar"
  # urge ( JSON.stringify hit ) for hit in L.find_repetitions ""
  # urge ( JSON.stringify hit ) for hit in L.find_repetitions "oo"
  # urge ( JSON.stringify hit ) for hit in L.find_repetitions "foobarbarbarfoo"
  # urge ( JSON.stringify hit ) for hit in L.find_repetitions "foobarrbarrbarrfoo"
  # urge ( JSON.stringify hit ) for hit in L.find_repetitions "bannanana"
  # urge ( JSON.stringify hit ) for hit in L.find_repetitions "䀠目几几几"
  # urge ( JSON.stringify hit ) for hit in L.find_repetitions "barONEbarTWObarTHREE"
  # urge ( JSON.stringify hit ) for hit in L.find_repetitions "1baron3baron5baron0KING6KING7"
  # urge ( JSON.stringify hit ) for hit in L.find_repetitions "0KING1baron3baron5baron6KING7"
  # urge ( JSON.stringify hit ) for hit in L.find_repetitions "XXXOXXX0KING1baron2KING3baron4KING5baron6KING7XOX"
  # urge ( JSON.stringify hit ) for hit in L.find_repetitions "xxxo|xxx|xxo"
  # urge ( JSON.stringify hit ) for hit in L.find_repetitions "xxo|xxx|xxo"
  # urge ( JSON.stringify hit ) for hit in L.find_repetitions "xo|xxx|xxo"
  # urge ( JSON.stringify hit ) for hit in L.find_repetitions "o|xxx|xxo"
  # urge ( JSON.stringify hit ) for hit in L.find_repetitions "|xxx|xxo"
  # urge ( JSON.stringify hit ) for hit in L.find_repetitions "xxx|xxo"
  # urge ( JSON.stringify hit ) for hit in L.find_repetitions "xx|xxo"
  # urge ( JSON.stringify hit ) for hit in L.find_repetitions "x|xxo"
  # urge ( JSON.stringify hit ) for hit in L.find_repetitions "|xxo"
  # urge ( JSON.stringify hit ) for hit in L.find_repetitions "xxo"
  # urge ( JSON.stringify hit ) for hit in L.find_repetitions "xo"
  # urge ( JSON.stringify hit ) for hit in L.find_repetitions "o"
  T.end()
  return null

#-----------------------------------------------------------------------------------------------------------
TAP.test "demo", ( T ) ->
  texts = [
    "䀠几乎目几乎几几几几乎"
    "几乎几乎几乎几乎"
    "几几几几乎䀠几乎目几乎"
    ]
  for text in texts
    info text
    help ( JSON.stringify hit ) for hit in L.find_repetitions text
  T.end()




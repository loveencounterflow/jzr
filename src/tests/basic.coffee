
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
FLSL                      = require '../..'
TAP                       = require 'tap'

###
#-----------------------------------------------------------------------------------------------------------
TAP.test "additional 1", ( T ) ->
  urge ( FLSL.find_longest_repeating_sublist ƒ "barbarbar"            ).join ''
  urge ( FLSL.find_longest_repeating_sublist ƒ "foobarbarbar"         ).join ''
  urge ( FLSL.find_longest_repeating_sublist ƒ "foobarbarbarfoo"      ).join ''
  urge ( FLSL.find_longest_repeating_sublist ƒ "bannanana"            ).join ''
  urge ( FLSL.find_longest_repeating_sublist ƒ "䀠目几几几"             ).join ''
  T.end()
  return null

#-----------------------------------------------------------------------------------------------------------
TAP.test "additional 2", ( T ) ->
  urge FLSL.find_longest_repeating_sublist ƒ "barbarbar"
  urge FLSL.find_longest_repeating_sublist ƒ "foobarbarbar"
  urge FLSL.find_longest_repeating_sublist ƒ "foobarbarbarfoo"
  urge FLSL.find_longest_repeating_sublist ƒ "bannanana"
  urge FLSL.find_longest_repeating_sublist ƒ "䀠目几几几"
  T.end()
  return null

#-----------------------------------------------------------------------------------------------------------
TAP.test "additional 3", ( T ) ->
  urge FLSL.find_longest_repeating_sublist [ "bar", "bar", "bar", ]
  urge FLSL.find_longest_repeating_sublist [ "foo", "bar", "bar", "bar", ]
  urge FLSL.find_longest_repeating_sublist [ "foo", "bar", "bar", "bar", "foo", ]
  urge FLSL.find_longest_repeating_sublist [ "fo", "bar", "bar", "bar", "fo", ]
  urge FLSL.find_longest_repeating_sublist [ "foo", "barr", "barr", "barr", "foo", ]
  urge FLSL.find_longest_repeating_sublist [ "barr", "barr", "barr", "foo", "foo", ]
  urge FLSL.find_longest_repeating_sublist ƒ "bannanana"
  urge FLSL.find_longest_repeating_sublist ƒ "䀠目几几几"
  urge FLSL.find_longest_repeating_sublist ƒ "foobarbarbar"
  urge FLSL.find_longest_repeating_sublist [ "KING", "baron", "baron", "baron", "KING", ]
  urge FLSL.find_longest_repeating_sublist [ "baron", "baron", "baron", "KING", "KING", ]
  urge FLSL.find_longest_repeating_sublist [ "KING", "baron", "KING", "baron", "KING", "baron", "KING", ]
  T.end()
  return null
###

#-----------------------------------------------------------------------------------------------------------
_copy_regex = ( regex, flags ) -> new RegExp regex.source, flags

#-----------------------------------------------------------------------------------------------------------
show = ( text, pattern ) ->
  unless ( match = text.match pattern )?
    warn text
    return null
  [ _, d, ] = match
  idxs      = []
  pattern_2 = /// #{CND.escape_regex d} ///g
  count     = 0
  count    += +1 while result = pattern_2.exec text
  text_size = ( Array.from text ).length
  d_size    = ( Array.from d ).length
  area_abs  = d_size * count
  area_rel  = area_abs / text_size
  help ( CND.lime d ), ( CND.yellow count ), ( CND.steel area_abs ), ( CND.orange area_rel.toFixed 2 ), ( CND.blue text )
  text_2    = text.replace pattern_2, '_'.repeat d_size
  # whisper text_2.match pattern
  show text_2, pattern
  return null


###
#-----------------------------------------------------------------------------------------------------------
TAP.test "additional 4", ( T ) ->
  for count in [ 1 .. 4 ]
    pattern = /// ( [^_]{ #{count} } ) (?: .* \1 )+ ///
    help count, pattern
    show "xyz", pattern
    show "barbarbar", pattern
    show "foobarbarbar", pattern
    show "foobarbarbarfoo", pattern
    show "foobarrbarrbarrfoo", pattern
    show "bannanana", pattern
    show "䀠目几几几", pattern
    show "䀠几乎目几乎几几几几乎", pattern
    show "barONEbarTWObarTHREE", pattern
    show "0KING1baron3baron5baron6KING7", pattern
    show "0KING1baron2KING3baron4KING5baron6KING7", pattern
  T.end()
  return null
###


#-----------------------------------------------------------------------------------------------------------
TAP.test "additional 5", ( T ) ->
  pattern = /// ( [^_]+ ) (?: .* \1 )+ ///
  help pattern
  show "xyz", pattern
  show "barbarbar", pattern
  show "foobarbarbar", pattern
  show "foobarbarbarfoo", pattern
  show "foobarrbarrbarrfoo", pattern
  show "bannanana", pattern
  show "䀠目几几几", pattern
  show "䀠几乎目几乎几几几几乎", pattern
  show "几乎几乎几乎几乎", pattern
  show "几几几几乎䀠几乎目几乎", pattern
  show "barONEbarTWObarTHREE", pattern
  show "1baron3baron5baron0KING6KING7", pattern
  show "0KING1baron3baron5baron6KING7", pattern
  show "XXXOXXX0KING1baron2KING3baron4KING5baron6KING7XOX", pattern
  show "xxxo|xxx|xxo", pattern
  show "xxo|xxx|xxo", pattern
  show "xo|xxx|xxo", pattern
  show "o|xxx|xxo", pattern
  show "|xxx|xxo", pattern
  show "xxx|xxo", pattern
  show "xx|xxo", pattern
  show "x|xxo", pattern
  show "|xxo", pattern
  show "xxo", pattern
  show "xo", pattern
  show "o", pattern
  T.end()
  return null

###
#-----------------------------------------------------------------------------------------------------------
TAP.test "additional 6", ( T ) ->
  for count in [ 1 .. 4 ]
    pattern = /// ( .{ #{count} } ) \1 ///
    help count, pattern
    show "xyz", pattern
    show "barbarbar", pattern
    show "foobarbarbar", pattern
    show "foobarbarbarfoo", pattern
    show "foobarrbarrbarrfoo", pattern
    show "bannanana", pattern
    show "䀠目几几几", pattern
    show "䀠几乎目几乎几几几几乎", pattern
    show "barONEbarTWObarTHREE", pattern
    show "0KING1baron3baron5baron6KING7", pattern
    show "0KING1baron2KING3baron4KING5baron6KING7", pattern
  T.end()
  return null
###




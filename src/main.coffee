
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
  for _, hit of collector
    hit.coverage = hit.area / text_length
    R.push hit
  R.sort ( a, b ) ->
    { coverage: a_coverage, area: a_area, count: a_count, length: a_length, } = a
    { coverage: b_coverage, area: b_area, count: b_count, length: b_length, } = b
    return +1 if a_coverage < b_coverage
    return -1 if a_coverage > b_coverage
    return +1 if a_area     < b_area
    return -1 if a_area     > b_area
    return +1 if a_count    < b_count
    return -1 if a_count    > b_count
    return +1 if a_length   < b_length
    return -1 if a_length   > b_length
    return  0
  return R

#-----------------------------------------------------------------------------------------------------------
# @_pattern = /// ( [^_]+ ) (?: .* \1 )+ ///
@_pattern = ///
  ( (?: [ \ud800-\udbff ] [ \udc00-\udfff ] ) |
  [^ _ \ud800-\udfff ]+ )
  (?: .* \1 )+
  ///

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

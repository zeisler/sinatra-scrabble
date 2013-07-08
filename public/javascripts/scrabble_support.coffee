$().ready ->
  $('#submit_word').on 'click', (event) ->
    event.preventDefault()
    $('#word').val(get_word_from_tiles())
    $('#rack').val(get_rack_order())
    $('#word_form').submit()
  $('#submit_replace_word').on 'click', (event) ->
    event.preventDefault()
    $('#replace').val(get_word_from_tiles())
    $('#word_form').submit()

  get_tile = ->
    $('#word_form').find('.tile')
  get_word_from_tiles  = (word) ->
    word = ''
    tiles = get_tile()
    for tile in tiles
      if $(tile).hasClass('active')
        word += $(tile).data('letter')
    return word

  $( "#sortable" ).sortable ->
        revert: true

  blank_tiles = (that) ->
    letter = $(that).html()
    if letter != "_"
      $(that).html("_")
      $(that).css("text-decoration", "underline")
    $(".blank-box").select()
    $(document).keypress (e) ->
      letter = String.fromCharCode(e.which)
      $(that).html(letter)
      $(that).attr("data-letter", letter)
  $('.blank').on 'touchstart', ->
    blank_tiles(this)
  $('.blank').on 'click', ->
    blank_tiles(this)

  get_rack_order = ->
    tiles = get_tile()
    rack = []
    for tile in tiles
      letter = $(tile).data('letter')
      blank =  $(tile).data('blank')
      rack[_i] =
        letter: letter
        blank: blank
    return JSON.stringify rack


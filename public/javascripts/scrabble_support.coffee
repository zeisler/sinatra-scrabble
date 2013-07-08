$().ready ->
  $('#submit_word').on 'click', (event) ->
    event.preventDefault()
    $('#word').val(get_tiles())
    $('#word_form').submit()
  $('#submit_replace_word').on 'click', (event) ->
    event.preventDefault()
    $('#replace').val(get_tiles())
    $('#word_form').submit()

  get_tiles  = (word) ->
    word = ''
    tiles = $('#word_form').find('.tile')
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
      $(that).css("text-decoration", "blink")
    $(".blank-box").select()
    $(document).keypress (e) ->
      letter = String.fromCharCode(e.which)
      $(that).html(letter)
      $(that).attr("data-letter", letter)
  $('.blank').on 'touchstart', ->
    blank_tiles(this)
  $('.blank').on 'click', ->
    blank_tiles(this)

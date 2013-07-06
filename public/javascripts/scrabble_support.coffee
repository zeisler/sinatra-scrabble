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
      if $(tile).hasClass('blank')
        input = $(tile).find('input')
        if $(input).val()?
          word += $(input).val()
      else if $(tile).hasClass('active')
        word += $(tile).data('letter')
    return word

  $( "#sortable" ).sortable ->
        revert: true


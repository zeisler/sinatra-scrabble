$().ready ->
  $('#submit_word').on 'click', (event) ->
    event.preventDefault()
    tiles = $('#word_form').find('.tile')
    word = ''
    for tile in tiles
      if $(tile).hasClass('blank')
        input = $(tile).find('input')
        if $(input).val()?
          word += $(input).val()
      else if $(tile).hasClass('active')
        word += $(tile).data('letter')
    $('#word').val(word)
    $('#word_form').submit()

  $( "#sortable" ).sortable ->
        revert: true

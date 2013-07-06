$(document).ready(function() {

	// Open external links in a new window
	hostname = window.location.hostname
	$("a[href^=http]")
	  .not("a[href*='" + hostname + "']")
	  .addClass('link external')
	  .attr('target', '_blank');


    $(function() {
    $( "#sortable" ).sortable({
      revert: true
    });
  });


$('.tile').on("click", function() {
  var index, letter;
  index = $(this).data('index');
  letter = $(this).data('letter');
  console.log(index);
  console.log(letter);
  if ($("#hidden-" + index).val() === '') {
    return $("#hidden-" + index).val(letter);
  } else {
    return $("#hidden-" + index).val('');
  }
});

});

$(document).ready(function() {
	
 	$("a#close-texts-form").click(function(){
    closeModal();
    return false;
  });
  
  $(".editable").click(function(){
    adjustTextsForm($(this));
    showModal();
  });
  
  $("#texts-form").submit(function(){
    var data = $(this).serialize();
    var type = $(this).attr("method");
    var url = $(this).attr("action");
    $.ajax({
      type: type,
      url: url,
      data: data, 
      success: function(updatedItem){
        $("#text_item_"+updatedItem).html($("#text_value").val());
        $("#text_item_"+updatedItem).effect("highlight", {}, 2000);
      }
    });
    closeModal();
    return false;
  });
  
});

function closeModal() {
  $("#fader").fadeOut();
  $("#modal-window").fadeOut();
}

function showModal() {
  $("#fader").fadeIn();
  $("#modal-window").fadeIn();
}

function adjustTextsForm(source) {
  var key = source.attr('data-key');
  var documentId = source.attr('data-document_id');
  var method = source.attr('data-method');
  var value = source.html();
  
  $("#text_value").val(value);
  $("#text_value").attr("name", "text["+key+"]");
  $("#text_label").attr("for", "text["+key+"]");
  $("#texts-form").attr("method", method);
  $("#texts-form").attr("action", "/texts/" + documentId + "/" + key);

	buildCleditor();
}

function buildCleditor() {
	$("#text_value").cleditor({
		width: 550,
		height: 270,
		controls: "bold italic underline strikethrough subscript superscript | " +
							"style | bullets numbering | outdent indent | alignleft center alignright justify | " +
							"undo redo | image link unlink | source",
	})[0].updateFrame();
}
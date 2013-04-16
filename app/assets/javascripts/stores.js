$(function() {
  $('#edit_store').on('submit', function(event) { 
    var initialPath = $("#store_path").attr("value");
    var updatedPath = $("#store_path").val();
    if (initialPath === updatedPath) {
      return true
    } else {
      var response = confirm("Changing the URL ID may break links on external pages. Are you sure you want to change this?");
      if (response) {
        true
      } else {
        event.preventDefault();
      }
    }
  });
});
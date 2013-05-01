$(document).ready(function() {
  $('.flag a').click(function() {
    var review_div = $(this).closest('.review');
    var the_link = $(this).parent();
    var store = review_div.data('store');
    var product_id = review_div.data('product-id');
    var review_id = review_div.data('product-review-id');

    var post_path = "/" + store + '/products/' + product_id + '/reviews/' + review_id + '/flag?status=flagged';

    $.ajax({
      type: "POST",
      url: post_path,
      context: '.flag a' ,
      success:function(){
        $(the_link).closest('.review').hide();
      }
    });
    return false;
  });
});

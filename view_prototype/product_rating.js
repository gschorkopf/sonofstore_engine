var starClass = function() {
	var value = $(this).text();
	var starClass = "s-"+value+"star";
	if(value > 1) {
		starClass += "s";
	}
	return starClass;
};

$(document).ready(function() {
	var ratings = $('table.product-rating td:nth-child(2)');
	ratings.addClass(starClass);
});

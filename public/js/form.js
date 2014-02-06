$.fn.formCollection = function() {
	var index = 0;
	
	$(this).on('click', '.prototype-add:not(.disabled)', function() {
		var parent = $(this).parent('.collection-controls');
		var prototype = parent.attr('data-prototype');
		
		prototype = prototype.replace(/%prototype%/g, 'prototype-' + index);
		
		// add prototype to the container
		$('.collection-control-group', parent).first().append(prototype);
		
		// increase the index for the next addition
		index++;
		
		return false;
	});
	
	$(this).on('click', '.prototype-remove:not(.disabled)', function() {
		if (confirm('Are you sure you want to remove this item?')) {
			$(this).parents('.collection-control').remove();
		}
		
		return false;
	});
};

$(function() {
    $('form[role=form]').formCollection();
});
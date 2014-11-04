$.fn.table = function() {
	$(this).on('change', '.check-all', function() {
		var form = $(this).parents('form.table');

		var checked = this.checked;
		$(':checkbox', form).each(function(i) {
			this.checked = checked;
		});
	});

	$(this).on('change', 'select', function() {
		var submit = true;

		if ($(this).attr('name') == 'action') {
			var form = $(this).parents('form.table');
			var messages = form.data('confirm-messages');
			var action = this.options[this.selectedIndex].text;

			if (messages[action]) {
				submit = confirm(messages[action]);
			} else {
			}
		}

		if (submit) {
			$(this).attr('readonly', true).parents('form').submit();
		} else {
			$(this).val('');
		}
	});

	$('td.action a').addClass('btn btn-default');

	$("tr.disabled").css({ opacity: 0.5 });
	$('tr.disabled a').contents().unwrap();
	$('tr.disabled input[type=checkbox]').attr('disabled', 'disabled');
};

$(function() {
    $('form.table').table();
});

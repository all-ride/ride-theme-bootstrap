$.fn.honeyPot = function(options) {
    var $this = $(this);

    $(options.fields).each(function(index, value) {
        var $input = $('input[name=' + value + ']', $this);
        if ($input.length === 0) {
            return;
        }

        var defaultValue = $input.data('value');
        if (defaultValue) {
            $input.val(defaultValue);
        }

        $input.parents('.form-group').hide();
    });

    $this.on('submit', function() {
        var submitValue = '';

        $(options.fields).each(function(index, value) {
            var $input = $('input[name=' + value + ']', $this);
            var value = $input.val();

            if (value === '') {
                value = $input.attr('name');
            } else {
                value = $input.attr('name') + ':' + value;
            }

            submitValue += (submitValue === '' ? '' : ',') + value;
        });

        $('input[name=honeypot-submit]', $this).val(submitValue);
    });
};

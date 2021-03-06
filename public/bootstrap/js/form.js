$.fn.formCollection = function() {
    $(this).on('click', '.prototype-add:not(.disabled)', function() {
        var parent = $(this).parent('.collection-controls');
        var prototype = parent.attr('data-prototype');
        var index = parent.attr('data-index');
        if (!index) {
            index = $('.collection-control', parent).length;
        }

        prototype = prototype.replace(/%prototype%/g, 'prototype-' + index);

        // add prototype to the container
        $('.collection-control-group', parent).first().append(prototype);

        // increase the index for the next addition
        index++;

        parent.attr('data-index', index);

        return false;
    });

    $(this).on('click', '.prototype-remove:not(.disabled)', function() {
        if (confirm('Are you sure you want to remove this item?')) {
            $(this).parents('.collection-control').remove();
        }

        return false;
    });

    $('[data-order=true] .collection-control-group').sortable({
        axis: "y",
        cursor: "move",
        handle: ".order-handle",
        items: "> .collection-control",
        select: false,
        scroll: true
    });
};

$.fn.formFile = function() {
    $(this).on('click', '.btn-file-delete', function() {
        var anchor = $(this);
        if (confirm(anchor.data('message'))) {
            anchor.closest('.form-group').find('input[type=hidden]').val('');
            anchor.parent('div').remove();
        }

        return false;
    });
};


$.fn.formDependantRows = function() {
    var toggleDependantRows = function($input) {
        var $parent = $input.parents('form'),
            $styleClass = $input.data('toggle-dependant'),
            $group = $parent.find('[name^=' + $input.attr('name') + ']'),
            value = null;

        if ($group.prop('tagName') == 'SELECT') {
            value = $group.val();
        } else {
            var $checked = $group.filter(':checked');
            value = $checked.length ? $checked.val() : null;
        }

        $('.' + $styleClass, $parent).parents('.form-group').hide();
        $('.' + $styleClass + '-' + value, $parent).parents('.form-group').show();
    };

    $('[data-toggle-dependant]', $(this)).on('change', function() {
        toggleDependantRows($(this));
    }).each(function() {
        toggleDependantRows($(this));
    });
}

$(function() {
    $('form[role=form]').formCollection();
    $('form[role=form]').formFile();
    $('form[role=form]').formDependantRows();
});

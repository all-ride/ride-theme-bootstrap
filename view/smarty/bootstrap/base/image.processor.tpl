{extends file="base/index"}

{block name="head_title" prepend}{translate key="title.image.processor"} - {/block}

{block name="content_title" append}
    <div class="page-header">
        <h1>{translate key="title.image.processor"}</h1>
    </div>
{/block}

{block name="content_body" append}
    <div class="image col-md-10">
        {image src=$path id="image-input"}
    </div>

    {include file="base/form.prototype"}
    <form id="{$form->getId()}" class="form-horizontal" enctype="multipart/form-data" method="post" action="{$app.url.request}" name="{$form->getId()}" role="form">
        {call formRows form=$form}

        <input type="submit" class="btn btn-default" value="{translate key="button.save.image"}" />
    </form>

    <div>
        <h3>{translate key="image.processor.label.instruction"}</h3>
        <ul>
            <li>{translate key="image.processor.label.instruction1"}</li>
            <li>{translate key="image.processor.label.instruction2"}</li>
        </ul>
    </div>
{/block}

{block name="styles" append}
    <link rel="stylesheet" type="text/css" href="{$app.url.base}/css/imgareaselect-animated.css">
{/block}

{block name="scripts" append}
    <script src="{$app.url.base}/js/jquery.imgareaselect.pack.js"></script>
    <script type="text/javascript">
        $(function() {
            $('#image-input').imgAreaSelect({
                handles: true,
                onSelectEnd: function (img, selection) {
                    $('input[name="x1"]').val(selection.x1);
                    $('input[name="y1"]').val(selection.y1);
                    $('input[name="x2"]').val(selection.x2);
                    $('input[name="y2"]').val(selection.y2);
                },
                aspectRatio: "4:3"
            });
        });
    </script>
{/block}

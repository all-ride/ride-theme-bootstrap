{extends file="base/index"}

{block name="content_title"}
    <div class="page-header">
        <h1>{$title}</h1>
    </div>
{/block}

{block name="content" append}
    {include file="base/form.prototype"}

    <form id="{$form->getId()}" class="form-horizontal" action="{$app.url.request}" method="POST" role="form" enctype="multipart/form-data">
        <fieldset>
            {call formRows form=$form}
        
            <div class="form-group">
                <div class="col-lg-offset-2 col-lg-10">
                    <input type="submit" class="btn btn-default" value="{translate key="button.save"}" />
                    <a class="btn" href="{$referer}">{translate key="button.cancel"}</a>
                </div>
            </div>
        </fieldset>
    </form>    
{/block}

{block name="scripts" append}
    <script src="{$app.url.base}/js/form.js"></script>
    <script type="text/javascript">
        $(function() {
            $('form').formCollection(); 
        });
    </script>
{/block}
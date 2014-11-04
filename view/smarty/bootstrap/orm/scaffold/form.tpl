{extends file="base/index"}

{block name="taskbar_panels" append}
    {if $localizeUrl}
        {call taskbarPanelLocales url=$localizeUrl locale=$locale locales=$locales}
    {/if}
{/block}

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
                <div class="col-md-offset-2 col-md-10">
                    <input type="submit" class="btn btn-default" value="{translate key="button.save"}" />
                    <a class="btn" href="{$referer}">{translate key="button.cancel"}</a>
                </div>
            </div>
        </fieldset>
    </form>
{/block}

{block name="scripts" append}
    <script src="{$app.url.base}/bootstrap/js/jquery-ui.js"></script>
    <script src="{$app.url.base}/bootstrap/js/form.js"></script>
{/block}

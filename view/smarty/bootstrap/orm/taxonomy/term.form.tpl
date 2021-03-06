{extends file="base/index"}

{block name="taskbar_panels" append}
    {if $term->getId()}
        {url id="taxonomy.term.edit" parameters=["vocabulary" => $vocabulary->getId(), "locale" => "%locale%", "term" => $term->getId()] var="localizeUrl"}
    {else}
        {url id="taxonomy.term.add" parameters=["vocabulary" => $vocabulary->getId(), "locale" => "%locale%"] var="localizeUrl"}
    {/if}
    {call taskbarPanelLocales url=$localizeUrl locale=$locale locales=$locales}
{/block}

{block name="content_title"}
<div class="page-header">
    <h1>{translate key="title.taxonomy"} <small>{translate key="title.terms"}</small></h1>
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
                    {if $referer}
                        <a class="btn" href="{$referer}">{translate key="button.cancel"}</a>
                    {/if}
                </div>
            </div>
        </fieldset>
    </form>
{/block}

{block name="scripts" append}
    {script src="bootstrap/js/form.js"}
{/block}

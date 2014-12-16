{extends file="base/index"}

{block name="head_title" prepend}{if $folder->getId()}{$folder->getName()}{else}{translate key="button.add.folder"}{/if} - {translate key="title.assets"} - {/block}

{block name="taskbar_panels" append}
    {if $folder->getId()}
        {url id="assets.folder.edit" parameters=["locale" => "%locale%", "folder" => $folder->getId()] var="url"}
    {else}
        {url id="assets.folder.add" parameters=["locale" => "%locale%"] var="url"}
    {/if}

    {call taskbarPanelLocales url=$url locale=$locale locales=$locales}
{/block}

{block name="content_title" append}
    <div class="page-header">
    {if $folder->getId()}
        <h1>{translate key="title.assets"} <small>{$folder->getName()}</small></h1>
    {else}
        <h1>{translate key="title.assets"} <small>{translate key="button.add.folder"}</small></h1>
    {/if}
    </div>
{/block}

{block name="content_body" append}
    {include file="base/form.prototype"}

    <form id="{$form->getId()}" class="form-horizontal" action="{$app.url.request}" method="POST" role="form">
        <fieldset>
            {call formRows form=$form}

            <div class="form-group">
                <div class="col-lg-offset-2 col-lg-10">
                    <input type="submit" class="btn btn-default" value="{translate key="button.save"}" />
                    {if $referer}
                        <a href="{$referer}" class="btn">{translate key="button.cancel"}</a>
                    {/if}
                </div>
            </div>
        </fieldset>
    </form>
{/block}

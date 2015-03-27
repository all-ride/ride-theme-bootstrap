{extends file="base/index"}

{block name="taskbar_panels" append}
    {if $localizeUrl}
        {call taskbarPanelLocales url=$localizeUrl locale=$locale locales=$locales}
    {/if}
{/block}

{block name="content_title"}
    <div class="page-header">
        <h1>{$title}{if $subtitle} <small>{$subtitle}</small>{/if}</h1>
    </div>
{/block}

{block name="content" append}
    {include file="base/form.prototype"}

    <form id="{$form->getId()}" class="form-horizontal" action="{$app.url.request}" method="POST" role="form" enctype="multipart/form-data">
        <fieldset>
            {if $tabs}
            <div class="tabbable">
                <ul class="nav nav-tabs">
                {foreach $tabs as $tabName => $tab}
                    <li{if $tabName == $activeTab} class="active"{/if}>
                        <a href="#tab{$tabName}" data-toggle="tab">{translate key=$tab.translation}</a>
                    </li>
                {/foreach}
                </ul>
                <div class="tab-content">
                {foreach $tabs as $tabName => $tab}
                    <div id="tab{$tabName}" class="tab-pane{if $tabName == $activeTab} active{/if}">
                    {foreach $tab.rows as $row}
                        {call formRow form=$form row=$row}
                    {/foreach}
                    </div>
                {/foreach}
                </div>
            </div>
            {/if}

            {call formRows form=$form}

            <div class="form-group">
                <div class="col-md-offset-2 col-md-10">
                    <input type="submit" class="btn btn-default" value="{translate key=$translationSubmit|default:"button.save"}"{if !$isWritable} disabled="disabled"{/if} />
                    <a class="btn" href="{$referer}">{translate key="button.cancel"}</a>
                </div>
            </div>
        </fieldset>
    </form>
{/block}

{block name="scripts" append}
    {script src="bootstrap/js/jquery-ui.js"}
    {script src="bootstrap/js/form.js"}
{/block}

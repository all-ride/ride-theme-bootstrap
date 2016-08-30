{extends file="base/index"}

{block name="head_title" prepend}{translate key="title.dashboard"} | {/block}

{block name="content_title"}
    <div class="page-header">
        <a href="#" class="btn btn-default btn-widget-add pull-right">
            {translate key="button.widget.add"}
        </a>
        <h1>{translate key="title.dashboard"}</h1>
    </div>
{/block}

{block name="content" append}
<div class="dashboard container-fluid"
    data-url-add="{url id="admin.dashboard.add"}"
    data-url-remove="{url id="admin.dashboard.remove"}"
        {* data-url-order="{url id="admin.dashboard.order"}" *}
>
    {foreach $layout as $region => $regionWidgets}
        <div class="col-xs-4" data-region="{$region}">
        {foreach $regionWidgets as $widgetId => $content}
            {$title = 'sme'}
            {$propertiesAction = null}
            {include file="dashboard/widget"}
        {/foreach}
        </div>
    {/foreach}
</div>

<ul>
{foreach $widgets as $widgetName => $widget}
<li>
    <a href="#" class="btn-widget-add" data-widget="{$widgetName}">
        {$widgetName}
    </a>
</li>
{/foreach}
</ul>
{/block}


{block name="styles" append}
    {style src="bootstrap/css/dashboard.css"}
{/block}

{block name="scripts" append}
    {script src="bootstrap/js/jquery-ui.js"}
    {script src="bootstrap/js/dashboard.js"}
{/block}

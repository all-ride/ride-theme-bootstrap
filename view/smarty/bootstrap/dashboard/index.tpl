{extends file="base/index"}

{block name="head_title" prepend}{translate key="title.dashboard"} - {/block}

{block name="content_title"}
    <div class="page-header">
        <h1>{translate key="title.dashboard"}</h1>
    </div>
{/block}

{block name="content" append}
<div class="dashboard">
    <div class="container-fluid">
        {foreach $layout as $region => $regionWidgets}
            <div class="col-xs-4" data-region="{$region}">
            {foreach $regionWidgets as $widgetId => $widget}
                <div class="widget widget-{$widgetId}" data-widget="{$widgetId}">
                    {$widget}
                </div>
            {/foreach}
            </div>
        {/foreach}
    </div>
</div>
{/block}

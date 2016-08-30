<div class="panel panel-default" id="widget{$widgetId}" data-widget="{$widgetId}">
    <div class="panel-heading">
        <div class="btn-group pull-right">
            <a class="btn btn-default btn-xs btn-widget-remove" href="#" title="{"button.close"|translate}">
                <span class="glyphicon glyphicon-remove"></span>
            </a>
        </div>
        <h3 class="panel-title">
        {if $propertiesAction}
            <a href="{$propertiesAction}" title="{"dashboard.button.properties"|translate}">{$title}</a>
        {else}
            {$title}
        {/if}
        </h3>
    </div>
    <div class="panel-body">
        {$content}
    </div>
</div>

{extends file="base/index"}

{block name="content_title"}
<div class="page-header">
    <h1>{$title}</h1>
</div>
{/block}

{block name="content_body" append}
    <div class="btn-group">
    {foreach $actions as $url => $dataAction}
        <a href="{$url}" class="btn btn-default">{$dataAction}</a>
    {/foreach}
    </div>
    
    <p></p>

    {include file="base/table" table=$table tableForm=$form tableAction=$action}
    
    {if $exports}
        {translate key="orm.label.export"}
        
        {foreach $exports as $extension => $url}
            <a href="{$url}" title="{translate key="orm.label.export.to" format=$extension}">{image src="img/export/`$extension`.png"}</a>
        {/foreach}
    {/if}
{/block}

{block name="scripts" append}
    <script src="{$app.url.base}/js/form.js"></script>
    <script src="{$app.url.base}/js/table.js"></script>
    <script type="text/javascript">
        $(function() {
            $('form').formCollection(); 
            $('form.table').table(); 
        });
    </script>
{/block}
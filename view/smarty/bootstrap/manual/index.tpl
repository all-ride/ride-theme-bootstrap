{extends file="base/index.sidebar"}

{block name="styles" append}
    <link href="{$app.url.base}/css/documentation.css" rel="stylesheet" media="screen">
{/block}

{block name="head_title" prepend}{translate key="title.manual"} - {/block}

{block name="content_title"}
<div class="page-header">
    <h1>{translate key="title.manual"}</h1>
</div>
{/block}

{block name="sidebar"}
    <h3>{translate key="title.pages"}</h3>
    {foreach $pages as $path => $pathPages}
        <ul class="nav nav-pills nav-stacked">
        {foreach $pathPages as $page}
            <li><a href="{$page->getUrl()}">{$page->getTitle()}</a></li>
        {/foreach}
        </ul>
    {/foreach}
{/block}
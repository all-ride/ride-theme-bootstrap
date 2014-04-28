{extends file="base/index"}

{block name="head_title" prepend}{translate key="title.users"} - {/block}

{block name="content_title"}
    <div class="page-header">
        <h1>{translate key="title.users"}</h1>
    </div>
{/block}

{block name="content" append}
    <div class="btn-group">
        <a class="btn btn-default" href="{url id="system.security.user.add"}?referer={$app.url.request|escape}">{translate key="button.user.add"}</a>
        <a class="btn btn-default" href="{url id="system.security.role"}">{translate key="button.roles.manage"}</a>
    </div>

    <p></p>

    {include file="base/table" table=$table tableForm=$form}
{/block}

{block name="scripts" append}
    <script src="{$app.url.base}/js/table.js"></script>
{/block}

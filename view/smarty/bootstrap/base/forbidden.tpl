{extends file="base/index"}

{block name="head_title" prepend}{translate key="title.forbidden"} | {/block}

{block name="content_title"}
    <div class="page-header">
        <h1>{translate key="title.forbidden"}</h1>
    </div>
{/block}

{block name="content_body" append}
    <p>{translate key="label.forbidden.description"}</p>
{/block}

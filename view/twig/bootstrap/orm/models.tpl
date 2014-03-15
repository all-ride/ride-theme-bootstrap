{extends file="base/index"}

{block name="head_title" prepend}{translate key="title.orm"} - {/block}

{block name="content_title"}
<div class="page-header">
    <h1>{translate key="title.orm"}</h1>
</div>
{/block}

{block name="content_body" append}
    {include file="base/table" table=$tableModels tableForm=$tableModelsForm tableAction=$tableModelsAction}
{/block}
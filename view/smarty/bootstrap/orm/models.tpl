{extends file="base/index"}

{block name="head_title" prepend}{translate key="title.orm"} - {/block}

{block name="content_title"}
<div class="page-header">
    <h1>{translate key="title.orm"}</h1>
    
    <table>
    {foreach $models as $modelName => $model}
        <tr>
            <td>
                <a href="{url id="orm.model" parameters=['model' => $modelName]}">{$modelName}</a>
                <div class="muted">
                </div>
            </td>
        </tr>
    {/foreach}
    </table>
</div>
{/block}
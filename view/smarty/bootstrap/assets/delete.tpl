{extends file="base/index"}

{block name="head_title" prepend}{$name} - {translate key="button.delete"} - {/block}

{block name="content_title" append}
    <div class="page-header">
        <h1>{translate key="button.delete"} <small>{$name}</small></h1>
    </div>
{/block}

{block name="content_body" append}
    {include file="base/form.prototype"}

    <form action="{$app.url.request}" method="POST" role="form">
        <div class="form-group">
            <p>{translate key="label.confirm.asset.delete" name=$name}</p>
        </div>

        <div class="form-group">
            <input type="submit" class="btn btn-danger" value="{translate key="button.delete"}" />
            {if $referer}
                <a class="btn" href="{$referer}">{translate key="button.cancel"}</a>
            {/if}
        </div>
    </form>
{/block}

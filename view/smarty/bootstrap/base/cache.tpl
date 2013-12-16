{extends file="base/index"}

{block name="head_title" prepend}{translate key="title.cache"} - {/block}

{block name="content_title"}
    <div class="page-header">
        <h1>{translate key="title.cache"}</h1>
    </div>
{/block}

{block name="content" append} 
    {include file="base/form.prototype"}

    <form id="{$form->getId()}" class="form-horizontal" action="{$app.url.request}" method="POST">
        <fieldset>
            <div class="form-group">
                <label class="control-label col-lg-2">{translate key="label.`$action`"}</label>
                <div class="col-lg-10">
                    {foreach $controls as $name => $control}
                        {call formWidget form=$form row=$name}
                    {/foreach}
                </div>
            </div>
                        
            <div class="form-actions col-lg-offset-2">
                <input type="submit" name="submit" class="btn btn-primary" value="{"label.`$action`"|translate}" />
                {if $action == "enable"}
                    <a href="{url id="system.cache.clear"}" class="btn">{translate key="button.cache.clear"}</a>
                {else}
                    <a href="{url id="system.cache"}" class="btn">{translate key="button.cancel"}</a>
                {/if}
            </div>
        </fieldset>
    </form>
{/block}
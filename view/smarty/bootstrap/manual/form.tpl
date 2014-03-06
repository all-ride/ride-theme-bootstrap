{extends file="manual/index"}

{block name="title" prepend}{$title} - {/block}

{block name="manual_content" append}
    <div class="page-header">
        <h1>{$title}</h1>
    </div>
    
    {include file="base/form.prototype"}

    <form id="{$form->getId()}" class="form-vertical" action="{$action}?referer={$referer|urlencode}" method="POST" role="form">
        <fieldset>
            {call formRows form=$form}
        
            <div class="form-group">
                <div class="col-lg-offset-2 col-lg-10">
                    <input type="submit" class="btn btn-default" value="{translate key="button.save"}" />
                    <a class="btn" href="{$referer}">{translate key="button.cancel"}</a>
                </div>
            </div>
        </fieldset>
    </form> 
{/block}
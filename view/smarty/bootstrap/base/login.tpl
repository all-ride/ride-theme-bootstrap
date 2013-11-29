{extends file="base/index"}

{block name="head_title" prepend}{translate key="title.login"} - {/block}

{block name="content"}
    <div class="col-md-offset-3 col-md-6">
        <div class="page-header">
            <h1>{translate key="title.login"}</h1>
        </div>
        
        {$smarty.block.parent}
        
        {include file="base/form.prototype"}
    
        <form id="{$form->getId()}" class="form-horizontal" action="{url id="login"}?referer={$referer|urlencode}" method="POST" role="form">
            <fieldset>
                {call formRows form=$form}
            
                <div class="form-group">
                    <div class="col-lg-offset-2 col-lg-10">
                        <input type="submit" class="btn btn-default" value="{translate key="button.login"}" />
                    </div>
                </div>
            </fieldset>
        </form>
    </div>
{/block}

{block name="scripts" append}
    <script type="application/javascript">$(function() { $('#form-username').focus(); });</script>     
{/block}
{extends file="base/index"}

{block name="head_title" prepend}{translate key="title.login"} | {/block}

{block name="content"}
    <div class="col-md-offset-3 col-md-4">
        <div class="page-header">
            <h1>{translate key="title.login"}</h1>
        </div>

        {$smarty.block.parent}

        {include file="base/form.prototype"}

        <form id="{$form->getId()}" class="form-horizontal" action="{url id="login"}{if $referer}?referer={$referer|urlencode}{/if}" method="POST" role="form">
            <fieldset>
                {$errors = $form->getValidationErrors('username')}
                <div class="form-group{if $errors} has-error{/if}">
                    <div class="col-lg-12">
                        {call formWidget form=$form row="username"}
                        {call formWidgetErrors form=$form row="username"}
                    </div>
                </div>

                <div class="form-group{if $errors} has-error{/if}">
                    <div class="col-lg-12">
                        {call formWidget form=$form row="password"}
                        <a href="{url id="profile.password.request"}" class="btn">{translate key="button.password.reset"}</a>
                    </div>
                </div>

                {call formRows form=$form}

                <div class="form-group">
                    <div class="col-lg-12">
                        <input type="submit" class="btn btn-default" value="{translate key="button.login"}" />
                        {if $referer}
                            <a href="{$referer}" class="btn">{translate key="button.cancel"}</a>
                        {/if}
                    </div>
                </div>
            </fieldset>
        </form>

        {if $urls}
        <ul class="list-unstyled">
            {foreach $urls as $service => $url}
            <li><a href="{$url}">{translate key="button.login.`$service`"}</a></li>
            {/foreach}
        </ul>
        {/if}
    </div>
{/block}

{block name="scripts_inline" append}
    <script type="application/javascript">$(function() { $('#form-username').focus(); });</script>
{/block}

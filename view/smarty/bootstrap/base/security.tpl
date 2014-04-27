{extends file="base/index"}

{block name="head_title" prepend}{translate key="title.security"} - {/block}

{block name="content_title"}
    <div class="page-header">
        <h1>{translate key="title.security"}</h1>
    </div>
{/block}

{block name="content" append}
    {include file="base/form.prototype"}

    <p>{translate key="label.security.description"}</p>

    <form id="{$form->getId()}" class="form-horizontal" action="{$app.url.request}" method="POST" role="form">
        <fieldset>
            <h3>{$form->getRow('secured-paths')->getLabel()}</h3>
            {call formWidget form=$form row="secured-paths"}

            {if $form->hasRow('allowed-paths')}
                <h3>{$form->getRow('allowed-paths')->getLabel()}</h3>
                <ul>
                {foreach $roles as $role}
                    <li class="role role-{$role->getId()}">
                        <a href="#">{$role->getName()}</a>
                        {call formWidget form=$form row="allowed-paths" part=$role->getId()}
                    </li>
                {/foreach}
                </ul>
            {/if}

            <div class="form-group">
                <div class="col-lg-12">
                    <input type="submit" class="btn btn-default" value="{translate key="button.save"}" />
                </div>
            </div>
        </fieldset>
    </form>
{/block}

{block name="scripts" append}
    <script src="{$app.url.base}/js/security.js"></script>
{/block}

{extends file="base/index"}

{block name="head_title" prepend}{if $server}{$server}{else}{translate key="title.server.add"}{/if} | {translate key="title.varnish"} | {/block}

{block name="content_title"}
<div class="page-header">
    <h1>{translate key="title.varnish"} <small>{if $server}{$server}{else}{translate key="title.server.add"}{/if}</small></h1>
</div>
{/block}

{block name="content_body" append}
    {include file="base/form.prototype"}

    <form id="{$form->getId()}" class="form-horizontal" action="{$app.url.request}" method="POST" role="form">
        <fieldset>
            {call formRows form=$form}

            <div class="form-group">
                <div class="col-lg-offset-2 col-lg-10">
                    <input type="submit" class="btn btn-default" value="{translate key="button.save"}" />
                    <a class="btn" href="{url id="varnish"}">{translate key="button.cancel"}</a>
                </div>
            </div>
        </fieldset>
    </form>
    {if $server}
    <hr />
    <form class="form-horizontal" action="{url id="varnish.server.delete" parameters=["server" => (string) $server]}" method="POST" role="form">
        <fieldset>
            <div class="form-group">
                <div class="col-lg-offset-2 col-lg-10">
                    <input type="submit" class="btn btn-default btn-danger" value="{translate key="button.delete"}" />
                </div>
            </div>
        </fieldset>
    </form>
    {/if}
{/block}

{extends file="base/index"}

{block name="head_title" prepend}{translate key="title.terminal"} - {/block}

{block name="content_title"}
    <div class="page-header">
        <h1>{translate key="title.terminal"}</h1>
    </div>
{/block}

{block name="content" append}
    {include file="base/form.prototype"}

    <form id="{$form->getId()}" action="{$app.url.request}" method="POST" role="form">
        <div class="result">
            <pre class="result"></pre>
        </div>
        <div class="bash">
            <pre class="bash"><span class="path">{$path}</span> $</pre> {call formWidget form=$form row="command"}
        </div>
    </form>
{/block}

{block name="styles" append}
    {style src="bootstrap/css/terminal.css" media="screen"}
{/block}

{block name="scripts_app" append}
    <script src="bootstrap/js/terminal.js"></script>
{/block}

{block name="scripts_inline" append}
    <script type="text/javascript">
        $(function() {
            ride.terminal.init();
        });
    </script>
{/block}


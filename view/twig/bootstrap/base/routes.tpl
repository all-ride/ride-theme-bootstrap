{extends file="base/index"}

{block name="head_title" prepend}{translate key="title.routes"} - {/block}

{block name="taskbar_panels" append}
    {call taskbarPanelSearch url=$app.url.request method="GET" query=$query}
{/block}

{block name="content_title"}
    <div class="page-header">
        {if $query}
        <h1>{translate key="title.routes.query" query=$query|escape}</h1>
        {else}
        <h1>{translate key="title.routes"}</h1>
        {/if}
    </div>
{/block}

{block name="content" append}
    <table class="table table-responsive table-striped">
        <thead>
            <tr>
                <th>{translate key="label.path"}</th>
                <th>{translate key="label.action"}</th>
                <th>{translate key="label.id"}</th>
                <th>{translate key="label.methods"}</th>
            </tr>
        </thead>
        <tbody>
    {foreach from=$routes item="route"}
        {$callback = $route->getCallback()}
        {$methods = $route->getAllowedMethods()}
        {$baseUrl = $route->getBaseUrl()}
            <tr>
                <td>
                    <a href="{if $baseUrl}{$baseUrl}{else}{$app.url.script}{/if}{$route->getPath()}">{$route->getPath()}</a>
                    {if $baseUrl}
                        <br />
                        <span class="help-block">{$baseUrl}</span>
                    {/if}
                </td>
                <td>{$callback[0]}->{$callback[1]}()</td>
                <td>{$route->getId()}</td>
                <td>{if $methods}{$methods|@array_keys|@implode:', '}{else}*{/if}</td>
            </tr>
    {/foreach}
        </tbody>
    </table>
{/block}
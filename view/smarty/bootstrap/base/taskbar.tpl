{function name="taskbarMenuItems" items=null class=null}
    {foreach from=$items item="item"}
        {if $item === '-'}
            <li role="presentation" class="divider"></li>
        {elseif is_string($item)}
            <li role="presentation" class="dropdown-header">{$item}</li>
        {elseif !method_exists($item, 'hasItems')}
            <li><a href="{$item->getUrl()}">{$item->getLabel()}</a></li>
        {elseif $class}
            <li class="{$class}">
                <a href="#" tabindex="-1" class="dropdown-toggle" data-toggle="dropdown">{$item->getLabel()} <b class="caret"></b></a>
                <ul class="dropdown-menu">
                {call taskbarMenuItems items=$item->getItems() class="dropdown-submenu"}
                </ul>
            </li>
        {else}
            <li role="presentation" class="dropdown-header">{$item->getLabel()}</li>
            {call taskbarMenuItems items=$item->getItems()}
        {/if}
    {/foreach}
{/function}

{function name="taskbarPanelSearch" url=null method=null query=null}
    {if !$method}
        {$method = "POST"}
    {/if}
    <li>
        <form action="{$url}" class="navbar-form" role="search" method="{$method}">
            <input type="text" name="query" class="form-control" placeholder="{translate key="label.search"}" value="{$query|escape}" />
        </form>
    </li>
{/function}

{function name="taskbarPanelLocales" url=null locale=null locales=null}
    <li class="dropdown">
        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
            {$locale|upper}
            <b class="caret"></b>
        </a>
        <ul class="dropdown-menu">
        {foreach $locales as $code => $locale}
            <li>
                <a href="{$url|replace:"%25locale%25":$code}">
                    {translate key="language.`$code`"}
                </a>
            </li>
        {/foreach}
        </ul>
    </li>
{/function}

<div class="navbar navbar-inverse">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            {block name="taskbar_title"}<a class="navbar-brand" href="{$app.url.base}">{$title}</a>{/block}
        </div>
        <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
            {block name="taskbar_applications"}
                {if $applicationsMenu->hasItems()}
                    {call taskbarMenuItems items=$applicationsMenu->getItems() class="dropdown"}
                {/if}
            {/block}
            </ul>
            <ul class="nav navbar-nav navbar-right">
                {block name="taskbar_panels"}
                {/block}
                {block name="taskbar_menu"}
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                        {if $app.user}
                            {if $app.user->getImage()}
                               <img src="{image src=$app.user->getImage() transformation="crop" width=18 height=18}" />
                            {/if}
                            {$app.user->getDisplayName()}
                        {else}
                            {translate key="label.user.anonymous"}
                        {/if}
                        <b class="caret"></b>
                    </a>
                    <ul class="dropdown-menu">
                        {block name="taskbar_settings"}
                            {if $settingsMenu->hasItems()}
                                {call taskbarMenuItems items=$settingsMenu->getItems()}
                            {/if}
                        {/block}
                    </ul>
                </li>
                {/block}
            </ul>
        </div><!--/.navbar-collapse -->
    </div>
</div>

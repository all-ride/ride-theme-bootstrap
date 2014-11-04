<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
    <head>
{block name="head"}
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>{block name="head_title"}{if isset($app.taskbar)}{$app.taskbar->getTitle()}{/if}{/block}</title>
    {block name="styles"}
        <link href="{$app.url.base}/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen">
        <link href="{$app.url.base}/bootstrap/css/custom.css" rel="stylesheet" media="screen">
    {/block}

    {block name="styles_app"}
        {if isset($app.styles)}
            {foreach $app.styles as $style => $null}
                {if substr($style, 0, 7) == 'http://' || substr(style, 0, 8) == 'https://' || substr($style, 0, 2) == '//'}
                    <link href="{$style}" rel="stylesheet" media="screen">
                {else}
                    <link href="{$app.url.base}/bootstrap/{$style}" rel="stylesheet" media="screen">
                {/if}
            {/foreach}
        {/if}
    {/block}
{/block}
    </head>
    <body>
{block name="body"}
    {block name="taskbar"}
        {if isset($app.taskbar)}
            {include file="base/taskbar" title=$app.taskbar->getTitle() applicationsMenu=$app.taskbar->getApplicationsMenu() settingsMenu=$app.taskbar->getSettingsMenu()}
        {/if}
    {/block}
    {block name="container"}
        <div class="container">
        {block name="content"}
            {block name="content_title"}{/block}
            {block name="messages"}
                {if isset($app.messages)}
                    {$_messageTypes = ["error" => "danger", "warning" => "warning", "success" => "success", "information" => "info"]}
                    {foreach $_messageTypes as $_messageType => $_messageClass}
                        {$_messages = $app.messages->getByType($_messageType)}
                        {if $_messages}
                            <div class="alert alert-{$_messageClass}">
                            {if $_messages|count == 1}
                                {$_message = $_messages|array_pop}
                                <p>{$_message->getMessage()}</p>
                            {else}
                                <ul>
                                {foreach $_messages as $_message}
                                    <li>{$_message->getMessage()}</li>
                                {/foreach}
                                </ul>
                            {/if}
                            </div>
                        {/if}
                    {/foreach}
                {/if}
            {/block}
            {block name="content_body"}{/block}
        {/block}
        </div>
    {/block}
    {block name="scripts"}
        <script src="{$app.url.base}/bootstrap/js/jquery.js"></script>
        <script src="{$app.url.base}/bootstrap/js/bootstrap.min.js"></script>
    {/block}
    {block name="scripts_app"}
    {if isset($app.javascripts)}
        {foreach $app.javascripts as $script => $null}
            {if substr($script, 0, 7) == 'http://' || substr(script, 0, 8) == 'https://' || substr($script, 0, 2) == '//'}
        <script src="{$script}"></script>
            {elseif substr($script, 0, 7) == '<script'}
        {$script}
            {else}
        <script src="{$app.url.base}/bootstrap/{$script}"></script>
            {/if}
        {/foreach}
    {/if}
    {if isset($app.inlineJavascripts)}
        <script type="text/javascript">
            $(function() {
            {foreach $app.inlineJavascripts as $inlineJavascript}
                {$inlineJavascript}
            {/foreach}
            });
        </script>
    {/if}
    {/block}
{/block}
    </body>
</html>

{extends file="base/index"}

{block name="head_title" prepend}{if $asset->getId()}{$asset->getName()}{else}{translate key="button.add.asset"}{/if} - {translate key="title.assets"} - {/block}

{block name="taskbar_panels" append}
    {if $asset->getId()}
        {url id="assets.asset.edit" parameters=["locale" => "%locale%", "asset" => $asset->getId()] var="url"}
    {else}
        {url id="assets.asset.add" parameters=["locale" => "%locale%"] var="url"}
        {if $folder && $folder->getId()}
            {$folderId = $folder->getId()}
            {$url = "`$url`?folder=`$folderId`"}
        {/if}
    {/if}

    {call taskbarPanelLocales url=$url locale=$locale locales=$locales}
{/block}

{block name="content_title" append}
    <div class="page-header">
        {if $asset->getId()}
            <h1>{translate key="title.assets"} <small>{$asset->getName()}</small></h1>
        {else}
            <h1>{translate key="title.assets"} <small>{translate key="button.add.asset"}</small></h1>
        {/if}
    </div>
{/block}

{block name="content_body" append}
    {include file="base/form.prototype"}
    <form id="{$form->getId()}" class="form-horizontal" action="{$app.url.request}" method="POST" role="form" enctype="multipart/form-data">
    <div class="row">
        <div class="col-md-{if $asset->getId()}6{else}12{/if}">
            <fieldset>
                {call formRow form=$form row="asset"}

                <div class="form-group">
                    <div class="col-lg-offset-2 col-lg-10">
                        <input type="submit" class="btn btn-default" value="{translate key="button.save"}"/>
                        {if $referer}
                            <a href="{$referer}" class="btn">{translate key="button.cancel"}</a>
                        {/if}
                    </div>
                </div>
            </fieldset>
        </div>
        {if $asset->getId()}
        <div class="col-md-6">
            <div class="tab">
                <div class="tabbable">
                    <ul class="nav nav-tabs">
                        <li class="active"><a href="#tab-original" data-toggle="tab">{translate key="label.original"}</a></li>
                        {foreach $styles as $style}
                            <li><a href="#tab-{$style->getSlug()}" data-toggle="tab">{$style->getName()}</a></li>
                        {/foreach}
                    </ul>
                </div>

                <div class="tab-content">
                    <div id="tab-original" class="tab-pane active">
                        <dl>
                            <dt>{translate key="label.url"}</dt>
                            <dd>
                                {url id="assets.value" parameters=["asset" => $asset->getId()] var="valueUrl"}
                                <a href="{$valueUrl}">{$valueUrl}</a>
                            </dd>
                            <dt>{translate key="label.type"}</dt>
                            <dd>{$asset->getType()}</dd>
                            {if $dimension}
                                <dt>{translate key="label.dimension"}</dt>
                                <dd>{$dimension->getWidth()} x {$dimension->getHeight()}</dd>
                            {/if}
                        </dl>

                        {if $media}
                            <iframe width="560" height="315" src="{$media->getEmbedUrl()}" frameborder="0" allowfullscreen></iframe>
                        {else}
                            <img class="img-responsive" src="{image src=$asset->getImage()}" />
                        {/if}
                    </div>

                    {foreach $styles as $style}
                    <div id="tab-{$style->getSlug()}" class="tab-pane">
                        <ul>
                        {foreach $style->getTransformations() as $transformation}
                            <li>{$transformation->getName()}</li>
                        {/foreach}
                        </ul>
                        <div class="col-md-12">
                        <div class="form-group">
                            {call formWidget form=$form row="style-`$style->slug`"}
                            {call formWidgetErrors form=$form row="style-`$style->slug`"}
                        </div>
                        </div>
                    </div>
                    {/foreach}
                </div>
            </div>
        </div>
        {/if}
    </div>
    </form>
{/block}

{block name="scripts" append}
    {script src="bootstrap/js/jquery-ui.js"}
    {script src="bootstrap/js/form.js"}
{/block}

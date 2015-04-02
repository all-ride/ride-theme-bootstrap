<div class="row" data-order="true">
    <div class="asset-items-folders">
    {foreach $folders as $item}
        <div class="col-md-2 order-item" data-type="{$item->getType()}" data-id="{$item->getId()}">
            <div class="image">
                <a href="{url id="assets.folder.overview" parameters=["locale" => $locale, "folder" => $item->id]}{$urlSuffix}">
                    <img src="{$app.url.base}/bootstrap/img/folder.svg" width="200" height="200" class="data img-responsive" />
                </a>
            </div>
            <div class="name">
                <div class="option{if !$isFiltered} order-handle{/if}">
                    <input type="checkbox" name="folders[]" value="{$item->getId()}" />
                </div>
                <a href="{url id="assets.folder.edit" parameters=["locale" => $locale, "folder" => $item->getId()]}?embed={$embed}&referer={$app.url.request|urlencode}">
                    {$item->getName()}
                </a>
            </div>
        </div>
    {/foreach}
    </div>

    <div class="asset-items-assets">
    {foreach $assets as $item}
        <div class="col-md-2 order-item" data-type="{$item->getType()}" data-id="{$item->getId()}">
            <div class="image">
            {if $item->getThumbnail()}
                <img src="{image src=$item->getThumbnail() width=200 height=200 transformation="crop"}" class="data img-responsive" />
            {/if}
            </div>
            <div class="name">
                <div class="option{if !$isFiltered} order-handle{/if}">
                    <input type="checkbox" name="assets[]" value="{$item->getId()}" />
                </div>
                <a href="{url id="assets.asset.edit" parameters=["locale" => $locale, "asset" => $item->getId()]}?embed={$embed}&referer={$app.url.request|urlencode}">
                    {$item->getName()}
                </a>
            </div>
        </div>
    {/foreach}
    </div>
</div>

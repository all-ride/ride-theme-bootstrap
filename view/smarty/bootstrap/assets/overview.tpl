{extends file="base/index"}

{block name="head_title" prepend}{if $folder->getId()}{$folder->getName()} - {/if}{translate key="title.assets"} - {/block}

{block name="taskbar_panels" append}
    {url id="assets.folder.overview" parameters=["locale" => "%locale%", "folder" => $folder->id] var="url"}
    {$url = "`$url``$urlSuffix`"}
    {call taskbarPanelLocales url=$url locale=$locale locales=$locales}
{/block}

{block name="content_title"}
<div class="page-header">
    <h1>{translate key="title.assets"}{if $folder->getId()} <small>{$folder->getName()}</small>{/if}</h1>
</div>
{/block}

{block name="content_body" append}
    <div class="breadcrumbs">
        <ol class="breadcrumb">
            <li><a href="{url id="assets.overview.locale" parameters=["locale" => $locale]}?view={$view}&embed={$embed}&limit={$limit}">{translate key="title.assets"}</a></li>
        {foreach $breadcrumbs as $id => $name}
            <li><a href="{url id="assets.folder.overview" parameters=["locale" => $locale, "folder" => $id]}?view={$view}&embed={$embed}&limit={$limit}">{$name}</a></li>
        {/foreach}
        </ol>
    </div>

    {include file="base/form.prototype"}
    <form id="{$form->getId()}" class="form-horizontal form-filter" action="{$app.url.request}" method="POST" role="form">
        <div class="actions clearfix">
            <div class="btn-group">
                <a href="{url id="assets.asset.add" parameters=["locale" => $locale]}?folder={$folder->id}&embed={$embed}&referer={$app.url.request|urlencode}" class="btn btn-default">
                   {translate key="button.add.asset"}
                </a>
                <a href="{url id="assets.folder.add" parameters=["locale" => $locale]}?folder={$folder->id}&embed={$embed}&referer={$app.url.request|urlencode}" class="btn btn-default">
                   {translate key="button.add.folder"}
                </a>
            </div>

            <div class="btn-group">
                <a href="{url id="assets.folder.overview" parameters=["locale" => $locale, "folder" => $folder->id]}?view=grid&type={$filter.type}&date={$filter.date}&limit={$limit}&embed={$embed}" class="btn btn-default{if $view == "grid"} active{/if}">
                    <i class="glyphicon glyphicon-th"></i>
                </a>
                <a href="{url id="assets.folder.overview" parameters=["locale" => $locale, "folder" => $folder->id]}?view=list&type={$filter.type}&date={$filter.date}&limit={$limit}&embed={$embed}" class="btn btn-default{if $view == "list"} active{/if}">
                    <i class="glyphicon glyphicon-th-list"></i>
                </a>
            </div>

            {call formWidget form=$form row="type"}
            {call formWidget form=$form row="date"}
            {call formWidget form=$form row="query"}
            <button name="submit" value="filter" type="submit" class="btn btn-default btn-filter">{translate key="button.filter"}</button>
        </div>

    {if $folder->description}
        <div class="description">{$folder->description}</div>
    {/if}

        <div class="assets assets-{$view}">
            <div class="asset-items clearfix">
                {include file="assets/overview.`$view`" inline}
            </div>
        </div>

        <div class="row">
            <div class="col-md-3">
                <input type="checkbox" name="all" class="select-all" />
                <select name="action" class="form-control form-action">
                    <option value="">- {translate key="label.actions.bulk"} -</option>
                    <option value="delete">{translate key="button.delete"}</option>
                </select>
                <button name="submit" value="bulk-action" type="submit" class="btn btn-default btn-bulk">{translate key="button.apply"}</button>
            </div>
            <div class="col-md-6 text-center">
                {if $pages > 1}
                    {pagination pages=$pagination->getPages() page=$pagination->getPage() href=$pagination->getHref()}
                {/if}
            </div>
            <div class="col-md-3 limit-actions text-right">
                <select name="limit" class="form-control form-limit">
                    <option value="12"{if $limit == 12} selected="selected"{/if}>12</option>
                    <option value="18"{if $limit == 18} selected="selected"{/if}>18</option>
                    <option value="24"{if $limit == 24} selected="selected"{/if}>24</option>
                    <option value="48"{if $limit == 48} selected="selected"{/if}>48</option>
                    <option value="96"{if $limit == 96} selected="selected"{/if}>96</option>
                </select>
                <button name="submit" value="limit" type="submit" class="btn btn-default btn-limit">{translate key="button.show"}</button>
            </div>
        </div>
        <div class="row text-center">
            <br />
            <select name="order" class="form-control form-order">
                <option value="">- {translate key="label.actions.order"} -</option>
                <option value="asc">{translate key="label.order.asc"}</option>
                <option value="desc">{translate key="label.order.desc"}</option>
                <option value="newest">{translate key="label.order.newest"}</option>
                <option value="oldest">{translate key="label.order.oldest"}</option>
            </select>
            <button name="submit" value="order" type="submit" class="btn btn-default btn-order">{translate key="button.order"}</button>
        </div>
    </form>
{/block}

{block name="styles" append}
    {style src="bootstrap/css/assets.css" media="screen"}
{/block}

{block name="scripts" append}
    {script src="bootstrap/js/jquery-ui.js"}
{/block}

{block name="scripts_inline" append}
    <script type="text/javascript">
        $(function () {
            $('.select-all').click(function() {
                $('.order-item input[type=checkbox]').prop('checked', $(this).prop('checked'));
            });

            $('.form-limit').on('change', function() {
                $('.btn-limit').trigger('click');
            });
            $('.btn-limit').hide();

        {if !$isFiltered}
            var sortFolderUrl = "{url id="assets.folder.sort" parameters=["locale" => $locale, "folder" => $folder->getId()]}";
            var sortAssetUrl = "{url id="assets.asset.sort" parameters=["locale" => $locale, "folder" => $folder->getId()]}";

            $(".asset-items-folders").sortable({
                cursor: "move",
                handle: ".order-handle",
                items: ".order-item",
                select: false,
                scroll: true,
                update: function (event, ui) {
                    var order = [];

                    $('.asset-items-folders .order-item').each(function() {
                        var $this = $(this);

                        order.push($this.data('id'));
                    });

                    $.post(sortFolderUrl, {ldelim}order: order, page: {$page}, limit: {$limit}});
                }
            });

            $(".asset-items-assets").sortable({
                cursor: "move",
                handle: ".order-handle",
                items: ".order-item",
                select: false,
                scroll: true,
                update: function (event, ui) {
                    var order = [];

                    $('.asset-items-assets .order-item').each(function() {
                        var $this = $(this);

                        order.push($this.data('id'));
                    });

                    $.post(sortAssetUrl, {ldelim}order: order, page: {$page}, limit: {$limit}});
                }
            });
        {/if}
        });
    </script>
{/block}

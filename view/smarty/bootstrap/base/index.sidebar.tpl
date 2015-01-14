{extends file="base/index"}

{block name="content"}
    <div class="col-md-3 sidebar">
        {block name="sidebar"}{/block}
    </div>
    <div class="col-md-9">
        {block name="content_main"}
            {$smarty.block.parent}
        {/block}
    </div>
{/block}

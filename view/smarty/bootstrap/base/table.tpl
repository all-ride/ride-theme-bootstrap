{if $table->hasRows() || $table->hasSearch()}
    {tableVars}
    {include file="base/form.prototype"}

    {$tableMessages = json_encode($table->getActionConfirmationMessages())}
    <form id="{$tableForm->getId()}" action="{$tableAction}" method="POST" class="table" role="form" data-confirm-messages="{$tableMessages|escape}">
        {formWidget form=$tableForm row=$tableNameField}
        
        <fieldset>
    
        {if $table->hasOrderMethods() || $table->hasSearch()}
            <div class="row-fluid table-header clearfix">
                <div class="col-md-4"></div>
                <div class="col-md-4 search">
                    {if $table->hasSearch()}
                        {block name="table.search"}
                            {$tableForm->getRow($tableSearchQueryField)->getWidget()->setAttribute('placeholder', "label.search"|translate)}
                            {formWidget form=$tableForm row=$tableSearchQueryField}
                        {/block}
                    {/if}
                </div>
                <div class="col-md-4 order">
                    {if $table->hasOrderMethods()}
                        {block name="table.order"}
                            {translate key="label.table.order"}
                            {formWidget form=$tableForm row=$tableOrderField}
                
                            {if $table->getOrderDirection() == 'asc'}
                                {assign var="direction" value="desc"}
                                {assign var="iconClass" value="glyphicon glyphicon-chevron-down"}
                            {else}
                                {assign var="direction" value="asc"}
                                {assign var="iconClass" value="glyphicon glyphicon-chevron-up"}
                            {/if}
                
                            <a href="{$table->getOrderDirectionUrl()|replace:"%direction%":$direction}">
                                <i class="{$iconClass}"></i>
                            </a>
                        {/block}
                    {/if}
                </div>
            </div>
        {/if}
    
        {if $table->hasRows()}
            {block name="table.content"}
                {$table->getHtml()}
            {/block}
    
            {if $table->hasActions() || $table->hasPaginationOptions()}
                <div class="row-fluid">
                    <div class="options col-md-3">    
                        {if $table->hasActions()}
                            {block name="table.actions"}
                                {if $tableForm->hasRow($tableActionField)}
                                    <input type="checkbox" id="{$tableForm->getId()}-action-all" class="check-all" />
                                    {formWidget form=$tableForm row=$tableActionField}
                                {/if}                    
                            {/block}
                        {/if}
                    </div>
                    {if $table->hasPaginationOptions()}
                        {block name="table.pagination"}
                            {if $table->getRowsPerPage() || $table->getPaginationOptions()}
                                {assign var="page" value=$table->getPage()}
                                {assign var="pages" value=$table->getPages()}
                                {assign var="href" value=$table->getPaginationUrl()}
                                
                                <div class="col-md-6 pagination">
                                    {if $pages > 1}
                                        {pagination page=$page pages=$pages href=$href}
                                    {/if}
                                </div>
                                <div class="col-md-3 pagination-options">
                                    {if $table->getPaginationOptions()}
                                        {formWidget form=$tableForm row=$tablePageRowsField}
                                        {translate key="label.table.rows.page"}
                                    {/if}

                                    ({translate key="label.table.rows.total" rows=$table->countRows()})
                                </div>
                            {else}
                                <div class="col-md-9 pagination-options">
                                    {translate key="label.table.rows.total" rows=$table->countRows()}
                                </div>
                            {/if}
                        {/block}
                    {/if}
                </div>
            {/if}
        {/if}
        </fieldset>
    </form>     
{else}
    <p>No rows</p>
{/if}
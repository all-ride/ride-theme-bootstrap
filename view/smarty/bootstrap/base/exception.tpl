{extends file="base/index"}

{block name="head_title" prepend}{translate key="title.exception"} | {/block}

{block name="content_title"}
    <div class="page-header">
        <h1>{translate key="title.exception"}</h1>
    </div>
{/block}

{block name="content" append}
    <p>{translate key="label.exception.report.description"}</p>

    {if $form}
        <p>{translate key="label.exception.report.form"}</p>
        {include file="base/form.prototype"}

        <form id="{$form->getId()}" class="form-horizontal" action="{url id="system.exception" parameters=["id" => $id]}" method="POST">
            <fieldset>
                <div class="form-group">
                    <div class="col-lg-12">
                        {call formWidget form=$form row="comment"}
                    </div>
                </div>

                <div class="form-group">
                    <div class="col-lg-12">
                        <input type="submit" name="submit" class="btn btn-default" value="{translate key="button.submit.report"}" />
                    </div>
                </div>
            </fieldset>
        </form>
    {/if}
{/block}

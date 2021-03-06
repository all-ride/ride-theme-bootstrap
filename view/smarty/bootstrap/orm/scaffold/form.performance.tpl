{extends file="base/index"}

{block name="taskbar_panels" append}
    {if $localizeUrl}
        {call taskbarPanelLocales url=$localizeUrl locale=$locale locales=$locales}
    {/if}
{/block}

{block name="content_title"}
    <div class="page-header">
        <h1>{$title}</h1>
    </div>
{/block}

{block name="content" append}
    {include file="base/form.prototype"}

    <form id="{$form->getId()}" class="form-horizontal" action="{$app.url.request}" method="POST" role="form" enctype="multipart/form-data">
        <fieldset>
            <div class="form-group row-date clearfix">
                <label for="form-event-dateStart" class="col-md-2 control-label">{translate key="label.date"}</label>
                <div class="col-md-10">
                    {call formWidget form=$form row=$form->getRow('date')->getRow('dateStart')}
                    {call formWidget form=$form row=$form->getRow('date')->getRow('timeStart')}
                    <span class="until">&nbsp;{"label.until"|translate|lower}&nbsp;</span>
                    {call formWidget form=$form row=$form->getRow('date')->getRow('dateStop')}
                    {call formWidget form=$form row=$form->getRow('date')->getRow('timeStop')}

                    {call formWidget form=$form row=$form->getRow('date')->getRow('isDay')}
                    {call formWidget form=$form row=$form->getRow('date')->getRow('isPeriod')}
                    {call formWidget form=$form row=$form->getRow('date')->getRow('isRepeat')}
                </div>
                <div class="col-md-offset-2 col-md-10">
                    {call formWidgetErrors form=$form row=$form->getRow('date')->getRow('dateStart')}
                    {call formWidgetErrors form=$form row=$form->getRow('date')->getRow('timeStart')}
                    {call formWidgetErrors form=$form row=$form->getRow('date')->getRow('dateStop')}
                    {call formWidgetErrors form=$form row=$form->getRow('date')->getRow('timeStop')}

                    {call formWidgetErrors form=$form row=$form->getRow('date')->getRow('isDay')}
                    {call formWidgetErrors form=$form row=$form->getRow('date')->getRow('isPeriod')}
                    {call formWidgetErrors form=$form row=$form->getRow('date')->getRow('isRepeat')}
                </div>
            </div>

            <div class="repeater">
                <div class="form-group row-step clearfix">
                    <label for="form-event-step" class="col-md-2 control-label">{translate key="label.mode"}</label>
                    <div class="col-md-10">
                        {call formWidget form=$form row=$form->getRow('date')->getRow('mode')}
                        &nbsp;{"label.event.every"|translate|lower}&nbsp;
                        {call formWidget form=$form row=$form->getRow('date')->getRow('step')}
                        <span class="step step-daily">{"label.days"|translate|lower}</span>
                        <span class="step step-weekly">{"label.weeks"|translate|lower}</span>
                        <span class="step step-monthly">{"label.months"|translate|lower}</span>
                        <span class="step step-yearly">{"label.years"|translate|lower}</span>
                    </div>
                </div>

                {call formRow form=$form row=$form->getRow('date')->getRow('weekly')}
                {call formRow form=$form row=$form->getRow('date')->getRow('monthly')}

                <div class="form-group row-until clearfix">
                    <label class="col-md-2 control-label" for="form-event-performance-until">{translate key="label.until"}</label>
                    <div class="col-md-10">
                        <div class="radio">
                            <label>
                                {call formWidget form=$form row=$form->getRow('date')->getRow('until') part="date"}
                                {"label.date"|translate}&nbsp;
                            </label>
                            {call formWidget form=$form row=$form->getRow('date')->getRow('dateUntil')}
                            {call formWidgetErrors form=$form row=$form->getRow('date')->getRow('dateUntil')}
                        </div>
                        <div class="radio">
                            {call formWidget form=$form row=$form->getRow('date')->getRow('until') part="occurences"}
                            {call formWidget form=$form row=$form->getRow('date')->getRow('occurences')}
                            <label for="date-until-occurences">
                                &nbsp;{"label.occurences"|translate|lower}
                            </label>
                            {call formWidgetErrors form=$form row=$form->getRow('date')->getRow('occurences')}
                        </div>
                        {call formWidgetErrors form=$form row=$form->getRow('date')->getRow('until')}
                    </div>
                </div>
            </div>

            <div class="edit-confirm hide">
                {call formRow form=$form row="editMode"}
                {call formRow form=$form row="ignoreEdited"}
            </div>

            {call formRows form=$form}

            <div class="form-group">
                <div class="col-md-offset-2 col-md-10">
                    <input type="submit" class="btn btn-default" value="{translate key="button.save"}" />
                    <a class="btn" href="{$referer}">{translate key="button.cancel"}</a>
                </div>
            </div>
        </fieldset>
    </form>
{/block}

{block name="styles" append}
    {style src="bootstrap/css/calendar.css" media="screen"}
{/block}

{block name="scripts" append}
    {script src="bootstrap/js/jquery-ui.js"}
    {script src="bootstrap/js/form.js"}
    {script src="bootstrap/js/calendar.js"}
{/block}

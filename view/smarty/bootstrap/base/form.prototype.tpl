{*
    Prototype functions for the form rendering

    To override, create a file and recreate the functions you wish to override.
    At the end of your file, include this one to define the missing functions.
*}

{*
    Renders the rows of the form
*}
{function name="formRows" rows=null form=null rowClass=null}
    {if !$form && isset($block_form)}
        {$form = $block_form}
    {/if}

    {if !$rows && $form}
        {$rows = $form->getRows()}
    {/if}

    {if $rows}
        {foreach $rows as $row}
            {if !$row->isRendered()}
                {call formRow form=$form row=$row class=$rowClass}
            {/if}
        {/foreach}
    {/if}
{/function}

{*
    Renders a simple row of the form
*}
{function name="formRow" form=null row=null part=null class=null}
    {if !$form && isset($block_form)}
        {$form = $block_form}
    {/if}

    {if is_string($row) && $form}
        {$row = $form->getRow($row)}
    {/if}

    {if $row}
        {$type = $row->getType()}
        {if $type == 'hidden'}
            {call formWidget form=$form row=$row part=$part}

            {$errors = $form->getValidationErrors($row->getName())}
            {if $errors}
            <div class="form-group has-error">
                {call formWidgetErrors form=$form row=$row}
            </div>
            {/if}
        {elseif $type == 'component' && $row->getOption('embed')}
            {call formWidgetComponent form=$form row=$row}
        {elseif $type == 'collection'}
            {$errors = $form->getValidationErrors($row->getName())}

            <div class="form-group row-{$row->getName()|replace:'[':''|replace:']':''}{if $row->isDisabled()} disabled{/if}{if $row->isReadOnly()} readonly{/if} clearfix{if $errors} has-error{/if}{if $class} {$class}{/if}">
                <label class="col-md-2 control-label">{$row->getLabel()}</label>

                {call formCollectionPrototype assign="prototype" form=$form row=$row part='%prototype%'}
                <div class="col-md-10 collection-controls" data-prototype="{$prototype|escape:"html"|trim|replace:"\n":''}">
                    {call formWidgetCollection form=$form row=$row part=$part}

                   {if $errors}
                        <ul class="text-danger">
                        {foreach $errors as $error => $null}
                            <li>{$error}</li>
                        {/foreach}
                        </ul>
                    {/if}

                    {$description = $row->getDescription()}
                    {if $description}
                    <span class="help-block">{$description}</span>
                    {/if}
                </div>
            </div>
        {else}
            {$errors = $form->getValidationErrors()}
            {$widget = $row->getWidget()}
            {$errorsName = $widget->getName()}
            {if $widget->isMultiple() && $part}
                {$errorsName = "`$errorsName`[`$part`]"}
            {/if}

            {if isset($errors.$errorsName)}
                {$errors = $errors.$errorsName}
            {else}
                {$errors = array()}
            {/if}

            <div class="form-group row-{$row->getName()|replace:'[':''|replace:']':''}{if $row->isDisabled()} disabled{/if}{if $row->isReadOnly()} readonly{/if} clearfix{if $errors} has-error{/if}{if $class} {$class}{/if}">
                <label class="col-md-2 control-label" for="{$widget->getId()}">{if $type != 'button'}{$row->getLabel()}{/if}</label>
                <div class="col-md-10">
                    {call formWidget form=$form row=$row part=$part}

                    {if $errors}
                        <ul class="text-danger">
                        {foreach $errors as $error}
                            <li>{$error->getCode()|translate:$error->getParameters()}</li>
                        {/foreach}
                        </ul>
                    {/if}

                    {if $widget && $type == 'option'}
                        {$widgetOptions = $widget->getOptions()}
                    {else}
                        {$widgetOptions = array()}
                    {/if}

                    {$description = $row->getDescription()}
                    {if $description && $type !== 'checkbox' && ($type !== 'option' || ($type === 'option' && $widget && $widgetOptions))}
                        <span class="help-block">{$description}</span>
                    {/if}

                    {if $type == 'date'}
                        <span class="help-block">{translate key="label.date.example" example=time()|date_format:$row->getFormat() format=$row->getFormat()}</span>
                    {elseif $type == 'select' && $widget->isMultiple()}
                        <span class="help-block">{translate key="label.multiselect"}</span>
                    {/if}

{*
                    {if $type == 'image' && $row->getData()}
                        {image src=$row->getData() width=100 height=100 thumbnail="crop"}
                    {/if}
*}
                </div>
            </div>
        {/if}

        {$row->setIsRendered(true)}
    {else}
        <div class="alert alert-danger">No row provided</div>
    {/if}
{/function}

{*
    Renders the errors of a single widget of the form
*}
{function name="formWidgetErrors" form=null row=null part=null}
    {if !$form && isset($block_form)}
        {$form = $block_form}
    {/if}

    {if is_string($row) && $form}
        {$row = $form->getRow($row)}
    {/if}

    {if $row}
        {$widget = $row->getWidget()}

        {if $widget}
            {$errors = $form->getValidationErrors()}
            {$errorsName = $widget->getName()}
            {if $widget->isMultiple() && $part}
                {$errorsName = "`$errorsName`[`$part`]"}
            {/if}

            {if isset($errors.$errorsName)}
                {$errors = $errors.$errorsName}
            {else}
                {$errors = array()}
            {/if}

            {if $errors}
                <ul class="errors help-block">
                {foreach $errors as $error}
                    <li>{$error->getCode()|translate:$error->getParameters()}</li>
                {/foreach}
                </ul>
            {/if}
        {else}
            <span class="error">No widget set in row {$row->getName()}.</span>
        {/if}
    {else}
        <span class="error">No row provided</span>
    {/if}
{/function}

{*
    Renders a single control of the form
*}
{function name="formWidget" form=null row=null part=null type=null}
    {if !$form && isset($block_form)}
        {$form = $block_form}
    {/if}

    {if is_string($row) && $form}
        {$row = $form->getRow($row)}
    {/if}

    {if $row}
        {if !$type}
            {$type = $row->getType()|ucfirst}
        {/if}

        {if !$type}
            <span class="error">No type provided for row {$row->getName()}</span>
        {else}
            {$function = "formWidget`$type`"}
            {call $function form=$form row=$row part=$part}

            {$row->setIsRendered(true)}
        {/if}
    {else}
        <span class="error">No row provided</span>
    {/if}
{/function}

{function name="formWidgetHidden" form=null row=null part=null}
    {if !$form && isset($block_form)}
        {$form = $block_form}
    {/if}

    {if is_string($row) && $form}
        {$row = $form->getRow($row)}
    {/if}

    {$widget = $row->getWidget()}
    {if $widget}
        <input type="hidden"
               name="{$widget->getName()}{if $part}[{$part}]{/if}"
               value="{$widget->getValue($part)|escape}"
           {foreach $widget->getAttributes() as $name => $attribute}
               {$name}="{$attribute|escape}"
           {/foreach}
         />
    {/if}
{/function}

{function name="formWidgetLabel" form=null row=null part=null}
    {if !$form && isset($block_form)}
        {$form = $block_form}
    {/if}

    {if is_string($row) && $form}
        {$row = $form->getRow($row)}
    {/if}

    {$widget = $row->getWidget()}
    {if $widget}
        <span
           {foreach $widget->getAttributes() as $name => $attribute}
               {$name}="{$attribute|escape}"
           {/foreach}
         >{$widget->getValue($part)|escape}</span>
    {/if}
{/function}

{function name="formWidgetButton" form=null row=null part=null}
    {if !$form && isset($block_form)}
        {$form = $block_form}
    {/if}

    {if is_string($row) && $form}
        {$row = $form->getRow($row)}
    {/if}

    {$widget = $row->getWidget()}
    {if $widget}
        {$attributes = $widget->getAttributes()}
        {if isset($attributes.class)}
            {$attributes.class = "`$attributes.class` btn btn-default"}
        {else}
            {$attributes.class = 'btn btn-default'}
        {/if}

        <button
            name="{$widget->getName()}{if $widget->isMultiple() || $part !== null}[{$part}]{/if}"
            value="{$widget->getValue($part)|escape}"
           {foreach $attributes as $name => $attribute}
               {$name}="{$attribute|escape}"
           {/foreach}
         >{$row->getLabel()}</button>
    {/if}
{/function}

{function name="formWidgetString" form=null row=null part=null}
    {if !$form && isset($block_form)}
        {$form = $block_form}
    {/if}

    {if is_string($row) && $form}
        {$row = $form->getRow($row)}
    {/if}

    {$widget = $row->getWidget()}
    {if $widget}
        {$attributes = $widget->getAttributes()}
        {if isset($attributes.class)}
            {$attributes.class = "`$attributes.class` form-control"}
        {else}
            {$attributes.class = 'form-control'}
        {/if}

        {$value = $widget->getValue($part)}
        {if is_array($value)}
            {foreach $value as $part => $val}
            <input type="text"
                   name="{$widget->getName()}{if $widget->isMultiple() || $part !== null}[{$part}]{/if}"
                   value="{$val|escape}"
               {foreach $attributes as $name => $attribute}
                   {$name}="{$attribute|escape}"
               {/foreach}
             />
             {/foreach}
        {else}
            <input type="text"
                   name="{$widget->getName()}{if $widget->isMultiple() || $part !== null}[{$part}]{/if}"
                   value="{$value|escape}"
               {foreach $attributes as $name => $attribute}
                   {$name}="{$attribute|escape}"
               {/foreach}
             />
        {/if}
    {/if}
{/function}

{function name="formWidgetNumber" form=null row=null part=null}
    {if !$form && isset($block_form)}
        {$form = $block_form}
    {/if}

    {if is_string($row) && $form}
        {$row = $form->getRow($row)}
    {/if}

    {$widget = $row->getWidget()}
    {if $widget}
        {$attributes = $widget->getAttributes()}
        {if isset($attributes.class)}
            {$attributes.class = "`$attributes.class` form-control"}
        {else}
            {$attributes.class = 'form-control'}
        {/if}

        <input type="number"
               name="{$widget->getName()}{if $part}[{$part}]{/if}"
               value="{$widget->getValue($part)|escape}"
           {foreach $attributes as $name => $attribute}
               {$name}="{$attribute|escape}"
           {/foreach}
         />
    {/if}
{/function}

{function name="formWidgetEmail" form=null row=null part=null}
    {if !$form && isset($block_form)}
        {$form = $block_form}
    {/if}

    {if is_string($row) && $form}
        {$row = $form->getRow($row)}
    {/if}

    {$widget = $row->getWidget()}
    {if $widget}
        {$attributes = $widget->getAttributes()}
        {if isset($attributes.class)}
            {$attributes.class = "`$attributes.class` form-control"}
        {else}
            {$attributes.class = 'form-control'}
        {/if}

        <input type="email"
               name="{$widget->getName()}{if $part}[{$part}]{/if}"
               value="{$widget->getValue($part)|escape}"
           {foreach $attributes as $name => $attribute}
               {$name}="{$attribute|escape}"
           {/foreach}
         />
    {/if}
{/function}

{function name="formWidgetDate" form=null row=null part=null}
    {if !$form && isset($block_form)}
        {$form = $block_form}
    {/if}

    {if is_string($row) && $form}
        {$row = $form->getRow($row)}
    {/if}

    {$widget = $row->getWidget()}
    {if $widget}
        {$attributes = $widget->getAttributes()}
        {if isset($attributes.class)}
            {$attributes.class = "`$attributes.class` form-control"}
        {else}
            {$attributes.class = 'form-control'}
        {/if}

        <input type="date"
               name="{$widget->getName()}{if $part}[{$part}]{/if}"
               value="{$widget->getValue($part)|escape}"
           {foreach $attributes as $name => $attribute}
               {$name}="{$attribute|escape}"
           {/foreach}
         />
    {/if}
{/function}

{function name="formWidgetWebsite" form=null row=null part=null}
    {if !$form && isset($block_form)}
        {$form = $block_form}
    {/if}

    {if is_string($row) && $form}
        {$row = $form->getRow($row)}
    {/if}

    {$widget = $row->getWidget()}
    {if $widget}
        {$attributes = $widget->getAttributes()}
        {if isset($attributes.class)}
            {$attributes.class = "`$attributes.class` form-control"}
        {else}
            {$attributes.class = 'form-control'}
        {/if}

        <input type="website"
               name="{$widget->getName()}{if $part}[{$part}]{/if}"
               value="{$widget->getValue($part)|escape}"
           {foreach $attributes as $name => $attribute}
               {$name}="{$attribute|escape}"
           {/foreach}
         />
    {/if}
{/function}

{function name="formWidgetPassword" form=null row=null part=null}
    {if !$form && isset($block_form)}
        {$form = $block_form}
    {/if}

    {if is_string($row) && $form}
        {$row = $form->getRow($row)}
    {/if}

    {$widget = $row->getWidget()}
    {if $widget}
        {$attributes = $widget->getAttributes()}
        {if isset($attributes.class)}
            {$attributes.class = "`$attributes.class` form-control"}
        {else}
            {$attributes.class = 'form-control'}
        {/if}

        <input type="password"
               name="{$widget->getName()}{if $part}[{$part}]{/if}"
           {foreach $attributes as $name => $attribute}
               {$name}="{$attribute|escape}"
           {/foreach}
         />
    {/if}
{/function}

{function name="formWidgetText" form=null row=null part=null}
    {if !$form && isset($block_form)}
        {$form = $block_form}
    {/if}

    {if is_string($row) && $form}
        {$row = $form->getRow($row)}
    {/if}

    {$widget = $row->getWidget()}
    {if $widget}
        {$attributes = $widget->getAttributes()}
        {if isset($attributes.class)}
            {$attributes.class = "`$attributes.class` form-control"}
        {else}
            {$attributes.class = 'form-control'}
        {/if}

        <textarea name="{$widget->getName()}{if $part}[{$part}]{/if}"
           {foreach $attributes as $name => $attribute}
               {$name}="{$attribute|escape}"
           {/foreach}
         >{$widget->getValue($part)|escape}</textarea>
    {/if}
{/function}

{function name="formWidgetWysiwyg" form=null row=null part=null}
    {if !$form && isset($block_form)}
        {$form = $block_form}
    {/if}

    {if is_string($row) && $form}
        {$row = $form->getRow($row)}
    {/if}

    {$widget = $row->getWidget()}
    {if $widget}
        {$attributes = $widget->getAttributes()}
        {if isset($attributes.class)}
            {$attributes.class = "`$attributes.class` form-control"}
        {else}
            {$attributes.class = 'form-control'}
        {/if}

        <textarea name="{$widget->getName()}{if $part}[{$part}]{/if}"
           {foreach $attributes as $name => $attribute}
               {$name}="{$attribute|escape}"
           {/foreach}
         >{$widget->getValue($part)|escape}</textarea>
    {/if}
{/function}

{function name="formWidgetOption" form=null row=null part=null}
    {if !$form && isset($block_form)}
        {$form = $block_form}
    {/if}

    {if is_string($row) && $form}
        {$row = $form->getRow($row)}
    {/if}

    {$widget = $row->getWidget()}
    {if $widget}
        {if $widget->isMultiple()}
            {$type = "checkbox"}
        {else}
            {$type = "radio"}
        {/if}

        {$attributes = $widget->getAttributes()}
        {$value = $widget->getValue()}
        {$options = $widget->getOptions()}
        {if $part !== null}
            {if isset($options.$part)}
            <input type="{$type}"
                   name="{$widget->getName()}{if $type == 'checkbox'}[{$part}]{/if}"
                   value="{$part}"
                   {if (!is_array($value) && strcmp($value, $part) == 0) || (is_array($value) && isset($value[$part]))}checked="checked"{/if}
                   {foreach $attributes as $name => $attribute}
                       {if $name == 'id'}
                            {$attribute = "`$attribute`-`$part`"}
                       {/if}
                       {$name}="{$attribute|escape}"
                   {/foreach}
             />
             {/if}
        {else}
            {if is_array($options)}
                {foreach $options as $option => $label}
                    <div class="{$type}">
                        <label>
                            <input type="{$type}"
                                   name="{$widget->getName()}{if $part}[{$part}]{elseif $type == 'checkbox'}[]{/if}"
                                   value="{$option}"
                                   {if (!is_array($value) && strcmp($value, $option) == 0) || (is_array($value) && isset($value[$option]))}checked="checked"{/if}
                                   {foreach $attributes as $name => $attribute}
                                       {if $name == 'id'}
                                            {$attribute = "`$attribute`-`$option`"}
                                       {/if}
                                       {$name}="{$attribute|escape}"
                                   {/foreach}
                             />
                            {$label}
                        </label>
                    </div>
                {/foreach}
            {else}
                <div class="checkbox">
                    <label{if isset($attributes.disabled)} class="text-muted"{/if}>
                        <input type="checkbox" name="{$widget->getName()}" value="1"{if $value} checked="checked"{/if}
                            {foreach $attributes as $name => $attribute}
                                {$name}="{$attribute|escape}"
                            {/foreach}
                        />
                        {$row->getDescription()}
                    </label>
                </div>
            {/if}
        {/if}
    {/if}
{/function}

{function name="formWidgetSelect" form=null row=null part=null}
    {if !$form && isset($block_form)}
        {$form = $block_form}
    {/if}

    {if is_string($row) && $form}
        {$row = $form->getRow($row)}
    {/if}

    {$widget = $row->getWidget()}
    {if $widget}
        {$attributes = $widget->getAttributes()}
        {if isset($attributes.class)}
            {$attributes.class = "`$attributes.class` form-control"}
        {else}
            {$attributes.class = 'form-control'}
        {/if}

        {$value = $widget->getValue()}

        <select name="{$widget->getName()}{if $part}[{$part}]{elseif $widget->isMultiple()}[]{/if}"
           {if $widget->isMultiple()} multiple="multiple"{/if}
           {foreach $attributes as $name => $attribute}
               {$name}="{$attribute|escape}"
           {/foreach}
         >
         {foreach $widget->getOptions() as $option => $label}
            {if is_array($label)}
            <optgroup label="{$option|escape}">
            {foreach $label as $o => $l}
                <option value="{$o|escape}"{if (!is_array($value) && strcmp($o, $value) == 0) || (is_array($value) && isset($value[$o]))} selected="selected"{/if}>{$l}</option>
            {/foreach}
            </optgroup>
            {else}
            <option value="{$option|escape}"{if (!is_array($value) && strcmp($option, $value) == 0) || (is_array($value) && isset($value[$option]))} selected="selected"{/if}>{$label}</option>
            {/if}
         {/foreach}
         </select>
    {/if}
{/function}

{function name="formWidgetFile" form=null row=null part=null}
    {if !$form && isset($block_form)}
        {$form = $block_form}
    {/if}

    {if is_string($row) && $form}
        {$row = $form->getRow($row)}
    {/if}

    {$widget = $row->getWidget()}
    {if $widget}
        {$attributes = $widget->getAttributes()}
        {$value = $widget->getValue($part)}

        {if $value}
        <input type="hidden"
               name="{$widget->getName()}{if $part !== null}[{$part}]{/if}"
               value="{$value}" />
        {/if}
        <input type="file"
               name="{$widget->getName()}{if $part !== null}[{$part}]{/if}"
           {foreach $attributes as $name => $attribute}
               {$name}="{$attribute|escape}"
           {/foreach}
         />

        {if $value}
        <div class="help-block">{$value}</div>
        {/if}
    {/if}
{/function}

{function name="formWidgetImage" form=null row=null part=null}
    {if !$form && isset($block_form)}
        {$form = $block_form}
    {/if}

    {if is_string($row) && $form}
        {$row = $form->getRow($row)}
    {/if}

    {$widget = $row->getWidget()}
    {if $widget}
        {$attributes = $widget->getAttributes()}
        {$value = $widget->getValue($part)}

        {if $value}
        <input type="hidden"
               name="{$widget->getName()}{if $part !== null}[{$part}]{/if}"
               value="{$value}" />
        {/if}
        <input type="file"
               name="{$widget->getName()}{if $part !== null}[{$part}]{/if}"
           {foreach $attributes as $name => $attribute}
               {$name}="{$attribute|escape}"
           {/foreach}
         />

        {if $value}
        <div class="help-block">
            {image src=$value thumbnail="crop" width=100 height=100 title=$value}
        </div>
        {/if}
    {/if}
{/function}


{*
    Renders a component control of the form
*}
{function name="formWidgetComponent" form=null row=null class=null}
    {if !$form && isset($block_form)}
        {$form = $block_form}
    {/if}

    {if is_string($row) && $form}
        {$row = $form->getRow($row)}
    {/if}

    {if $row}
        {if $row->getType() == 'component'}
            {call formRows form=$form rows=$row->getRows() rowClass=$class}
        {else}
            <span class="error">No component row provided</span>
        {/if}
    {else}
        <span class="error">No row provided</span>
    {/if}
{/function}

{*
    Renders a collection control of the form
*}
{function name="formWidgetCollection" form=null row=null}
    {if !$form && isset($block_form)}
        {$form = $block_form}
    {/if}

    <div class="collection-control-group">
        {$widget = $row->getWidget()}
        {if $widget}
            {$values = $widget->getValue()}
            {foreach $values as $key => $value}
                {call formCollectionPrototype form=$form row=$row part=$key}
            {/foreach}
        {else}
            {$rows = $row->getRows()}
            {foreach $rows as $key => $r}
                {if $key !== '%prototype%'}
                    {call formCollectionPrototype form=$form row=$row part=$key}
                {/if}
            {/foreach}
        {/if}
    </div>

    <a href="#" class="btn btn-default prototype-add{if $row->isDisabled() || $row->isReadOnly()} disabled{/if}"><i class="glyphicon glyphicon-plus"></i> {translate key="button.add"}</a>
{/function}

{*
    Renders a single collection control of the form
*}
{function name="formCollectionPrototype" form=null row=null part=null}
    {if is_string($row) && $form}
        {$row = $form->getRow($row)}
    {/if}

    <div class="collection-control clearfix">
        <div class="col-md-10">
        {$widget = $row->getWidget()}
        {if $widget}
            {call formWidget form=$form row=$row part=$part type=$widget->getType()}
        {else}
            {call formRow form=$form row=$row->getRow($part)}
        {/if}
        </div>
        <div class="col-md-2">
            <a href="#" class="btn btn-default prototype-remove{if $row->isDisabled() || $row->isReadOnly()} disabled{/if}"><i class="glyphicon glyphicon-minus"></i> {translate key="button.remove"}</a>
        </div>
        <hr />
    </div>
{/function}

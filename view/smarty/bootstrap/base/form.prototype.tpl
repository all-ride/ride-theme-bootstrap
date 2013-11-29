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
{function name="formRow" form=null row=null}
    {if !$form && isset($block_form)}
        {$form = $block_form}
    {/if}

    {if is_string($row) && $form}
        {$row = $form->getRow($row)}
    {/if}

    {if $row}
        {$type = $row->getType()}
        {if $type == 'hidden'}
            {call formWidget form=$form row=$row}
            
            {$errors = $form->getValidationErrors($row->getName())}
            {if $errors}
            <div class="form-group has-error">
                {call formWidgetErrors form=$form row=$row}
            </div>
            {/if}
        {elseif $type == 'component'}
            {call formComponent form=$form row=$row}
        {elseif $type == 'collection'}
            <div class="form-group row-{$row->getName()|replace:'[':''|replace:']':''}{if $row->isDisabled()} disabled{/if}{if $row->isReadOnly()} readonly{/if} clearfix{if false} has-error{/if}">
                <label class="col-md-2 control-label">{$row->getLabel()}</label>

                {call formCollectionPrototype assign="prototype" form=$form row=$row part='%prototype%'}
                <div class="col-md-10" data-prototype="{$prototype|escape:"html"|trim|replace:"\n":''}">
                    {call formCollectionWidget form=$form row=$row}

                    {$description = $row->getDescription()}
                    {if $description}
                    <span class="help-block">{$description}</span>
                    {/if}
                </div>
            </div>
        {else}
            {$widget = $row->getWidget()}
            {$errors = $form->getValidationErrors($widget->getName())}

            <div class="form-group row-{$row->getName()|replace:'[':''|replace:']':''}{if $row->isDisabled()} disabled{/if}{if $row->isReadOnly()} readonly{/if} clearfix{if $errors} has-error{/if}">
                <label class="col-md-2 control-label" for="{$widget->getId()}">{$row->getLabel()}</label>
                <div class="col-md-10">
                    {call formWidget form=$form row=$row}

                    {if $errors}
                        <ul class="text-danger">
                        {foreach $errors as $error => $null}
                            <li>{$error}</li>
                        {/foreach}
                        </ul>
                    {/if}

                    {if $type == 'date'}
                        <span class="help-block">{translate key="label.date.description" example=time()|date_format:$row->getFormat() format=$row->getFormat()}</span>
                    {/if}

                    {$description = $row->getDescription()}
                    {if $description && $type != 'checkbox' && ($type != 'option' || ($type == 'option' && !empty($row->getWidget()->getOptions())))}
                        <span class="help-block">{$description}</span>
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
{function name="formWidgetErrors" form=null row=null}
    {if !$form && isset($block_form)}
        {$form = $block_form}
    {/if}

    {if is_string($row) && $form}
        {$row = $form->getRow($row)}
    {/if}

    {if $row}
        {$widget = $row->getWidget()}

        {if $widget}
            {$errors = $form->getValidationErrors($widget->getName())}

            {if $errors}
                <ul class="errors help-block">
                {foreach $errors as $error => $null}
                    <li>{$error}</li>
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
{function name="formWidget" form=null row=null part=null}
    {if !$form && isset($block_form)}
        {$form = $block_form}
    {/if}

    {if is_string($row) && $form}
        {$row = $form->getRow($row)}
    {/if}

    {if $row}
        {$type = $row->getType()|ucfirst}
        {$function = "formWidget`$type`"}
        {call $function form=$form row=$row part=$part}
        
        {$row->setIsRendered(true)}
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
               value="{$widget->getValue()|escape}"
           {foreach $widget->getAttributes() as $name => $value}
               {$name}="{$value|escape}"
           {/foreach} 
         />
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
        
        <input type="text" 
               name="{$widget->getName()}{if $part}[{$part}]{/if}" 
               value="{$widget->getValue()|escape}"
           {foreach $attributes as $name => $value}
               {$name}="{$value|escape}"
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
               value="{$widget->getValue()|escape}"
           {foreach $attributes as $name => $value}
               {$name}="{$value|escape}"
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
           {foreach $attributes as $name => $value}
               {$name}="{$value|escape}"
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
           {foreach $attributes as $name => $value}
               {$name}="{$value|escape}"
           {/foreach} 
         >{$widget->getValue()|escape}</textarea>
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
        {if $widget->isMultiSelect()}
            {$type = "checkbox"}
        {else}
            {$type = "radio"}
        {/if}
        
        {$value = $widget->getValue()}
        {$options = $widget->getOptions()}
        {if $options}
            {foreach $options as $option => $label}
    
                <div class="{$type}">
                    <label>
                        <input type="{$type}" name="{$widget->getName()}{if $part}[{$part}]{elseif $type == 'checkbox'}[]{/if}" value="{$option}"{if (!is_array($value) && strcmp($value, $option)) == 0 || (is_array($value) && isset($value[$option]))} checked="checked"{/if} />
                        {$label}
                    </label>
                </div>
            {/foreach}
        {else}
            <div class="checkbox">
                <label>
                    <input type="checkbox" name="{$widget->getName()}" value="1"{if $value} checked="checked"{/if} />
                    {$row->getDescription()}
                </label>
            </div>
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
            
        <select name="{$widget->getName()}{if $part}[{$part}]{elseif $widget->isMultiSelect()}[]{/if}"
           {if $widget->isMultiSelect()} multiple="multiple"{/if} 
           {foreach $attributes as $name => $value}
               {$name}="{$value|escape}"
           {/foreach} 
         >
         {$value = $widget->getValue()}
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
        
        <input type="file" 
               name="{$widget->getName()}{if $part}[{$part}]{/if}" 
           {foreach $attributes as $name => $value}
               {$name}="{$value|escape}"
           {/foreach} 
         />

         {if $widget->getValue()}
         <div class="help-block">
            {image src=$widget->getValue() thumbnail="crop" width=100 height=100 title=$widget->getValue()}
        </div>
         {/if}
    {/if}
{/function}

{*
    Renders a component control of the form
*}
{function name="formComponent" form=null row=null class=null}
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
    @param zibo\library\html\form\build\BuilderForm $form
    @param zibo\library\html\form\build\FormRow $row
    @param string $field Name of the field
*}
{function name="formCollectionWidget" form=null row=null}
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

    <a href="#" class="btn prototype-add{if $row->isDisabled() || $row->isReadOnly()} disabled{/if}"><i class="icon icon-plus"></i></a>
{/function}

{*
    Renders a single collection control of the form
*}
{function name="formCollectionPrototype" form=null row=null part=null}
    <div class="collection-control">
        {$widget = $row->getField()}
        {if $widget}
            {call formWidget form=$form row=$row part=$part}
        {else}
            {call formRow form=$form row=$row->getRow($part)}
        {/if}
        <a href="#" class="btn prototype-remove{if $row->isDisabled() || $row->isReadOnly()} disabled{/if}"><i class="icon icon-minus"></i></a>
    </div>
{/function}
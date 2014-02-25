{extends file="manual/index"}

{block name="manual_content" append}
    {foreach $references as $type => $reference}
        <h2>{$type}</h2>
        <dl>
        {foreach $reference as $key => $description}
            <dt>{$key}</dt>
            <dd>{$description}</dd>
        {/foreach}
        </dl>
    {/foreach}
{/block}
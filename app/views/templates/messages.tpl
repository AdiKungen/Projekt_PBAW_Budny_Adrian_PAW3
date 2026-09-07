{if $msgs->isMessage()}
    {$n = $msgs->getSize()}
    </br>
    <div class="{if $msgs->isError()}bg-danger{/if} {if $msgs->isInfo()}bg-success{/if} messenger">
        {foreach $msgs->getMessages() as $i => $msg}
            {strip}
                {$msg->text}
                {if ($i+1) != $n}
                    {" | "}
                {/if}
            {/strip}
        {/foreach}
    </div>
{/if}
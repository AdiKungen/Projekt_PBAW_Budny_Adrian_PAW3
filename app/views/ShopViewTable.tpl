{foreach $records as $r}
    {strip}
        <div class="papapa">
            <div class="div12" style="margin-right: 10px;"><img src="{$conf->app_root}/{$r['cover']}" alt="Okładka {$r['title']}"></div>
            <div class="div22" style="font-size: 30px; display: flex; align-items: flex-end;"><p>{$r['title']}</p></div>
            <div class="div32">{$r['artist']}</div>
            <div class="div42">{$r['name']}</div>
            <div class="div52" style="text-align: center">{$r['whenpublished']}</div>
            <div class="div62" style="text-align: center">{$r['price']} zł/godz </div>
            <div class="div72" style="text-align: center">{if isset($conf->roles["user"])}<a role="button" href="{$conf->action_url}addToOrder/{$r['idsong']}">Do koszyka</a>{/if}</div>
        </div>
    {/strip}
{/foreach}

    <div style="text-align: center;">
        {for $i=1 to $liczbastron}
            <a href='{$conf->action_url}shopShow/{$i}'>{$i}</a>
        {/for}
    </div>
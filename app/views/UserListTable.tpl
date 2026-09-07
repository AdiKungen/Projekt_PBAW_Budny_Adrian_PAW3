<table style="width: 100%">
        <thead>
            <tr>
                <th>ID</th>
                <th>Nazwa użytkownika</th>
                <th>Role</th>
                <th>Opcje</th>
            </tr>
        </thead>
    <tbody>

    {if !empty($users)}
        {foreach $users as $i => $u}
            {strip}
                    <tr>
                        <td style="width: 10%">{$u["iduser"]}</td>
                        <td style="width: 30%">{$u["login"]}</td>
                        <td style="width: 30%">
                            {foreach $pusers as $p}
                                {strip}
                                {if $u['iduser'] == $p['iduser']}
                                    {$p["name"]}
                                {/if}
                                {/strip}
                            {/foreach}
                        </td>
                        <td style="width: 20%; text-align: center;"><a class="btn btn-action btn-xs" role="button" href="{$conf->action_url}userEdit/{$u['iduser']}">Edytuj</a> <a class="btn btn-action btn-xs" role="button" onclick="confirmLink('{$conf->action_url}userDelete/{$u['iduser']}','Czy na pewno usunąć rekord ?')">Usuń</a></td>
                    </tr>
            {/strip}
        {/foreach}
    {/if}
</tbody>
</table>
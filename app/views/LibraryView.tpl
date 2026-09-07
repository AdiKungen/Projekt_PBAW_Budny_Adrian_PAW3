{extends file="main.tpl"}

{block name=content}

<header id="head" class="secondary"></header>

<!-- container -->
<div class="container">

    <ol class="breadcrumb">
        <li><a href="{$conf->action_root}homeShow">Strona Główna</a></li>
        <li class="active">Twoja Biblioteka</li>
    </ol>

    <header class="page-header">
        <h1 class="page-title">Twoja Biblioteka</h1>
    </header>

    {if !empty($records)}
        {foreach $records as $r}
            {strip}
                <div class="parent">
                    <div class="div1" style="margin-right: 10px;"><img src="{$conf->app_root}/{$r['cover']}" alt="Okładka {$r['title']}"></div>
                    <div class="div2" style="font-size: 30px; display: flex; align-items: flex-end;"><p>{$r['title']}</p></div>
                    <div class="div3">{$r['artist']}</div>
                    
                    <div class="div6" style="text-align: center">{$r['name']}</div>
                    <div class="div7" style="text-align: center">Kończy się: </br>{date("H:i:s d.m.Y", strtotime($r['whenends']))}</div>
                    <div class="div4">
                    <audio controls style="width: 100%; height: 40px;" controlsList="nodownload" preload="auto">
                        <source src="{$r['file']}" type="audio/mpeg">
                    </audio>
                    </div>
                </div>
            {/strip}
        {/foreach}
    {/if}

</div>	<!-- /container -->
{literal}
    <script type="text/javascript">
        document.addEventListener('contextmenu', 
                event => event.preventDefault()
        );
        document.addEventListener("keydown", function (event){
            if (event.ctrlKey){
                event.preventDefault();
            }
            if(event.keyCode == 123){
                event.preventDefault();
            }
        });
    </script>
{/literal}
{/block}
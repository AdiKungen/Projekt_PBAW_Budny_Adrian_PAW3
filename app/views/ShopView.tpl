{extends file = "main.tpl"}

{block name=content}
<header id="head" class="secondary"></header>

<!-- container -->
<div class="container">

    <ol class="breadcrumb">
        <li><a href="{$conf->action_root}homeShow">Strona Główna</a></li>
        <li class="active">Sklep</li>
    </ol>

    <div class="row">
        
        <!-- Article main content -->
        <div class="col-md-8 maincontent">
            <header class="page-header">
                <h1 class="page-title">Wypożyczalnia muzyki</h1>
            </header>

            <div id="user-table">
            {include file = "ShopViewTable.tpl"}
            </div>
        </div>

        <!-- /Article -->
        
        <!-- Sidebar -->
        <div class="col-md-4 maincontent">
            <header class="page-header">
                <h1 class="page-title">Filtruj</h1>
            </header>
            <form id="search-form" onsubmit="ajaxPostForm('search-form','{$conf->action_root}shopShowTable/1','user-table'); return false;">
                <label for="genre">Wybierz gatunek:</label>
                <select id="genre" name="genre" value="{$searchForm->genre}">
                    <option value="">Wszystkie</option>
                    {foreach $genres as $g}
                    {strip}
                        <option value="{$g["name"]}">{$g["name"]}</option>
                    {/strip}
                    {/foreach}
                </select>
		        <button type="submit">Filtruj</button> 
            </form>
            <header class="page-header">
                <h1 class="page-title">Koszyk</h1>
            </header>
            {if !empty($cart)}
            <ol>
                {foreach $cart as $c}
                {strip}
                    <li>{$c['artist']} - {$c['title']} ({$c['price']} zł/h) <a href="{$conf->action_url}deleteCart/{$c['idsong']}"><i class="fa fa-times fa-2"></i></a></li>
                {/strip}
                {/foreach}
            </ol>
                <div style="text-align: center;">
                    <form id="order" action="{$conf->action_root}orderCart" method="post">
						<label for="howlong">Na ile godzin chciałbyś wypożyczyć? </label>
						<input id="howlong" type="number" name="howlong" min="1" max="48" onchange="calcCart()">
                        <div id="zaplata">
                        </div>
                        <input id="cost" type="number" value="{$cost}" style="display: none"> </input>
						<input type="submit" value="Zamów"/>
					</form>
                </div>
            {/if}
            {include file = "messages.tpl"}
            
        </div>
        <!-- /Sidebar -->

    </div>
</div>	<!-- /container -->
{literal}
    <script type="text/javascript">
      function calcCart() {
        var howlong = document.getElementById("howlong");
        var cost = document.getElementById("cost");
        if (howlong.value >= 1 && howlong.value <= 48) {
            zaplata.style.display = "block";

            zaplata.innerHTML = "Do zapłaty: " + howlong.value * cost.value + " zł";
        } else {
            zaplata.style.display = "none";
        }
      }
    </script>
{/literal}
{/block}
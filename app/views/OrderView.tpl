{extends file = "main.tpl"}

{block name=content}
<header id="head" class="secondary"></header>

	<!-- container -->
	<div class="container">
		
		<ol class="breadcrumb">
			<li><a href="{$conf->action_root}homeShow">Strona Główna</a></li>
			<li class="active">Zamówienia</li>
		</ol>

		<div class="row">
			
			<!-- Sidebar -->
			<div class="col-md-4 maincontent">
				<header class="page-header">
					<h1 class="page-title">Zamówienia</h1>
				</header>
				{if !empty($orders)}
					<ol>
					{foreach $orders as $o}
					{strip}
						<li><a href="{$conf->action_url}detailOrder/{$o['idrental']}">Zamównienie #{$o['idrental']}</a>
					{/strip}
					{/foreach}
					</ol>
				{/if}
			</div>
			<!-- /Sidebar -->

			<!-- Article main content -->
			<div class="col-md-8 maincontent">
				<header class="page-header">
					<h1 class="page-title">Potwierdzenie {if !empty($details)}zamówienia #{$details[0]["rental_idrental"]}{/if}</h1>
				</header>

				{if !empty($details)}
					{foreach $details as $r}
						{strip}
							<div class="papapa">
								<div class="div12" style="margin-right: 10px;"><img src="{$conf->app_root}/{$r['cover']}" alt="Okładka {$r['title']}"></div>
								<div class="div22" style="font-size: 30px; display: flex; align-items: flex-end;"><p>{$r['title']}</p></div>
								<div class="div32">{$r['artist']}</div>
								<div class="div42">{$r['name']}</div>
								<div class="div52" style="text-align: center">{$r['whenpublished']}</div>
								<div class="div62" style="text-align: center">{$r['price']} zł/godz </div>
							</div>
						{/strip}
					{/foreach}
				{/if}
					
				{include file = "messages.tpl"}

				{if !empty($details)}
					<div style="text-align: center">
						<p>Zamówienie użytkownika: {$details[0]["login"]}</p>
						<p>Wypożyczenie na: {$details[0]["howlong"]}h</p>
						<p>Koszt zamówienia: {$details[0]["cost"]} zł </p>
						<form action="{$conf->action_url}acceptOrder/{$details[0]["rental_idrental"]}" method="post" onsubmit="return isChckd()">
							<label for="chckbx">Czy użytkownik uiścił zapłatę za zamówienie?</label>
							<input id="chckbx" type="checkbox" name="chckbx">
							<input type="submit" value="Potwierdź"/>
						</form>
						<div id="msgs" class="bg-danger messenger" style="display: none"></div>
					</div>
				{/if}		
			</div>
			<!-- /Article -->
		</div>
	</div>	<!-- /container -->
	{literal}
		<script type="text/javascript">
		  function isChckd() {
			if ( document.getElementById("chckbx").checked == true) {
				return true;
			} else {
				document.getElementById("msgs").style.display = "block";
				document.getElementById("msgs").innerHTML = "Użytkownik nie uiścił zapłaty za zamówienie";
			  	return false;
			}
		  }
		</script>
	{/literal}
{/block}
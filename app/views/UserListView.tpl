{extends file="main.tpl"}

{block name=content}

<header id="head" class="secondary"></header>

<!-- container -->
<div class="container">

    <ol class="breadcrumb">
        <li><a href="{$conf->action_root}homeShow">Strona Główna</a></li>
        <li class="active">Panel Administratora</li>
    </ol>

    <header class="page-header">
        <h1 class="page-title">Panel Administratora</h1>
    </header>

    <h4>Filtruj po nazwie użytkownika</h4>
    <form id="search-form" onsubmit="ajaxPostForm('search-form','{$conf->action_root}userListTable','user-table'); return false;">
		    <input type="text" placeholder="Nazwa użytkownika" name="login" value="{$searchForm->login}" /><br />
		    <button type="submit">Filtruj</button> 
    </form>

    {include file="messages.tpl"}
    </br>

<div id="user-table">
{include file="UserListTable.tpl"}
</div>

<a href="{$conf->action_root}userNew">+ Nowa osoba</a>

</div>	<!-- /container -->

{/block}
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

    <form action="{$conf->action_root}userSave" method="post">

        <h4>Dane osoby</h4>
        <label for="login">Nazwa użytkownika</label>
        <input id="login" type="text" placeholder="Nazwa użytkownika" name="login" value="{$form->login}">

        <br/>

        <div id="pswd">
        <label for="password">Hasło</label>
        <input id="password" type="password" placeholder="Hasło" name="password">

        <br/>

        <label for="apassword">Ponowne hasło</label>
        <input id="apassword" type="password" placeholder="Ponowne hasło" name="apassword">
        </div>

        {if !empty($form->iduser)}
        <label for="chckbxpswd">Zaznacz, jeśli chcesz zachować poprzednie hasło</label>
        <input id="chckbxpswd" type="checkbox" onclick='isChckd()' name="chckbxpswd">
        {/if}
        <h4>Role</h4>
        <label for="chckbxuser">User</label>
        <input id="chckbxuser" type="checkbox" name="chckbxuser" {if $form->chckbxuser == "user"}checked{/if}>
        
        <br/>

        <label for="chckbxworker">Worker</label>
        <input id="chckbxworker" type="checkbox" name="chckbxworker" {if $form->chckbxworker == "worker"}checked{/if}>

        <br/>

        <label for="chckbxadmin">Admin</label>
        <input id="chckbxadmin" type="checkbox" name="chckbxadmin" {if $form->chckbxadmin == "admin"}checked{/if}>

        <br/>

		<input type="submit" value="Zapisz"/>
		<a href="{$conf->action_root}userList">Powrót</a>

    <input type="hidden" name="iduser" value="{$form->iduser}">
</form>	

{include file="messages.tpl"}

</div>	<!-- /container -->
{literal}
    <script type="text/javascript">
      function isChckd() {
        if (document.getElementById("chckbxpswd").checked == true) {
            document.getElementById("pswd").style.display = "none";
        } else {
            document.getElementById("pswd").style.display = "block";
        }
      }
    </script>
{/literal}
{/block}
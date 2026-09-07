{extends file="main.tpl"}

{block name=content}
<header id="head" class="secondary"></header>

	<!-- container -->
	<div class="container">

		<ol class="breadcrumb">
			<li><a href="{$conf->action_root}homeShow">Strona Główna</a></li>
			<li class="active">Rejestracja</li>
		</ol>

		<div class="row">
			
			<!-- Article main content -->
			<article class="col-xs-12 maincontent">
				<header class="page-header">
					<h1 class="page-title">Zarejestruj się</h1>
				</header>
				
				<div class="col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">
					<div class="panel panel-default">
						<div class="panel-body">
							<h3 class="thin text-center">Zarejestruj swoje konto</h3>
							<p class="text-center text-muted">Wprowadź nazwę użytkownika oraz hasło dwa razy, aby zarejestrować swoje konto</a></p>
							<hr>
							
							<form action="{$conf->action_root}signup" method="post">
								<div class="top-margin">
									<label>Nazwa użytkownika<span class="text-danger">*</span></label>
									<input type="text" name="login" class="form-control" value="{$form->login}">
								</div>
								<div class="top-margin">
									<label>Hasło<span class="text-danger">*</span></label>
									<input type="password" name="pass1" class="form-control">
								</div>
								<div class="top-margin">
									<label>Powtórz hasło<span class="text-danger">*</span></label>
									<input type="password" name="pass2" class="form-control">
								</div>

								{include file = "messages.tpl"}

								<hr>

								<div class="row">
									<div class="col-lg-8">
										<b><a href="{$conf->action_root}loginShow">Logowanie</a></b>
									</div>
									<div class="col-lg-4 text-right">
										<button class="btn btn-action" type="submit">Zarejestruj</button>
									</div>
								</div>
							</form>
						</div>
					</div>

				</div>
				
			</article>
			<!-- /Article -->

		</div>
	</div>	<!-- /container -->
{/block}
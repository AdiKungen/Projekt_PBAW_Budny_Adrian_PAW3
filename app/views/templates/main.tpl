<!DOCTYPE html>
<html lang="pl">
<head>
	<meta charset="utf-8">
	<meta name="viewport"    content="width=device-width, initial-scale=1.0">
	<meta name="description" content="Projekt PBAW: Wypożyczalnia Muzyki">
	<meta name="author"      content="Adrian Budny">
	
	<title>MUSICKER - Wypożyczalnia muzyki</title>

	<link rel="shortcut icon" href="{$conf->app_root}/assets/images/gt_favicon.png">
	
	<link rel="stylesheet" media="screen" href="http://fonts.googleapis.com/css?family=Open+Sans:300,400,700">
	<link rel="stylesheet" href="{$conf->app_root}/assets/css/bootstrap.min.css">
	<link rel="stylesheet" href="{$conf->app_root}/assets/css/font-awesome.min.css">

	<!-- Custom styles for our template -->
	<link rel="stylesheet" href="{$conf->app_root}/assets/css/bootstrap-theme.css" media="screen" >
	<link rel="stylesheet" href="{$conf->app_root}/assets/css/main.css">

	<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
	<!--[if lt IE 9]>
	<script src="assets/js/html5shiv.js"></script>
	<script src="assets/js/respond.min.js"></script>
	<![endif]-->
</head>
<body class="home">
	<!-- Fixed navbar -->
	<div class="navbar navbar-inverse navbar-fixed-top headroom" >
		<div class="container">
			<div class="navbar-header">
				<!-- Button for smallest screens -->
				<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse"><span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span> </button>
				<a class="navbar-brand" href="{$conf->action_root}homeShow"><img src="{$conf->app_root}/assets/images/gt_favicon.png" alt="Logo" style="height: 30px; display: inline-block; vertical-align: middle; margin-right: 8px;">MUSICKER</a>
			</div>
			<div class="navbar-collapse collapse">
				<ul class="nav navbar-nav pull-right">
					
                    {if isset($conf->roles["user"]) || count($conf->roles) == 0}
                        <li><a href="{$conf->action_root}homeShow">Strona Główna</a></li>
                        <li><a href="{$conf->action_root}libraryShow">Twoja Biblioteka</a></li>
                    {/if}

					<li><a href="{$conf->action_root}shopShow/1">Sklep</a></li>

                    {if isset($conf->roles["worker"])}
                        <li><a href="{$conf->action_root}orderShow" {if $isOrder == true}class="blinker" {/if}>Zamówienia</a></li>
                    {/if}

                    {if isset($conf->roles["admin"])}
                        <li><a href="{$conf->action_root}userList">Panel administratora</a></li>
                    {/if}

                    {if count($conf->roles)>0}
                        <li><a class="btn" href="{$conf->action_root}logout" class="pure-menu-heading pure-menu-link">WYLOGUJ SIĘ | {$nazwa|default:''}</a>
                    {else}	
                        <li> <a class="btn" href="{$conf->action_root}loginShow" class="pure-menu-heading pure-menu-link">ZALOGUJ | ZAREJESTRUJ SIĘ</a>
                    {/if}</li>
				</ul>
			</div><!--/.nav-collapse -->
		</div>
	</div> 
<div class="cialo">
{block name=content} Domyślna treść zawartości .... {/block}

    <!-- Social links. @TODO: replace by link/instructions in template -->
<section id="social">
    <div class="container">
        <div class="wrapper clearfix">
            <!-- AddThis Button BEGIN -->
            <div class="addthis_toolbox addthis_default_style">
            <a class="addthis_button_facebook_like" fb:like:layout="button_count"></a>
            <a class="addthis_button_tweet"></a>
            <a class="addthis_button_linkedin_counter"></a>
            <a class="addthis_button_google_plusone" g:plusone:size="medium"></a>
            </div>
            <!-- AddThis Button END -->
        </div>
    </div>
</section>
<!-- /social links -->


<footer id="footer" class="top-space">

    <div class="footer1">
        <div class="container">
            <div class="row">
                
                <div class="col-md-3 widget">
                    <h3 class="widget-title">Kontakt</h3>
                    <div class="widget-body">
                        <p>+123 456 789<br>
                            <a href="mailto:#">musicker.rental@gmail.com</a><br>
                            <br>
                            ul. Będzińska 39, 41-200 Sosnowiec
                        </p>	
                    </div>
                </div>

                <div class="col-md-3 widget">
                    <h3 class="widget-title">Śledź nas</h3>
                    <div class="widget-body">
                        <p class="follow-me-icons">
                            <a href="https://www.facebook.com/" target="_blank"><i class="fa fa-facebook fa-2"></i></a>
                            <a href="https://instagram.com/" target="_blank"><i class="fa fa-instagram fa-2"></i></a>
                            <a href="https://twitter.com/" target="_blank"><i class="fa fa-twitter fa-2"></i></a>
                        </p>	
                    </div>
                </div>

                <div class="col-md-6 widget">
                    <h3 class="widget-title">Pomoc</h3>
                    <div class="widget-body">
                        <p>Jeśli wystąpiłyby jakieś problemy, błędy, bądź miałbyś jakieś pytanie proszę kontaktować się z nami drogą mailową lub w sprawach pilnych sugerujemy kontakt telefoniczny w godzinach 8-16</p>
                        <p>Dziękujemy za korzystanie z naszych usług i postaramy się odpowiedzieć najszybciej jak jest to możliwe</p>
                    </div>
                </div>

            </div> <!-- /row of widgets -->
        </div>
    </div>

    <div class="footer2">
        <div class="container">
            <div class="row">
                
                <div class="col-md-6 widget">
                    <div class="widget-body">
                        <p class="simplenav">
                            {if isset($conf->roles["user"]) || count($conf->roles) == 0}
                                <a href="{$conf->action_root}homeShow">Strona Główna</a>
                                <a> | </a>
                                <a href="{$conf->action_root}libraryShow">Twoja Biblioteka</a>
                                <a> | </a>
                            {/if}
        
                            <a href="{$conf->action_root}shopShow/1">Sklep</a>
        
                            {if isset($conf->roles["worker"])}
                                <a> | </a>
                                <a href="{$conf->action_root}orderShow">Zamówienia</a>
                            {/if}
        
                            {if isset($conf->roles["admin"])}
                                <a> | </a>
                                <a href="{$conf->action_root}userList">Panel administratora</a>
                            {/if}

                            <a> | </a>

                            {if count($conf->roles)>0}
                                <a href="{$conf->action_root}logout">Wyloguj się ({$nazwa|default:''})</a>
                            {else}	
                                <a href="{$conf->action_root}loginShow" >Zaloguj się</a>
                                <a> | </a>
                                <a href="{$conf->action_root}signupShow" >Zarejestruj się</a>
                            {/if}
                        </p>
                    </div>
                </div>

                <div class="col-md-6 widget">
                    <div class="widget-body">
                        <p class="text-right">
                            Copyright &copy; 2026 Adrian Budny. Based on a modified template by <a href="https://gettemplate.com" target="_blank" rel="noopener noreferrer">Sergey Pozhilov (GetTemplate)</a>
                        </p>
                    </div>
                </div>

            </div> <!-- /row of widgets -->
        </div>
    </div>
</footer>
</div>
    
<!-- JavaScript libs are placed at the end of the document so the pages load faster -->
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
<script src="{$conf->app_root}/assets/js/headroom.min.js"></script>
<script src="{$conf->app_root}/assets/js/jQuery.headroom.min.js"></script>
<script src="{$conf->app_root}/assets/js/template.js"></script>
<script type="text/javascript" src="{$conf->app_url}/assets/js/functions.js"></script>
</body>
</html>
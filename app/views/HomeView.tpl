{extends file="main.tpl"}

{block name=content}
	<!-- Header -->
	<header id="head">
		<div class="container">
			<div class="row">			
				<h1 class="lead">Witaj na stronie MUSICKER</h1>
				<p class="tagline">Wypożyczalni muzyki dla każdego</p>
				<p><a href="#intro" v-mdb-smooth="#intro" class="btn btn-default btn-lg" role="button">WIĘCEJ INFO</a> <a href="{$conf->action_root}shopShow/1" class="btn btn-action btn-lg" role="button">PRZEGLĄDAJ TERAZ</a></p>
			</div>
		</div>
	</header>
	<!-- /Header -->

	<!-- Intro -->
	<div id="intro" class="container text-center">
		<br> <br>
		<h2 class="thin">Jesteśmy wypożyczalnią z największym asortymentem na rynku</h2>
		<p class="text-muted">
			Posiadamy piosenki z większości gatunków muzycznych w bajecznie niskich cenach. <br>
			Możesz filtrować nasz sklep, aby odnaleźć wyłącznie interesujące cię pozycje <br>
			Wypożycz wiele piosenek naraz i ciesz się kolekcją swoich ulubionych piosenek
		</p>
	</div>
	<!-- /Intro-->
		
	<!-- Highlights - jumbotron -->
	<div class="jumbotron top-space">
		<div class="container">
			
			<h3 class="text-center thin">Powody, aby skorzystać z naszych usług</h3>
			
			<div class="row">
				<div class="col-md-3 col-sm-6 highlight">
					<div class="h-caption"><h4><i class="fa fa-cogs fa-5"></i>Najnowsze technologie</h4></div>
					<div class="h-body text-center">
						<p>Najnowsze technologie wykorzystane na naszej stronie zapewnają niezawodność oraz najwyższą jakość audio</p>
					</div>
				</div>
				<div class="col-md-3 col-sm-6 highlight">
					<div class="h-caption"><h4><i class="fa fa-flash fa-5"></i>Najszybsze usługi</h4></div>
					<div class="h-body text-center">
						<p>Twoje zamówienie zostanie błyskawicznie złożone i będziesz w stanie słuchać swojej ulubionej muzyki już po minucie</p>
					</div>
				</div>
				<div class="col-md-3 col-sm-6 highlight">
					<div class="h-caption"><h4><i class="fa fa-heart fa-5"></i>Najlepsza obsługa</h4></div>
					<div class="h-body text-center">
						<p>Nasi pracownicy dołożą wszelkich starań, aby twoje zamówienie zostało skompletowane bez żadnego problemu</p>
					</div>
				</div>
				<div class="col-md-3 col-sm-6 highlight">
					<div class="h-caption"><h4><i class="fa fa-smile-o fa-5"></i>Gwarancja zadowolenia</h4></div>
					<div class="h-body text-center">
						<p>Jesteśmy pewni, że będziesz zadowolony z naszych usług i wrócisz do nas złożyć kolejne zamówienia z uśmiechem</p>
					</div>
				</div>
			</div> <!-- /row  -->
		
		</div>
	</div>
	<!-- /Highlights -->

	<!-- container -->
	<div class="container">

		<h2 class="text-center top-space">Najczęściej zadawane pytania</h2>
		<br>

		<div class="row">
			<div class="col-sm-6">
				<h3>Co się stanie z piosenkami, kiedy skończy się czas wypożyczenia?</h3>
				<p>Piosenki, które wypożyczyłeś, a zakończył się ich czas wypożyczenia zostaną automatycznie usunięte z twojego konta i dostępne do ponownego wypożyczenia</p>
			</div>
			<div class="col-sm-6">
				<h3>Kiedy piosenki pojawią się w mojej bibliotece?</h3>
				<p>Piosenki pojawią się w twojej bibliotece zaraz po tym jak potwierdzimy wpływ opłaty za zamówienie</p>
			</div>
		</div> <!-- /row -->

		<div class="row">
			<div class="col-sm-6">
				<h3>Na jaki czas mogę wypożyczyć piosenkę?</h3>
				<p>Wypożyczenia piosenek rozpoczynają się od 1 godziny, aż do 48 godzin dla jednego zamówienia</p>
			</div>
			<div class="col-sm-6">
				<h3>Czy wypożyczoną piosenkę mogę udostępniać dalej?</h3>
				<p>Nie, piosenka wypożyczona jest dostępna tylko i wyłącznie do użytku własnego i nie można jej kapitalizować pod zakazem licencyjnym</p>
			</div>
		</div> <!-- /row -->

</div>	<!-- /container -->
{/block}
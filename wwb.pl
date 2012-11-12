#!/usr/bin/perl -w
# wwb.pl
use Irssi;

use vars qw($VERSION %IRSSI);
$VERSION = "0.0.1";
%IRSSI = (
    authors     => "Erkka Hiano, Petri A-vikainen",
    contact     => "lens",
    name        => "We Were Bored",
    description => "Allows you to be the meme king",
    url         => "github?",
    changed     => ""
);

use strict;
use Irssi::Irc;

my @clapclap = (
    "http://assets0.ordienetworks.com/images/GifGuide/clapping/citizen_cane.gif",
    "http://www.reactiongifs.com/wp-content/gallery/yes/2yllfzo.gif",
    "http://i56.tinypic.com/2j63d6g.jpg",
    ""
);
my @fry = ();
my @boobs = ();

sub wwb_main {
    #data - parameters for hello
    #server - active server window
    #witem - window item (channel, query etc...)
    my ($data, $server, $witem) = @_;
    my $url;
    Irssi::print($witem->{name}); 
    if (!$server || !$server->{connected}) {
        Irssi::print("Too lazy to connect a server?");
        return;
    } 
    if (!$data) {
        Irssi::print("No memetype given see /wwb list for awailable memetypes");
	return;
    } else {
        $url = get_random_url_by_memetype($data);
        $server->command("MSG $witem->{name} $url");
    }
}

sub get_random_url_by_memetype {
    my ($type) = @_;
    if ($type eq "applause") {
        my $random_int = int(rand($#clapclap));
        Irssi::print($random_int);
        return @clapclap[$random_int];    
    }
    return;
}

Irssi::command_bind('wwb', 'wwb_main');

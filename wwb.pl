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

my @clapclap = ();
my @fry = ();
my @boobs = ();

sub wwb_main {
    #data - parameters for hello
    #server - active server window
    #witem - window item (channel, query etc...)
    my ($data, $server, $witem) = @_;
    Irssi::print($witem->{name}); 
    if (!$server || !$server->{connected}) {
        Irssi::print("Too lazy to connect a server?");
        return;
    } 
    if (!$data) {
        Irssi::print("No memetype given see /wwb list for awailable memetypes");
	return;
    } else {
        $server->command("MSG $witem->{name} $data");
    }
}

Irssi::command_bind('wwb', 'wwb_main');

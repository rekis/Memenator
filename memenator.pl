#!/usr/bin/perl -w
# Memenator.pl
# Posts a url defined by memetype to active window
# usage: /memenator <memetype>
# Licence: Public Domain
use Irssi;

use vars qw($VERSION %IRSSI);
$VERSION = "0.0.1";
%IRSSI = (
    authors     => "Erkka Hiano, Petri A-vikainen",
    contact     => "lens",
    name        => "Memenator",
    description => "Allows you to be the meme king",
    url         => "https://github.com/silppuri/Memenator",
    changed     => ""
);

use strict;
use Irssi::Irc;

my %memes = (
  applause => [(
      "http://assets0.ordienetworks.com/images/GifGuide/clapping/citizen_cane.gif",
      "http://www.reactiongifs.com/wp-content/gallery/yes/2yllfzo.gif",
      "http://i56.tinypic.com/2j63d6g.jpg",
      "")],
  boobs => [()],
  fry   => [()]
);
my $memetypes;
foreach my $key (sort(keys %memes)) {
  $memetypes = join "$memetypes " , "", "$key";
}
sub memenator_main {
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
    }
    if ($data eq "list" || !exists $memes{$data}) {
      Irssi::print("Usage /memenator <memetype>");
      Irssi::print("Memetypes: ".$memetypes);
    } else {
        $url = get_random_url_by_memetype($data);
        $server->command("MSG $witem->{name} $url");
    }
}

sub get_random_url_by_memetype {
    my ($type) = @_;
    my @meme_array = @{$memes{$type}}; #get the array of urls defined by key type
    my $random_int = int(rand(scalar @meme_array));
    return @meme_array[$random_int];
}

Irssi::command_bind('memenator', 'memenator_main');

#!/usr/bin/perl

# Here we go again...GPLv2 will do C 2017 Doug Coulter
# as usual, if I thought it dodgy, I used @@@ in a nearby comment

use Modern::Perl '2014'; # we only have 5.18 on this machine?
use File::Basename 'dirname'; # for knowing where we are (ease for developer) already here
use Gtk3 -init; # for our GUI
use Glib  qw(TRUE FALSE); # for periodic events etc
#use Gtk3::Helper; # allows us to add "watch" callbacks to (file/socket) handles?

# gobject issue is fixed in later distros
#http://askubuntu.com/questions/319568/i-cant-configure-rhythmbox-as-gobject-introspection-1-is-not-installed for when you can't install gtk3 or glib
#

#use Storable qw(nstore retrieve); # for (re) storing hash of hashes preset
#use DBI; # for mySQL interface
####################################################################
# GUI variable references to objects
my $GUIFilename = '/minimal.glade'; # @@@ use your real Glade filename here
# I use a file during development, then switch to including it after __END__
# and use createguilocal9) in initialize() 
# the example boilerplate uses the local all in this file

my $builder = Gtk3::Builder->new(); # gtkbuilder object, creates a gui from glade's xml
my $mainwin; # will be set up in the creation routine
# put references to any other new created gui objects here for organization

=pod
Usually I will put my GUI-related variables here, as pairs - one a reference to the widget,
one the value for that widget if it has one to retrieve or change.  So things look like this:

my $($widgetnamer,$widgetname); # reference to the thing for manipulation, and value

You can reuse the same name for the widget you used in Glade for ID if you like to keep your mind
free for other stuff.  This is an entirely different namespace.
Yes, this makes them all globals...the whole GUI is anyway.

=cut

####################################################################
# @@@ this has a hardcoded glade filename in a variable - you need to fix that as required
# @@@ above

sub createguifile # create the gui from xml in a .glade file 
{ # use this for developer convienience.  Final product should put glade xml
  # after the __END__ tag and use createguilocal instead
 $builder->add_from_file(dirname($0) . $GUIFilename); # @@@ set that variable right, dumb ass
 $mainwin = $builder->get_object('mainwin'); #@@@ assumes main window is called mainwin
 $builder->connect_signals(undef);
 $mainwin->set_screen( $mainwin->get_screen() ); #??? from an example.  Seems redundant?
 $mainwin->signal_connect(destroy => sub {Gtk3->main_quit});
 $mainwin->show_all();
# not so program-specific you couldn't use it again
}
####################################################################
# switch to using this once the gui is more or less settled - the file is easier to change
# but this is easier to ship.
sub createguilocal # create the gui from xml in a .glade file 
{ # put glade xml after the __END__ tag and use createguilocal
 my $guidata; # packed the xml internally, goes here
 local $/; # which makes this undefined for this sub
 $guidata = <main::DATA>; # which makes this slurp the entire "file"
 $builder = Gtk3::Builder->new_from_string($guidata,length($guidata));
 $mainwin = $builder->get_object('mainwin'); #@@@ assumes main window is called mainwin
 $builder->connect_signals(undef);
 $mainwin->set_screen( $mainwin->get_screen() ); #??? from an example.  Seems redundant?
 $mainwin->signal_connect(destroy => sub {Gtk3->main_quit});
 $mainwin->show_all();
}
####################################################################
 sub getGUIrefs
 { # get all the references to the GUI widgets you need here, called in initialize
   # example:  $widgetnamer = builder->get_object('widgetname'); # or ID?, I make them the same anyway
 }
####################################################################
 sub var2GUI
 { # at least for simpler things, this is where you'd stuff all the 
   # gui elements with the contents of the variables that go with them.

 }
####################################################################
 sub GUI2var
 { # grab the content of any interesting widgets and put into variables here

 }
####################################################################


####################################################################

sub initialize 
{ # put all your init code here
#	createguifile(); # use a separate file during development
	createguilocal(); # but use this one when shipping.  XML after the __END__ tag
    getGUIrefs(); # get references to the widgets for later messing around
    # setup any variables here for the call below
    var2GUI(); # you may want to put in some content you didn't do in Glade?
}
####################################################################


####################################################################
############################ Main ##################################
####################################################################

initialize();
say "Compiled OK."; # way to say we made it.
 Gtk3->main; # GUI event forever loop - when we quit, we fall out and exit

# when your gui is settled, copy the xml from the glade file to below the end tag and use createguilocal
#instead.  Harder to change, easier to ship.
# in this example, the "minimal.glade"" file is included here
# the example calls createguilocal() so it will run right away
 __END__
<?xml version="1.0" encoding="UTF-8"?>
<!-- Generated with glade 3.22.1 -->
<interface>
  <requires lib="gtk+" version="3.20"/>
  <object class="GtkApplicationWindow" id="mainwin">
    <property name="name">mainwin</property>
    <property name="can_focus">False</property>
    <property name="tooltip_text" translatable="yes">This is the main window for the minimal demo</property>
    <property name="title" translatable="yes">Just a main window for demo</property>
    <child>
      <placeholder/>
    </child>
    <child>
      <placeholder/>
    </child>
  </object>
</interface>

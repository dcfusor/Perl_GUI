# Perl_GUI
Things to make writing GUIs in perl super easy

It's no secret I like to work in perl when the situation allows.  As it turns out, most GUIs are pretty insensitive
to speed, and programmer time for things like little utilities (I'll be ading another repo for some soon) is important.
So perl (5.x) is good for these.
Sadly, there are a few poorly documented tricks to getting that toolchain rolling - the GTK3 library doesn't just go in
without any muss of fuss - and you get error messages that use somewhat different naming conventions than are used in
the debian repos for those dependencies.  It took a little fooling around to figure that out, so I wrote a script
for that (I play with raspberry pies and other machines, and configure new images a lot).  Here it's in the 
InstallDependencies folder - grab that, make it executable if it isn't, and run it.  
Apt is smart enough to not put things in twice if you already have some of these.

Congrats, you can now use the Glade programm to design/generate a GUI you can instantiate in perl.  
You'll have to install Glade the usual way.

Even that isn't easy enough.  So I provide some templates for the Linux "create new" document dialoge.  
Those go into /home/youruser/Templates.  You can now create a boilerplate perl GUI that should work 
as soon as you make it runnable, and edit to your heart's content.

I used lots of comments - there is a choice of having the glade file internal to your perl script or external.  
The example puts the minimal one right inside the script for easy demo.  But when really doing this, it's
usually better to have it as a separate file, so Glade can work with it until you're ready to ship.  For that mode
you use createguitfile() instead of createguilocal() in the initialize() function.  Simples.

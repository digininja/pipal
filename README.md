# Pipal, Password Analyser

Copyright(c) 2022, Robin Wood <robin@digi.ninja>

On most internal pen-tests I do, I generally manage to get a password dump from
the DC. To do some basic analysis on this I wrote Counter and since I originally
released it I've made quite a few mods to it to generate extra stats that are
useful when doing reports to management.

Recently a good friend, n00bz, asked on Twitter if anyone had a tool that he
could use to analyse some passwords he had. I pointed him to Counter and said if
he had any suggestions for additions to let me know. He did just that and over
the last month between us we have come up with a load of new features which we
both think will help anyone with a large dump of cracked passwords to analyse.
We also got some input from well known password analysts
[Matt Weir](http://reusablesec.blogspot.com/) and Martin Bos who I'd like to give
a big thanks to.

I have to point out before going on, all this tool does is to give you the stats
and the information to help you analyse the passwords. The real work is done by
you in interpreting the results, I give you the numbers, you tell the story.

Seeing as there have been so many changes to the underlying code I also decided
to change the name (see below) and do a full new release.

So, what does this new version do? The best way to describe it is to see some
examples so go to the [Pipal project page](http://digi.ninja/projects/pipal.php)
for a full walk through of a sample analysis.

## Install / Usage

The app will only work with `Ruby 1.9.x` and newer, if you try to run it in any previous
versions you will get a warning and the app will close.

Pipal is completely self contained and requires no gems installing so should
work on any vanilla Ruby install.

Usage is fairly simple, `-?` will give you full instructions:

```ruby
$ ./pipal.rb -?
pipal 2.0 Robin Wood (robin@digi.ninja) (http://digi.ninja)

Usage: pipal [OPTION] ... FILENAME
        --help, -h: show help
        --top, -t X: show the top X results (default 10)
        --output, -o : output to file
        --external, -e : external file to compare words against
		--gkey <Google Maps API key>: to allow zip code lookups (optional)

        FILENAME: The file to count
```

When you run the app you'll get a nice progress bar which gives you a rough idea
of how long the app will take to run. If you want to stop it at any point
hitting Ctrl-c will stop the parsing and will dump out the stats generated so
far.

The progress bar is based on a line count from the file which it gets this using
the wc command. If it can't find wc it will make a guess at the number of lines
based on the file size and an average line length of 8 bytes so the progress bar
may not be fully accurate but should still give you an idea.

[The Google Maps API](https://developers.google.com/maps/) key is supposed to be
used by Google to only allow access to their API to registered users.
I assumed this was true and registered for a key
but in putting together this release I found that it will take any value and
still do the look up. This may be a bug at the Google end or deliberate and may
change any any time so I'd suggest grabbing a key just in case. To use it you
can either edit the script and put the key into the constant on line 35 or you
can pass it on the command line every time. If you are going to hope that you
don't need a valid key then just put X in as the value as without something
Pipal won't try to perform a look up.

## Enabling Checkers

Checkers are the scripts that do the actual work, to understand how these work, see the [README_modular.md](README_modular.md) file.

## Version History

Version 2 - Two big changes, the first a massive speed increase. This patch was
submitted by Stefan Venken who said a small mention would be good enough, I want
to give him a big mention. Running through the LinkedIn lists would have taken
many many hours on version 1, version 2 went through 3.5 million records in
about 15 minutes. Thank you.

Second change is the addition of US area and zip code lookups. This little
feature gives some interesting geographical data when ran across password lists
originating in the US. The best example I've seen of this is the dump from the
Military Singles site where some passwords could be obviously seen to be grouped
around US military bases. People in the UK don't have the same relationship with
phone numbers so I know this won't work here but if anyone can suggest any other
areas where this might be useful then I'll look at building in some kind of
location awareness feature so you can specify the source of the list and get
results customized to the correct area or just run every area and see if a
pattern emerges.

A non-code-base change is for version 2 is the move from hosting the code myself
to github. This is my first github hosted project so I may get things wrong, if
I do, sorry. A number of people asked how they could submit patches so this
seems like the best way to do it, lets hope it works out.

Version 1 - Was a proof of concept, written fairly in a fairly verbose way so not
very optimised. Took off way more than I expected it would and gathered a lot of
community support.

## Feedback/Todo

If you have a read through the source for Pipal you'll notice that it isn't very
efficient at the moment. The way I built it was to try to keep each chunk of
stats together as a distinct group so that if I wanted to add a new, similar,
group then it was easy to just copy and paste the group. Now I've got a working
app and I know roughly what I need in the different group types I've got an idea
on how to rewrite the main parser to make it much more efficient and hopefully
multi-threaded which should speed up the processing by a lot for large lists.

I could have made these changes before releasing version 1.0 but I figured
before I do I want to get as much feedback as possible from users about the
features already implemented and about any new features they would like to see
so that I can bundle all these together into version 2. So, please get in touch
if there is a set of stats that you'd like to see included.

One other thing I know needs fixing, Pipal doesn't handle certain character
encodings very well. If anyone knows how to correctly deal with different
encoding types, especially with regards to regular expressions, please let me
know.

## Licence

This project released under the
[Creative Commons Attribution-Share Alike 2.0 UK: England & Wales](http://creativecommons.org/licenses/by-sa/2.0/uk/)

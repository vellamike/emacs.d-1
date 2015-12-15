lentic enables /lenticular text/: simultaneous editing and viewing of the
same (or closely related) text in two or more buffers, potentially in
different modes. Lenticular text is named after lenticular printing, which
produce images which change depending on the angle at which they are
viewed.

Sometimes, it would be nice to edit a file in two ways at once. For
instance, you might have a source file in a computational language with
richly marked documentation. As Emacs is a modal editor, it would be nice
to edit this file both in a mode for the computational language and for the
marked up documentation.

One solution to this is to use a single-mode which supports both types of
editing. The problem with this is that it is fundamentally difficult to
support two types of editing at the same time; more over, you need a new
mode for each environment. Another solution is to use one of the
multiple-mode tools which are available. The problem with this is that they
generally need some suppor from the modes in question. And, again, the
dificulty is supporting both fo ms of editing in the same environment. A
final problem is that it is not just the editing environment that needs to;
the programmatic environment needs to be untroubled by the documentation,
and the documentation untroubled by the programmatic mode.

Lenticular text provides an alternative solution. Two lentic buffers, by
default, the two share content but are otherwise independent. Therefore,
you can have two buffers open, each showing the content in different modes;
to switch modes, you simply switch buffers. The content, location of point,
and view are shared.

Moreover, lentic buffers can also perform a bi-directional transformation
between the two. If this is done, then the two can have different but
related text. This also solves the problem of integration with a
tool-chain; each lentic buffer can be associated with a different file and
a different syntax.  This file is, itself, lenticular text. It can be
viewed either as Emacs-Lisp or in Org-Mode. In Emacs-Lisp mode, this text
is commented out, in org-mode it is not. In fact, even the default
behaviour of lentic uses this transformation capability--the text is
shared, but text properties are not, a behaviour which differs between
lentic buffers and indirect buffers.

It is possible to configure the transformation for any two buffers in a
extensible way, although mostly we have concentrated on mode-specific
configuration.

The main user entry point is through `global-lentic-start-mode' which
provides tools to create a new lentic buffer.

Configuration:

lentic buffers are configurable in a large number of ways. It is possible
to control the nature of the transformation, the default buffer name that a
lentic buffer takes, and the file location (or not) of the lentic buffer.
For this release of lentic currently, each buffer can only be linked to a
single buffer, although this restriction will be removed in later versions.

Configuration of a buffer happens in one of two places. First,
`lentic-init' is run when a lentic buffer is first created. This
function should set the actual configuration `lentic-config', and is
mostly designed for use as a file-local or dir-local variable. All subsequent
configuration happens through `lentic-config' which is an EIEIO object
and associated methods.

There are now a number of different configurations, which can be used for
general-purposes use as well as an extension points for subclass
configurations. The two most general configurations are:

 - default: this copies all text exactly, but does not transfer
   text-properties (which is the behaviour of indirect buffers). It is
   possible to configure the default file or mode on a per-object basis.
 - block: this is designed for programmatic syntaxes where blocks of code are
   demarcated by start and end tags, and everything else is commented by
   line-start comments. Comments are added or removed between the two buffers.

The second of these is extended in lentic-org.el to provide the
configuration for this file: there is a normal emacs-lisp file in one buffer
and an org-mode version in another. Other programmatic and documentation modes
are supported in other files.

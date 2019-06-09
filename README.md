# Genprint

*Genprint* is a small hack of the compiler allowing general printing of values
exactly as is seen from the interactive toplevel. The difference is that a value can be printed
out from anywhere in the program rather than only for the end result.


``` ocaml
open Genprint
(* prs requires both arguments. *)
let _=
    prs "random value" [[[0,1]]];
    prs "random value" (true,"true")
```
```
random value =>
[[[(0, 1)]]]
random value =>
(true, "true")
- : unit = ()
```

It relies on capturing the type of the value at the point of use in the program and as such
it is not useful to bury such statements within polymorhic functions:

``` ocaml
let printnl x = 
    Genprint.prs "polymorphic and not very useful" x;
    print_endline()
    
let _= f 0
```
```
polymorphic and not very useful =>
<poly>
- : unit = ()
```

So use only where the type is partially or completely inferred.


For some control, as Toplevel, there is:

``` ocaml
val max_printer_depth : int ref
val max_printer_steps : int ref
val ppf : Format.formatter ref
```

The printing function is basic and reflects the fact this is only meant as a debug aid.
It is available in the toplevel and the compiler.
There is an opam switch available:

```
opam repository add --set-default progman1 https://github.com/progman1/my-opam-repo.git

opam switch create 4.07.1+genprint
```

See the [Makefile](Makefile) above for example targets.

Patches are also available separately:
one for the common component [here](translprim.patch),
one specifically [for the toplevel](genprinttop.patch) and one specifically [for the compiler](genprint0.patch).

From the root of your ocaml distribution:
```
patch -p1 < <path of patch file>
```

./configure ... to your requirements then:

```
make coldstart depend
make world world.opt install
```

The patches are against ocaml version 4.07.1 but easily adjusted for other versions.


The switch contains both toplevel and compiler patches but this is only for demo'ing - the compiler
patch (in addition to the common patch) is sufficient for toplevel operation as well.
The reason there is a separate toplevel patch is that it is trivial, making use of existing
toplevel infrastructure, and if one is content to develop via the toplevel only, that patch (on top of the common patch) is sufficient.

For example, since it is possible for project sub-component libraries to be loaded into a toplevel
either as object files/library or, when undertaking maintenance/development, as source,
one can switch between modes. And one benefit of going to source mode is then general value printing.
So strictly speaking, the compiler patch is unnecessary.
On the other hand, it may be harder to maintain ability to do toplevel work than I have thus far
experienced and so the compiler patch would allow the debug printing facility in re-compiled code as well.

# Feedback

Feedback welcome, just use the issue tracker.



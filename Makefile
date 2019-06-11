got:
	ocaml -noinit -I +compiler-libs go.ml

gob:
	ocamlc -o go genprint.cma go.ml && ./go

goo:
	ocamlopt -o go genprint.cmxa go.ml && ./go


gon:
	ocaml -noinit genprint.cma go.ml
	echo No - both patches are present and 

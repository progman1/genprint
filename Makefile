go1:
	ocaml -noinit go.ml

go2:
	ocamlc -o go genprint.cma go.ml && ./go

go3:
	ocamlop -o go genprint.cmxa go.ml && ./go


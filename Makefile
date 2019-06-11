got:
	ocaml -noinit -I +compiler-libs go.ml

gob:
	ocamlc -o go genprint.cma go.ml && ./go

goo:
	ocamlopt -o go genprint.cmxa go.ml && ./go


gon:
	ocaml -noinit genprint.cma go.ml || true
	@echo No\! - both patches are present. You are tring to use the interpreter with the \
	static library and a conflict results.

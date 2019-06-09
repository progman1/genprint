open Format

let pp fmt = Printf.kfprintf (fun ch-> Printf.fprintf ch "\n"; flush stdout) stdout fmt

let _=
  let m=pp_get_margin std_formatter() in
  pp "margin: %d" m;
  
  pp_print_flush std_formatter ();
  pp_set_margin std_formatter 100; (* default 78 causes  weirdness  *)
  ()


open Genprint

module type Mt= sig 
  type t
(* = private  A | B of t *)
  val v: t
end


module M (*: Mt*) =struct
  type t=  A | B of t
  let v=(B(B(B(B(B(B(B(B(B(A))))))))))

  type r={a:int;b:int}
end

module P : sig type t val p : t end =struct
  type t = int
  let p=99
end

let _=
  max_printer_depth:=30;
  max_printer_steps:=30;

  Format.(fprintf std_formatter  "---------------------------------\n");
  prs "deep" M.v;
  Format.(fprintf std_formatter  "\n---------------------------------\n")

type t={x:int;y:int}
type t2=T of {x:int;y:int}
type t3= A of int| B
type 'a t4 =
  | J : int -> int t4
  | K : bool -> bool t4

let _=
  prs "array" [| 1,2 |];
  prs "tuple" (1.1,2.2);
  prs "pvariant" `V;
  prs "pvariant with arg" (`V2 true);
  prs "lazy" (lazy (1+1));
  prs "lazy" (Lazy.force(lazy (1+1)));
  prs "string" "string";
  prs "bytes" (Bytes.of_string "string");
  prs "bytes" (Bytes.create 10);
  prs "record" {x=1;y=2};
  prs "simple constructor" [A 0;B];
  prs "polymorphic constrs" (J 1,K true);
  prs "constr/record" (T{x=11;y=22});
  prs "int64" (Int64.of_float 99.999);
  prs "int32" (Int32.of_float 99.999);
  prs "list" [1;2;3];
  prs "poly" (Obj.magic 0);
  prs "part poly" ('a',Obj.magic 0);
  max_printer_steps:=5;
  prs "ellipsis" [1;2;3;4;5;6;7;8;9;10];
  prs "1st posn full name" M.{a=1;b=2};
  prs "abstract" P.p;
  print_endline "done."

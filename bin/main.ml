open Minttea
open Spices
open Clock.Model

(*
https://github.com/leostera/minttea/blob/main/spices/spices.ml
https://ocaml.org/manual/5.2/api/Unix.html
https://ocaml.org/manual/5.2/api/Array.html
https://learnenglishkids.britishcouncil.org/sites/kids/files/attachment/flashcards-time.pdf
*)

(* Get current hour and minute *)
let gethm () = 
  let now = Unix.localtime (Unix.time ()) in
  let hour = now.tm_hour in
  let minute = now.tm_min in
  (hour, minute)

let bold_style = Spices.(default |> bold true)
(*
let hour = now.Unix.tm_hour
let minute = now.Unix.tm_min
*)

type t = {
  hours: bool array;
  mins: bool array;
  secs: bool array;
  past: bool;
}

type min_t =
    FIVE
  | TEN
  | QUARTER
  | TWENTY
  | HALF

let min_de = function
  | FIVE -> 0
  | TEN -> 1
  | QUARTER -> 2
  | TWENTY -> 3
  | HALF -> 4

type hour_t =
    OCLOCK
  | ONE
  | TWO
  | THREE
  | FOUR
  | FIVE
  | SIX
  | SEVEN
  | EIGHT
  | NINE
  | TEN
  | ELEVEN
  | TWELVE

let hour_de = function
  | OCLOCK -> 0
  | ONE -> 1
  | TWO -> 2
  | THREE -> 3
  | FOUR -> 4
  | FIVE -> 5
  | SIX -> 6
  | SEVEN -> 7
  | EIGHT -> 8
  | NINE -> 9
  | TEN -> 10
  | ELEVEN -> 11
  | TWELVE -> 12

(*
let foo (h, m) =
  let hh =
    if m > 30 then h+1
    else h in
  let mm 
  *)

let build_outstr model =
  let lit fmt = Spices.(default |> bold true |> build) fmt in
  let lines = [
    (lit "%s" "IT") ^ "L" ^ (lit "%s" "IS") ^ "ASAMPM";
    "AC" ^ 
      (if model.mins.(2) then (lit "%s" "QUARTER")
       else "QUARTER") ^ "DC";

    (if model.mins.(3) then (lit "%s" "TWENTY")
     else "TWENTY") ^
    (if model.mins.(0) then (lit "%s" "FIVE")
     else "FIVE");

    (if model.mins.(4) then (lit "%s" "HALF")
     else "HALF") ^ "S" ^
    (if model.mins.(1) then (lit "%s" "TEN")
     else "TEN") ^ "F" ^
    (if model.past then (lit "%s" "TO")
     else "TO");

    (if not model.past then (lit "%s" "PAST")
     else "PAST") ^ "ERU" ^
    (if model.hours.(9) then (lit "%s" "NINE")
     else "NINE");

    (if model.hours.(1) then (lit "%s" "ONE")
     else "ONE") ^
    (if model.hours.(6) then (lit "%s" "SIX")
     else "SIX") ^
    (if model.hours.(3) then (lit "%s" "THREE")
     else "THREE");

    (if model.hours.(4) then (lit "%s" "FOUR")
     else "FOUR") ^
    (if model.hours.(5) then (lit "%s" "FIVE")
     else "FIVE") ^
    (if model.hours.(2) then (lit "%s" "TWO")
     else "TWO");

    (if model.hours.(8) then (lit "%s" "EIGHT")
     else "EIGHT") ^
    (if model.hours.(11) then (lit "%s" "ELEVEN")
     else "ELEVEN");

    (if model.hours.(7) then (lit "%s" "SEVEN")
     else "SEVEN") ^
    (if model.hours.(12) then (lit "%s" "TWELVE")
     else "TWELVE");

    (if model.hours.(10) then (lit "%s" "TEN")
     else "TEN") ^ "SE" ^
    (if model.hours.(0) then (lit "%s" "OCLOCK")
     else "OCLOCK")] in
  String.concat "\n" lines


let fmt model =
  let hrs = model.hours in
  let min = model.mins in
  let sec = model.secs in
  let pst = model.past in
  format_of_string 
  [%string "" ]

(* https://github.com/janestreet/ppx_string *)
let fmt = format_of_string "
ITLISASAMPM
AC%sDC
%s%sX
%sS%sFTO
PASTERUNINE
%s%s%s
%s%s%s
%s%s
%s%s
%sSE%s
"

(*
mins.(QUARTER)
mins.(FIVE)
mins.(TWENTY)
mins.(HALF)

hours.(1)
hours.(6)
hours.(3)
hours.(4)
hours.(5)
hours.(2)
hours.(8)
hours.(11)
hours.(7)
hours.(12)
hours.(10)
hours.(0)
*)
(* Printf.sprintf fmt "world" 123;; *)

(*
let model_to_str m =
*)


let initial_model: t = {
  hours = Array.make 13 false;
  mins = Array.make 5 false;
  secs = Array.make 4 false;
  past = false
} 

let init _model = Command.Noop

let update event model =
  match event with
  (* Exit on pressing 'Q' *)
  | Event.KeyDown (Key "Q" | Escape) -> (model, Command.Quit)
  (*
  (* Claim victory *)
  | Event.KeyDown (Key "c") -> (model, Command.Quit)
  | Event.KeyDown (Key numstr) -> 
      (match int_of_string_opt numstr with
      (* Ignore other events *)
      | None -> (model, Command.Noop)
      | Some col ->
          if col > 0 && col <= 7 then
            (fill_spot model (col-1), Command.Noop)
          else 
            (model, Command.Noop))
  *)
  (* Ignore other events *)
  | _ -> (model, Command.Noop)


let a = "asdf"

let red fmt = Spices.(default |> fg (color "#992222") |> build) fmt
let bold fmt = Spices.(default |> bold true |> build) fmt
let bold' fmt = Spices.(default |> bold true)

let view model = 
    bold "%s" [%string "%{a}" ]



let app = Minttea.app ~init ~update ~view ()
let () = Minttea.start app ~initial_model

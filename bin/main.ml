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


(*
let foo (h, m) =
  let hh =
    if m > 30 then h+1
    else h in
  let m' =
    if m > 30 then 30-m
    else m in
*)

  (*
let fmt model =
  let hrs = model.hours in
  let min = model.mins in
  let sec = model.secs in
  let pst = model.past in
  format_of_string 
  [%string "" ]
  *)



  (*
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
*)


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

let initial_model = {
  hours = Array.of_list
    [false; false; true; false; false;
     false; false; false; false; false;
     false; false; false];
  mins = Array.of_list [false; false; true; false; false];
  leds = Array.of_list [true; true; true; false];
  past = true;
}


let initial_model' = {
  hours = Array.make 13 false;
  mins = Array.make 5 false;
  leds = Array.make 4 false;
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
    build_outstr model
    (* bold "%s" [%string "%{a}" ] *)



let app = Minttea.app ~init ~update ~view ()
let () = Minttea.start app ~initial_model
(*
let () = Minttea.start app ~initial_model
*)

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

let view model = 
    [%string "%{a}" ]



let app = Minttea.app ~init ~update ~view ()
let () = Minttea.start app ~initial_model

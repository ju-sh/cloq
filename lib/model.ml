
type t = {
  hours: bool array; (* size: 13 *)
  mins: bool array;  (* size: 5 *)
  leds: bool array;  (* size: 4 *)
  past: bool;
}

let time_to_model (h, m) =
  let pst = m > 30 in
  let h' = h mod 12 in
  let hidx_aux =
    if pst then [h'+1]
    else [h'] in
  let hidxs =
    if m = 0 then 0::hidx_aux
    else hidx_aux in
  let m' = 
    if pst then 30-(m mod 30)
    else m in
  let mrem = m' mod 5 in
  let mbig = m' - mrem in
  let mm = mbig/5 - 1 in
  let midxs =
    if mm < 4 then [mm]
    else if mm = 4 then [0; 3] (* 5 and 20 *)
    else [4] in
  let harr = Array.init 13 (Fun.flip List.mem hidxs) in
  let marr = Array.init 5 (Fun.flip List.mem midxs) in
  let larr = Array.append (Array.make mrem true) (Array.make (4-mrem) false) in
  (* let larr = Array.append (Array.make (mrem+1) true) (Array.make (4-(mrem+1)) true) in *)
  {
    hours = harr;
    mins = marr;
    leds = larr;
    past = pst;
  }

(*
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
  *)

let unlit str =
  let style fmt = Spices.(default |> fg (color "#808080") |> build) fmt in
  style "%s" str

let lit str =
  let style fmt = Spices.(default |> bold true |> build) fmt in
  style "%s" str

let build_outstr model =
  let lines = [
    (lit "IT") ^ (unlit "L") ^ (lit "IS") ^ (unlit "ASAMPM");
    (unlit "AC") ^ 
      (if model.mins.(2) then (lit "QUARTER")
       else (unlit "QUARTER")) ^ (unlit "DC");
    (if model.mins.(3) then (lit "TWENTY")
     else (unlit "TWENTY")) ^
    (if model.mins.(0) then (lit "FIVE")
     else (unlit "FIVE")) ^ (unlit "X");

    (if model.mins.(4) then (lit "HALF")
     else (unlit "HALF")) ^ (unlit "S") ^
    (if model.mins.(1) then (lit "TEN")
     else (unlit "TEN")) ^ (unlit "F") ^
    (if model.past then (lit "TO")
     else (unlit "TO"));

    (if not model.past then (lit "PAST")
     else (unlit "PAST")) ^ (unlit "ERU") ^
    (if model.hours.(9) then (lit "NINE")
     else (unlit "NINE"));

    (if model.hours.(1) then (lit "ONE")
     else (unlit "ONE")) ^
    (if model.hours.(6) then (lit "SIX")
     else (unlit "SIX")) ^
    (if model.hours.(3) then (lit "THREE")
     else (unlit "THREE"));

    (if model.hours.(4) then (lit "FOUR")
     else (unlit "FOUR")) ^
    (if model.hours.(5) then (lit "FIVE")
     else (unlit "FIVE")) ^
    (if model.hours.(2) then (lit "TWO")
     else (unlit "TWO"));

    (if model.hours.(8) then (lit "EIGHT")
     else (unlit "EIGHT")) ^
    (if model.hours.(11) then (lit "ELEVEN")
     else (unlit "ELEVEN"));

    (if model.hours.(7) then (lit "SEVEN")
     else (unlit "SEVEN")) ^
    (if model.hours.(12) then (lit "TWELVE")
     else (unlit "TWELVE"));

    (if model.hours.(10) then (lit "TEN")
     else (unlit "TEN")) ^ (unlit "SE") ^
    (if model.hours.(0) then (lit "OCLOCK")
     else (unlit "OCLOCK"));

    let body = Array.fold_right
      (fun b str -> (if b then "● " else "○ ") ^ str)
      model.leds "" in
    "  " ^ body ^ " "
  ] in
  String.concat "\n" lines
  (* ●● ○ *)


(*
 0: oclock
 1: one
 2: two
 3: three
 4: four
 5: five
 6: six
 7: seven
 8: eight
 9: nine
10: ten
11: eleven
12: twelve
---
0: five
1: ten
2: quarter
3: twenty
4: half
---
0: past
1: to
---
leds: n:Int
*)


(*
fun genoutstr =
    Spices.


{|
ITLISASAMPM
ACQUARTERDC
TWENTYFIVEX
HALFSTENFTO
PASTERUNINE
ONESIXTHREE
FOURFIVETWO
EIGHTELEVEN
SEVENTWELVE
TENSEOCLOCK
|}
    *)





(*
 0: oclock
 1: one
 2: two
 3: three
 4: four
 5: five
 6: six
 7: seven
 8: eight
 9: nine
10: ten
11: eleven
12: twelve
---
13: five
14: ten
15: quarter
16: half
17: twenty
---
18: past
19: to

-----

List of lights:

it is: always ON
quarter
twenty
five
half
ten
to
past
nine
one
six
three
four
five
two
eight
eleven
seven
twelve
ten
oclock

---

Unused letters are in upper case:

itLisASAMPM
ACquarterDC
twentyfiveX
halfStenFto
pastERUnine
onesixthree
fourfivetwo
eighteleven
seventwelve
tenSEoclock


---

Unused letters:


  L  ASAMPM
AC       DC
          X
    S   F  
    ERU    
           
           
           
           
   SE      
*)

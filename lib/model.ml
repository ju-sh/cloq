
type t = {
  hours: bool array;
  mins: bool array;
  secs: bool array;
  past: bool;
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

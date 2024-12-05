let file = "input.txt"

type orderingRule = { before : int; after : int } [@@deriving show]
type pageUpdates = int array [@@deriving show]
type combinations = (int * int) list [@@deriving show]

exception InvariantBroken

let split_list condition input =
  let rec split_list_inner condition extracted input =
    match input with
    | [] -> (extracted, input)
    | head :: tail when condition head -> (extracted, tail)
    | head :: tail -> split_list_inner condition (head :: extracted) tail
  in
  split_list_inner condition [] input

let parse_ordering_rule line =
  let before, after =
    Scanf.sscanf line "%d|%d" (fun before after -> (before, after))
  in
  { before; after }

let parse_page_updates line =
  let updates = String.split_on_char ',' line in
  List.map (fun x -> Scanf.sscanf x "%d" (fun page -> page)) updates

let combinations values =
  let rec combinations values_so_far values =
    match values with
    | [] -> values_so_far
    | head :: tail ->
        combinations
          (List.fold_left (fun acc x -> (head, x) :: acc) values_so_far tail)
          tail
  in
  combinations [] values

let validate_update rules update =
  let update_pairs = combinations update in
  let check_passes_rule rule update_pair =
    (snd update_pair == rule.before && fst update_pair == rule.after) |> not
  in
  let check_all_rules update_pair =
    List.for_all (fun x -> check_passes_rule x update_pair) rules
  in
  List.for_all check_all_rules update_pairs

let sorter (rules : orderingRule list) left right =
  let matchedRules =
    List.filter
      (fun x ->
        (x.before == left && x.after == right)
        || (x.before == right && x.after == left))
      rules
  in
  match matchedRules with
  | [] -> 0
  | head :: _ when head.before == left -> -1
  | head :: _ when head.before == right -> 1
  | _ -> raise InvariantBroken

let fix_invalid rules update =
  let _ = Array.sort (sorter rules) update in
  update

let rules, updates =
  let lines = Core.In_channel.read_lines file in
  let raw_rules, raw_updates =
    split_list (fun x -> String.length x == 0) lines
  in
  let rules = List.map parse_ordering_rule raw_rules in
  let updates = List.map parse_page_updates raw_updates in
  (rules, updates)

let validate_updates_with_rules = validate_update rules

let valid, invalid =
  List.partition_map
    (fun x -> if validate_updates_with_rules x then Left x else Right x)
    updates

let sumOfMiddles values =
  values
  |> List.map (fun x ->
         match x with
         | [||] -> raise InvariantBroken
         | x -> Array.length x / 2 |> Array.get x)
  |> List.fold_left ( + ) 0

let () =
  let _ =
    List.map Array.of_list valid
    |> sumOfMiddles
    |> Printf.printf "Solution 1: %d\n"
  in
  let _ =
    invalid
    |> List.map (fun x -> Array.of_list x |> fix_invalid rules)
    |> sumOfMiddles
    |> Printf.printf "Solution 2: %d\n"
  in
  ()

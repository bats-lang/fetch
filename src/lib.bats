(* fetch -- network fetch with promise-based async *)

#include "share/atspre_staload.hats"

#use array as A
#use promise as P
#use wasm.bats-packages.dev/bridge as B

#pub fun fetch
  {lb:agz}{n:pos}
  (url: !$A.borrow(byte, lb, n), url_len: int n)
  : $P.promise(int, $P.Pending)

#pub fun get_body_len(): int

#pub fun get_body
  {n:pos | n <= 1048576}
  (len: int n): [l:agz] $A.arr(byte, l, n)

implement fetch{lb}{n}(url, url_len) = let
  val @(p, r) = $P.create<int>()
  val id = $P.stash(r)
  val () = $B.fetch_req(url, url_len, id)
in p end

implement get_body_len() = $B.fetch_body_len()

implement get_body{n}(len) = $B.fetch_body(len)

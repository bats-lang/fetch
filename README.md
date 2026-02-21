# fetch

HTTP fetch bridge. Fetches a URL and resolves with the HTTP status code.
The response body is cached by the host and pulled into WASM memory on demand.

## API

```
#use wasm.bats-packages.dev/fetch as F
#use array as A
#use promise as P

(* Fetch a URL.
   Resolves with the HTTP status code (e.g. 200). *)
$F.fetch{lb:agz}{n:nat}
  (url: !A.borrow(byte, lb, n), url_len: int n)
  : promise(int, Pending)

(* Get the cached response body length.
   Call after fetch resolves. *)
$F.get_body_len() : int

(* Pull the response body into a fresh array.
   Call once after fetch resolves. *)
$F.get_body{len:pos}(len: int len) : [l:agz] A.arr(byte, l, len)
```

## Dependencies

- **array**
- **promise**

(lang dune 3.11)

(name cloq)

(generate_opam_files true)

(source
 (github ju-sh/cloq))

(authors "Julin Shaji")

(maintainers "Julin Shaji")

(license MIT)

(documentation https://github.com/ju-sh/cloq)

(package
 (name cloq)
 (synopsis "A clock using minttea")
 (description "A qclocktwo-style clock as a demo of minttea")
 (depends
   (minttea (>= 0.0.3))
    spices
    ppx_string
    ocaml
    dune)
;  (depends
;    (minttea (== 0.0.2))
;    (spices (== 0.0.2))
;    (ppx_string (== 0.17.0))
;    (dune (>= 3.17.0))
;    (ocaml (>= 5.2.1)))
 (tags
  (time text tui)))

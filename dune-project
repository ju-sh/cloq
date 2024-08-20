(lang dune 3.11)

(name clock)

(generate_opam_files true)

(source
 (github ju-sh/cloq))

(authors "Julin S")

(maintainers "Julin S")

(license MIT)

(documentation https://url/to/documentation)

(package
 (name clock)
 (synopsis "A short synopsis")
 (description "A longer description")
 (depends
   (minttea (>= 0.0.3))
    spices
    ppx_string
    ocaml dune)
 (tags
  (time clock text tui)))

(lang dune 3.11)

(name cloq)

(generate_opam_files true)

(source
 (github ju-sh/cloq))

(authors "Julin S")

(maintainers "Julin S")

(license MIT)

(documentation https://url/to/documentation)

(package
 (name cloq)
 (synopsis "A short synopsis")
 (description "A longer description")
 (depends
   (minttea (>= 0.0.3))
    spices
    ppx_string
    ocaml dune)
 (tags
  (time cloq text tui)))

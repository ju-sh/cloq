(lang dune 3.11)

(name clock)

(generate_opam_files true)

(source
 (github username/reponame))

(authors "Author Name")

(maintainers "Maintainer Name")

(license LICENSE)

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
  (topics "to describe" your project)))

#let project(title: "", body) = {
  set document(title: title)

  set text(font: "New Computer Modern", lang: "it")

  set par(justify: true)

  set page(numbering: "1")

  // alternate numbering needed to account for offset = 1 for headings
  let alt-numbering = (..args) => {
    let numbers = args.pos()
    if (numbers.len() > 1) {
      numbers = numbers.slice(1)
    }
    return numbering(
      "1.1.",
      ..numbers,
    )
  }

  set heading(
    numbering: alt-numbering,
    offset: 1,
  )

  set list(indent: 1.2em)
  set enum(indent: 1.2em)

  align(center + horizon)[
    #block(text(weight: 700, 4.05em, title))
  ]

  pagebreak()

  show heading.where(level: 1): it => {
    counter(heading).update(0)
    set page(footer: { })
    if it.numbering != none {
      set text(size: 20pt)
      align(
        center + horizon,
        "Parte " + numbering("I", int(it.numbering.at(0))) + [ --- ] + it.body,
      )
    }
  }

  // corrected size of offset headings
  show heading: it => {
    if (it.level > 1) {
      let multiplier = 1
      if (it.level == 2) {
        multiplier = 7 / 5
      } else if (it.level == 3) {
        multiplier = 6 / 5
      }
      text(size: 1em * multiplier, it)
    } else {
      it
    }
  }

  show outline.entry: it => context {
    if it.element.func() == figure {
      let res
      if it.element.numbering != none {
        res = link(
          it.element.location(),
          it.indented(it.prefix(), [--- ] + it.element.body + h(1fr) + it.page()),
        )
      } else {
        res = link(
          it.element.location(),
          it.indented(it.prefix(), it.element.body + h(1fr) + it.page()),
        )
      }

      v(2.3em, weak: true)
      strong(text(size: 16pt, res))
    } else if (it.level > 1) {
      link(
        it.element.location(),
        it.indented(
          it.prefix(),
          it.element.body + box(width: 1fr, repeat([.], gap: 0.15em)) + it.page(),
        ),
      )
    } else {
      it
    }
  }

  // assuming there is a "parte" function
  show outline.entry.where(level: 2): it => {
    v(12pt, weak: true)
    strong(it)
  }

  show figure.where(kind: "parte"): it => {
    counter(heading).update(0)
    set page(footer: { })
    if it.numbering != none {
      set text(size: 20pt)
      align(
        center + horizon,
        strong(it.supplement + [ ] + it.counter.display(it.numbering)) + [ --- ] + strong(it.body),
      )
    }
  }

  let toc = context {
    let target = (
      figure
        .where(
          kind: "parte",
          outlined: true,
        )
        .or(heading.where(outlined: true))
    )

    outline(
      indent: n => {
        if (n > 1) {
          (n - 1) * 2em
        } else {
          0em
        }
      },
      target: target,
    )
  }

  toc

  show link: underline

  body
}

// creo la figure "Parte", come fosse un teorema
#let parte(body, numbering: "I") = context figure(
  body,
  kind: "parte",
  numbering: numbering,
  // quando si fanno riferimenti con @
  supplement: "Parte",
  caption: [],
)

#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge

= CMSC 331: Homework #5
Carson Kegley\
Professor Chang\

= Problem 1: Create DFAs for the following three sets

== 1. A = { w | w is a string over {a, b}, has an even number of a’s and ends with b }

#let state(pos, name, accept: false) = node(
  pos, $q_#name$, name: label("q" + str(name)),
  shape: circle, extrude: if accept { (0, 3) } else { (0,) },
)

#diagram(
  node-stroke: 0.7pt,
  spacing: (4em, 3.5em),
  edge-stroke: 0.7pt,
  mark-scale: 90%,

  // Diamond: q0 left, q1 right, q3 top, q2 bottom
  state((0, 1), 0),
  state((2, 1), 1),
  state((1, 0), 3, accept: true),
  state((1, 2), 2),

  // Start arrow
  edge((-0.8, 1), <q0>, "-|>"),

  edge(<q0>, <q1>, "-|>", $a$, bend: 15deg),
  edge(<q1>, <q0>, "-|>", $a$, bend: 15deg),
  edge(<q0>, <q3>, "-|>", $b$),
  edge(<q3>, <q3>, "-|>", $b$, bend: 130deg),
  edge(<q3>, <q1>, "-|>", $a$),
  edge(<q1>, <q2>, "-|>", $b$, label-side: left),
  edge(<q2>, <q2>, "-|>", $b$, bend: -130deg),
  edge(<q2>, <q0>, "-|>", $a$, label-side: left),
)
== 2. B = { w | w is a string over {a, b} and has both aa and ba as substrings }
Note: the string abbaa is an element of B.

#let state(pos, name, accept: false) = node(
  pos, $q_#name$, name: label("q" + str(name)),
  shape: circle, extrude: if accept { (0, 3) } else { (0,) },
)

#diagram(
  node-stroke: 0.7pt,
  spacing: (4.5em, 3.5em),
  edge-stroke: 0.7pt,
  mark-scale: 90%,

  // Top row: found aa first, still need ba
  // Bottom row: seen a b, still need aa
  state((0, 1), 0),
  state((1, 0), 1), state((2, 0), 2), state((3, 0), 4),
  state((1, 2), 3), state((3, 2), 5),
  state((4, 1), 6, accept: true),

  // Start arrow
  edge((-0.7, 1), <q0>, "-|>"),

  edge(<q0>, <q1>, "-|>", $a$),
  edge(<q0>, <q3>, "-|>", $b$, label-side: right),

  // aa first
  edge(<q1>, <q2>, "-|>", $a$),
  edge(<q1>, <q3>, "-|>", $b$),
  edge(<q2>, <q2>, "-|>", $a$, bend: 130deg),
  edge(<q2>, <q4>, "-|>", $b$),
  edge(<q4>, <q4>, "-|>", $b$, bend: 130deg),
  edge(<q4>, <q6>, "-|>", $a$),

  // b seen, need aa
  edge(<q3>, <q3>, "-|>", $b$, bend: -130deg),
  edge(<q3>, <q5>, "-|>", $a$, bend: 15deg),
  edge(<q5>, <q3>, "-|>", $b$, bend: 15deg),
  edge(<q5>, <q6>, "-|>", $a$, label-side: right),

  // Accept (trap)
  edge(<q6>, <q6>, "-|>", $a, b$, bend: -130deg),
)



== 3. C = { w | w is a string over {a, b} and ends with bab }
#let state(pos, name, accept: false) = node(
  pos, $q_#name$, name: label("q" + str(name)),
  shape: circle, extrude: if accept { (0, 3) } else { (0,) },
)

#diagram(
  node-stroke: 0.7pt,
  spacing: (6em, 5em),
  edge-stroke: 0.7pt,
  mark-scale: 90%,

  // States arranged in a square, clockwise
  state((0, 0), 0),
  state((1, 0), 1),
  state((1, 1), 2),
  state((0, 1), 3, accept: true),

  // Start arrow
  edge((-0.6, 0), <q0>, "-|>"),

  edge(<q0>, <q0>, "-|>", $a$, bend: 130deg),
  edge(<q0>, <q1>, "-|>", $b$),
  edge(<q1>, <q1>, "-|>", $b$, bend: 130deg),
  edge(<q1>, <q2>, "-|>", $a$, label-side: left),
  edge(<q2>, <q0>, "-|>", $a$),
  edge(<q2>, <q3>, "-|>", $b$, label-side: left),
  edge(<q3>, <q0>, "-|>", $a, b$, label-side: left),
)


= Problem 2 Context-Free Grammars: Derivations

== 1. number * id / number + id - number * id

#let nt(x) = emph(x)   // nonterminals in italics
#let t(x) = raw(x)     // terminals in monospace

#align(center, diagram(
  spacing: (1.2em, 1.8em),

  // Level 1
  node((7, 0), nt[expr], name: <e0>),

  // Level 2
  node((5, 1), nt[expr], name: <e1>),
  node((7, 1), t("-"), name: <minus>),
  node((9, 1), nt[term], name: <t1>),

  // Level 3
  node((2.5, 2), nt[expr], name: <e2>),
  node((5, 2), t("+"), name: <plus>),
  node((6, 2), nt[term], name: <t2>),
  node((8, 2), nt[term], name: <t3>),
  node((9, 2), t("*"), name: <star2>),
  node((10, 2), nt[factor], name: <f1>),

  // Level 4
  node((2.5, 3), nt[term], name: <t4>),
  node((6, 3), nt[factor], name: <f2>),
  node((8, 3), nt[factor], name: <f3>),
  node((10, 3), t("id"), name: <id3>),

  // Level 5
  node((1, 4), nt[term], name: <t5>),
  node((3, 4), t("/"), name: <div>),
  node((4, 4), nt[factor], name: <f4>),
  node((6, 4), t("id"), name: <id2>),
  node((8, 4), t("number"), name: <num3>),

  // Level 6
  node((0, 5), nt[term], name: <t6>),
  node((1, 5), t("*"), name: <star1>),
  node((2, 5), nt[factor], name: <f5>),
  node((4, 5), t("number"), name: <num2>),

  // Level 7
  node((0, 6), nt[factor], name: <f6>),
  node((2, 6), t("id"), name: <id1>),

  // Level 8
  node((0, 7), t("number"), name: <num1>),

  // expr -> expr - term
  edge(<e0>, <e1>), edge(<e0>, <minus>), edge(<e0>, <t1>),
  // expr -> expr + term
  edge(<e1>, <e2>), edge(<e1>, <plus>), edge(<e1>, <t2>),
  // expr -> term
  edge(<e2>, <t4>),
  // term -> term / factor
  edge(<t4>, <t5>), edge(<t4>, <div>), edge(<t4>, <f4>),
  // term -> term * factor
  edge(<t5>, <t6>), edge(<t5>, <star1>), edge(<t5>, <f5>),
  // term -> factor -> number
  edge(<t6>, <f6>), edge(<f6>, <num1>),
  // factor -> id
  edge(<f5>, <id1>),
  // factor -> number
  edge(<f4>, <num2>),
  // term -> factor -> id
  edge(<t2>, <f2>), edge(<f2>, <id2>),
  // term -> term * factor
  edge(<t1>, <t3>), edge(<t1>, <star2>), edge(<t1>, <f1>),
  // term -> factor -> number
  edge(<t3>, <f3>), edge(<f3>, <num3>),
  // factor -> id
  edge(<f1>, <id3>),
))


== 2. ( id - - number ) $*$ ( - id + number )
// Parse tree for: ( id - - number ) * ( - id + number )
#let nt(x) = emph(x)   // nonterminals in italics
#let t(x) = raw(x)     // terminals in monospace

#align(center, diagram(
  spacing: (1.2em, 1.8em),

  // Level 1
  node((6, 0), nt[expr], name: <e0>),

  // Level 2
  node((6, 1), nt[term], name: <t0>),

  // Level 3
  node((2.5, 2), nt[term], name: <t1>),
  node((6, 2), t("*"), name: <star>),
  node((9.5, 2), nt[factor], name: <f0>),

  // Level 4
  node((2.5, 3), nt[factor], name: <f1>),
  node((7, 3), t("("), name: <lp2>),
  node((10, 3), nt[expr], name: <e3>),
  node((12, 3), t(")"), name: <rp2>),

  // Level 5
  node((0, 4), t("("), name: <lp1>),
  node((2, 4), nt[expr], name: <e1>),
  node((5, 4), t(")"), name: <rp1>),
  node((8.5, 4), nt[expr], name: <e4>),
  node((10, 4), t("+"), name: <plus>),
  node((11, 4), nt[term], name: <t5>),

  // Level 6
  node((1, 5), nt[expr], name: <e2>),
  node((2, 5), t("-"), name: <minus1>),
  node((3.5, 5), nt[term], name: <t3>),
  node((8.5, 5), nt[term], name: <t4>),
  node((11, 5), nt[factor], name: <f6>),

  // Level 7
  node((1, 6), nt[term], name: <t2>),
  node((3.5, 6), nt[factor], name: <f3>),
  node((8.5, 6), nt[factor], name: <f5>),
  node((11, 6), t("number"), name: <num2>),

  // Level 8
  node((1, 7), nt[factor], name: <f2>),
  node((3, 7), t("-"), name: <minus2>),
  node((4, 7), nt[factor], name: <f4>),
  node((8, 7), t("-"), name: <minus3>),
  node((9, 7), nt[factor], name: <f7>),

  // Level 9
  node((1, 8), t("id"), name: <id1>),
  node((4, 8), t("number"), name: <num1>),
  node((9, 8), t("id"), name: <id2>),

  // expr -> term
  edge(<e0>, <t0>),
  // term -> term * factor
  edge(<t0>, <t1>), edge(<t0>, <star>), edge(<t0>, <f0>),

  // Left side: term -> factor -> ( expr )
  edge(<t1>, <f1>),
  edge(<f1>, <lp1>), edge(<f1>, <e1>), edge(<f1>, <rp1>),
  // expr -> expr - term
  edge(<e1>, <e2>), edge(<e1>, <minus1>), edge(<e1>, <t3>),
  // expr -> term -> factor -> id
  edge(<e2>, <t2>), edge(<t2>, <f2>), edge(<f2>, <id1>),
  // term -> factor -> - factor -> number
  edge(<t3>, <f3>),
  edge(<f3>, <minus2>), edge(<f3>, <f4>), edge(<f4>, <num1>),

  // Right side: factor -> ( expr )
  edge(<f0>, <lp2>), edge(<f0>, <e3>), edge(<f0>, <rp2>),
  // expr -> expr + term
  edge(<e3>, <e4>), edge(<e3>, <plus>), edge(<e3>, <t5>),
  // expr -> term -> factor -> - factor -> id
  edge(<e4>, <t4>), edge(<t4>, <f5>),
  edge(<f5>, <minus3>), edge(<f5>, <f7>), edge(<f7>, <id2>),
  // term -> factor -> number
  edge(<t5>, <f6>), edge(<f6>, <num2>),
))


= Problem 3: Context-Free Grammars: Create
== 1 
S = aSb | A | B\
A = aA | a\
B = bB | b\

== 2 
S = aSb| aSa | bSa | bSb | a



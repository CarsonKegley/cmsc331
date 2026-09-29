#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge

= CMSC 331: Homework #5
Carson Kegley\
Professor Chang\
= Problem #1


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
= Problem #2
#let state(pos, name, accept: false) = node(
  pos, $q_#name$, name: label("q" + str(name)),
  shape: circle, extrude: if accept { (0, 3) } else { (0,) },
)

#diagram(
  node-stroke: 0.7pt,
  spacing: (4.5em, 3.5em),
  edge-stroke: 0.7pt,
  mark-scale: 90%,

  // States: A path on top, B path on bottom
  state((0, 1), 0),
  state((1, 0), 1), state((2, 0), 2), state((3, 0), 3), state((4, 0), 4, accept: true),
  state((1, 2), 5), state((2, 2), 6), state((3, 2), 7), state((4, 2), 8, accept: true),

  // Start arrow
  edge((-0.7, 1), <q0>, "-|>"),

  // q0
  edge(<q0>, <q1>, "-|>", $a$),
  edge(<q0>, <q5>, "-|>", $b$, label-side: right),

  // A path
  edge(<q1>, <q2>, "-|>", $a$),
  edge(<q1>, <q5>, "-|>", $b$),
  edge(<q2>, <q2>, "-|>", $a$, bend: 130deg),
  edge(<q2>, <q3>, "-|>", $b$),
  edge(<q3>, <q3>, "-|>", $b$, bend: 130deg),
  edge(<q3>, <q4>, "-|>", $a$),
  edge(<q4>, <q4>, "-|>", $a, b$, bend: 130deg),

  // B path
  edge(<q5>, <q5>, "-|>", $b$, bend: -130deg),
  edge(<q5>, <q6>, "-|>", $a$, label-side: right),
  edge(<q6>, <q6>, "-|>", $b$, bend: -130deg),
  edge(<q6>, <q7>, "-|>", $a$, label-side: right),
  edge(<q7>, <q6>, "-|>", $b$, bend: -35deg, label-side: right),
  edge(<q7>, <q8>, "-|>", $a$, label-side: right),
  edge(<q8>, <q8>, "-|>", $a, b$, bend: -130deg),
)



= Problem 3
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

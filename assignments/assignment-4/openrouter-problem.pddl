(define (problem robot_problem)
  (:domain robot)

  (:objects
    l0 l1 l2 l3 l4 l5 l6 l7 l8 l9 - Location
  )

  (:init
    ;; initial robot location
    (robot_at l0)
    ;; linear connections l0–l1, l1–l2, …, l8–l9
    (connected l0 l1)
    (connected l1 l2)
    (connected l2 l3)
    (connected l3 l4)
    (connected l4 l5)
    (connected l5 l6)
    (connected l6 l7)
    (connected l7 l8)
    (connected l8 l9)
  )

  ;; goal: reach the last location
  (:goal
    (robot_at l9)
  )
)

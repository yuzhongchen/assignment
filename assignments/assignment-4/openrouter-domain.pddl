(define (domain robot)
  (:requirements :typing :strips)
  (:types
    Location
  )

  (:predicates
    ;; robot position
    (robot_at ?l - Location)
    ;; connectivity between locations
    (connected ?l_from - Location ?l_to - Location)
  )

  (:action move
    :parameters (?l_from - Location ?l_to - Location)
    :precondition (and
      (robot_at ?l_from)
      (connected ?l_from ?l_to)
    )
    :effect (and
      (not (robot_at ?l_from))
      (robot_at ?l_to)
    )
  )
)

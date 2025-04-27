(define (domain openrouter)
  (:requirements :typing :fluents :durative-actions)
  (:types
    model provider capability request account
  )

  (:predicates
    (provided-by ?m - model ?p - provider)
    (supports     ?m - model ?c - capability)
    (request-needs ?r - request ?c - capability)
    (routed       ?r - request ?m - model)
  )

  (:functions
    (model-context-limit    ?m - model)        ; max tokens in context
    (model-cost-prompt      ?m - model)        ; $ per million prompt tokens
    (model-cost-completion  ?m - model)        ; $ per million completion tokens
    (account-credit         ?a - account)      ; remaining $ credits
    (request-context-size   ?r - request)      ; required context tokens
    (request-prompt-tokens  ?r - request)      ; prompt tokens needed
    (request-completion-tokens ?r - request)   ; completion tokens needed
  )

  (:durative-action route-request
     :parameters (?r - request ?m - model ?a - account)
     :duration (= ?duration 1)
     :condition (and
       (at start (not (routed ?r ?m)))
       (at start (forall (?c - capability)
                    (imply (request-needs ?r ?c)
                           (supports ?m ?c))))
       (at start (>= (model-context-limit ?m)
                     (request-context-size ?r)))
       (at start (>= (account-credit ?a)
                     (+ (* (/ (request-prompt-tokens ?r) 1000000)
                           (model-cost-prompt ?m))
                        (* (/ (request-completion-tokens ?r) 1000000)
                           (model-cost-completion ?m)))))
     )
     :effect (and
       (at end (routed ?r ?m))
       (at end (decrease (account-credit ?a)
               (+ (* (/ (request-prompt-tokens ?r) 1000000)
                     (model-cost-prompt ?m))
                  (* (/ (request-completion-tokens ?r) 1000000)
                     (model-cost-completion ?m)))))
     )
  )
)

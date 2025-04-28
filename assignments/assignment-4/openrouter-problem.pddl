(define (problem route-code-request)
  (:domain openrouter)
  (:objects
    deepseek-r1 free-model - model
    or-provider            - provider
    coding multilingual    - capability
    user-account           - account
    req1                   - request
  )

  (:init
    ;; Model <– Provider
    (provided-by deepseek-r1 or-provider)

    ;; Capabilities
    (supports deepseek-r1 coding)
    (supports deepseek-r1 multilingual)

    ;; Model specs
    (= (model-context-limit deepseek-r1)    163840)
    (= (model-cost-prompt deepseek-r1)       0.0)
    (= (model-cost-completion deepseek-r1)   0.0)

    ;; Account budget
    (= (account-credit user-account)        0.10)

    ;; Request requirements
    (request-needs req1 coding)
    (= (request-context-size req1)          2000)
    (= (request-prompt-tokens req1)         1000)
    (= (request-completion-tokens req1)     500)
  )

  (:goal (exists (?m - model) (routed req1 ?m)))
)

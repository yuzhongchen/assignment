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
    ;; Providers
    (provided-by deepseek-r1 or-provider)          
    ;; Capabilities
    (supports deepseek-r1 coding)
    (supports deepseek-r1 multilingual)
    ;; Model specs from OpenRouter (DeepSeek R1 free)  
    (= (model-context-limit deepseek-r1) 163840)    ; tokens :contentReference[oaicite:3]{index=3}
    (= (model-cost-prompt deepseek-r1)   0.0)       ; $/M prompt :contentReference[oaicite:4]{index=4}
    (= (model-cost-completion deepseek-r1) 0.0)     ; $/M completion :contentReference[oaicite:5]{index=5}

    ;; Account budget (e.g., user deposited $0.10) 
    (= (account-credit user-account) 0.10)

    ;; Request requirements
    (request-needs req1 coding)
    (= (request-context-size req1) 2000)            ; tokens
    (= (request-prompt-tokens req1) 1000)
    (= (request-completion-tokens req1) 500)
  )

  (:goal (exists (?m - model) (routed req1 ?m)))
)

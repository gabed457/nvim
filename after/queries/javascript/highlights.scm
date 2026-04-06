; extends

; Method calls: foo.bar()
(call_expression
  function: (member_expression
    property: (property_identifier) @function.method.call))

; Regular function calls: foo()
(call_expression
  function: (identifier) @function.call)

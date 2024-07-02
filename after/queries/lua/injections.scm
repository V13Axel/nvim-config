;; extends

((comment
   content: (_) @injection.trigger
   (#lua-match? @injection.trigger ";;scheme")
   (#set! injection.language "scheme"))
 (block
   (variable_declaration
     (assignment_statement
       (variable_list) 
       (expression_list
         (string
           (string_content) @injection.content))))))
